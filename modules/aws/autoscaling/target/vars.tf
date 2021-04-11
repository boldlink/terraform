variable "max_capacity" {
  description = "Specify max capacity to scale to"
  default     = ""
}

variable "min_capacity" {
  description = "The initial value to start with and fall back when scaling down"
  default     = ""
}

/*
"service/{clusterName}/{serviceName}" when you are scaling an ECS service 
"table/{tableName}" when you are scaling a table
"table/{tableName}/index/{indexName}" when you are scaling index
*/

variable "resource_id" {
  description = "The resrouce id, see above"
  default     = ""
}

variable "role_arn" {
  description = "The iam role you assign for scaling, limit to the resources which will be scaled"
  default     = ""
}

/*
ecs:service:DesiredCount - The desired task count of an ECS service.
ec2:spot-fleet-request:TargetCapacity - The target capacity of a Spot fleet request.
elasticmapreduce:instancegroup:InstanceCount - The instance count of an EMR Instance Group.
appstream:fleet:DesiredCapacity - The desired capacity of an AppStream 2.0 fleet.
dynamodb:table:ReadCapacityUnits - The provisioned read capacity for a DynamoDB table.
dynamodb:table:WriteCapacityUnits - The provisioned write capacity for a DynamoDB table.
dynamodb:index:ReadCapacityUnits - The provisioned read capacity for a DynamoDB global secondary index.
dynamodb:index:WriteCapacityUnits - The provisioned write capacity for a DynamoDB global secondary index.
rds:cluster:ReadReplicaCount - The count of Aurora Replicas in an Aurora DB cluster. Available for Aurora MySQL-compatible edition.
*/
variable "scalable_dimension" {
  description = "The scalable dimension of the scalable target"
  default     = ""
}

variable "service_namespace" {
  description = "ecs | elasticmapreduce | ec2 | appstream | dynamodb | rds"
  default     = ""
}

