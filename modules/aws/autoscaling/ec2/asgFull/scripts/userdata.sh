#!/bin/bash

DEBUG=$${DEBUG:=off}

if [ $${DEBUG} == 'on' ]; then
    set -x
fi

# Software packages:
yum install -y awslogs vim jq unzip wget tree git

#!/bin/bash

DEBUG=$${DEBUG:=off}

if [ $${DEBUG} == 'on' ]; then
    set -x
fi

instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id | cut -d "-" -f 2)
container_instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

# Force the update.
yum update -y

# Software packages:
yum install -y awslogs vim jq unzip wget tree git