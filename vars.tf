#-----------------------------------------------------------------------------------
# default VPC and Subnets
#-----------------------------------------------------------------------------------
variable "subnet" {
    type = list(string)
    description = "The subnets of default vpc"
    default = ["subnet-01cc2370e79e5cce1","subnet-0cd80ed7a5f0b0988","subnet-071b7987e07941b40","subnet-00536a405c79561ac","subnet-0acb983c48e7e84c8","subnet-0247415bc23d1a7d8"]
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

#------------------------------------------------------------------------------------
# Kubernetes instance information
#------------------------------------------------------------------------------------
variable "instance_user" {
  description = "The user account to use on the instances to run the scripts."
  default     = "ubuntu"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default     = "uchekey1"
}

variable "master_instance_type" {
  description = "The instance type to use for the Kubernetes master."
  default     = "t3.medium"
}

variable "node_instance_type" {
  description = "The instance type to use for the Kubernetes nodes."
  default     = "t3.medium"
}

variable "node_count" {
  description = "The number of nodes in the cluster."
  default     = "2"
}

variable "private_key_path" {
  description = "The private key for connection to the instances as the user. Corresponds to the key_name variable."
  default     = "~/.ssh/uchekey1.pem"
}