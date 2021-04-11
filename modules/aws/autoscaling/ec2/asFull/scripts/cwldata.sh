#!/bin/bash

DEBUG=$${DEBUG:=off}

if [ $${DEBUG} == 'on' ]; then
    set -x
fi

instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id | cut -d "-" -f 2)
ami_architecture=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document/ | jq  -r ".architecture")
az=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
region="$${az::-1}"
log_group="${log_group}"

###########################################
# Install/configure cloudwatch logs agent #
###########################################
systemctl enable awslogsd.service
systemctl stop awslogsd


mv /etc/awslogs/awslogs.conf{,.old}
mv /etc/awslogs/awscli.conf{,.old}

cat <<EOF >/etc/awslogs/awscli.conf
[plugins]
cwlogs = cwlogs
[default]
region = $${region}
EOF

cat <<EOF >/etc/awslogs/awslogs.conf
[general]
state_file = /etc/awslogs/agent-state

[/var/log/awslogs.log.log]
file = /var/log/awslogs.log
log_group_name = ${log_group}
log_stream_name = {instance_id}/awslogs

[/var/log/cron]
file = /var/log/cron
log_group_name = ${log_group}
log_stream_name = {instance_id}/cron

[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = ${log_group}
log_stream_name = {instance_id}/dmesg

[/var/log/messages]
file = /var/log/messages
log_group_name = ${log_group}
log_stream_name = {instance_id}/messages
datetime_format = %b %d %H:%M:%S

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = ${log_group}
log_stream_name = {instance_id}/audit
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/secure]
file = /var/log/secure*
log_group_name = ${log_group}
log_stream_name = {instance_id}/secure
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/cloud-init.log]
file = /var/log/cloud-init.log*
log_group_name = ${log_group}
log_stream_name = {instance_id}/cloud-init.log
datetime_format = %Y-%m-%dT%H:%M:%SZ

[/var/log/cloud-init-output.log]
file = /var/log/cloud-init-output.log*
log_group_name = ${log_group}
log_stream_name = {instance_id}/cloud-init-output.log
datetime_format = %Y-%m-%dT%H:%M:%SZ
EOF

# Enable Cloudwatch agent advanced metrics

curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/linux/$${ami_architecture}/latest/AmazonCloudWatchAgent.zip
unzip AmazonCloudWatchAgent.zip
./install.sh

cat <<EOF >./awslogs.json
{
	"metrics": {
		"append_dimensions": {
			"AutoScalingGroupName": "$${aws:AutoScalingGroupName}",
			"ImageId": "$${aws:ImageId}",
			"InstanceId": "$${aws:InstanceId}",
			"InstanceType": "$${aws:InstanceType}"
		},
		"metrics_collected": {
			"cpu": {
				"measurement": [
					"cpu_usage_idle",
					"cpu_usage_iowait",
					"cpu_usage_user",
					"cpu_usage_system"
				],
				"metrics_collection_interval": 10,
				"resources": [
					"*"
				],
				"totalcpu": false
			},
			"disk": {
				"measurement": [
					"used_percent",
					"inodes_free"
				],
				"metrics_collection_interval": 10,
				"resources": [
					"*"
				]
			},
			"diskio": {
				"measurement": [
					"io_time",
					"write_bytes",
					"read_bytes",
					"writes",
					"reads"
				],
				"metrics_collection_interval": 10,
				"resources": [
					"*"
				]
			},
			"mem": {
				"measurement": [
					"mem_used_percent"
				],
				"metrics_collection_interval": 10
			},
			"netstat": {
				"measurement": [
					"tcp_established",
					"tcp_time_wait"
				],
				"metrics_collection_interval": 10
			},
			"swap": {
				"measurement": [
					"swap_used_percent"
				],
				"metrics_collection_interval": 10
			}
		}
	},
  	"logs": {
    	"logs_collected": {
      	"files": {
        	"collect_list": [
          {
            	"file_path": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
            	"log_group_name": "${log_group}",
            	"log_stream_name": "$${aws:InstanceId}/amazon-cloudwatch-agent.log",
            	"timezone": "Local"
          }
        ]
      }
    },
    "log_stream_name": "$${aws:InstanceId}/amazon-cloudwatch-agent.log"
  }
}
EOF


/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:./awslogs.json -s

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start -m auto -c default

systemctl start awslogsd

