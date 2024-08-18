vpc_name            = "my-vpc"
cidr_block          = "10.0.0.0/16"
public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones  = ["us-east-1a", "us-east-1b"] #For EAST1
region              = "us-east-1" #For EAST1
ami_id        = "ami-04a81a99f5ec58529" #For EAST1
instance_type = "t2.medium"

#ami_id        = "ami-0aff18ec83b712f05" #For WEST2
#availability_zones  = ["us-west-2a", "us-west-2b"] #For WEST2
#region              = "us-west-2" #For WEST2

db_name         = "mydb"
db_username     = "admin"
db_password     = "TW5pdm5lcHNAMjEwOQ==" # Use a secure method to store passwords
#key_name        = "neppoliean_joe"