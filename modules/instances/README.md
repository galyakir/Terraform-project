## groups module
this module create 3 EC2 instances

**To use this module you must provide:**

`ami` : string EC2 image

`tag_name` : string tag name

`keyname` : string SSH key name

`subnets` : list of 3 subnets

`ec2_type` : string of EC2 type

`Web_app_sg_id` : string of security group id

**Module output:**

`first_instance` : first instance 

`second_instance` : second instance 

`third_instance` : third instance 



