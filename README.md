# Terraform project

This terraform project will initialize all the resources for the WeightTracker App
to be high available with auto scaling for 1 - 3 EC2 instances.



**main.tf:**

Contains those resources : `aws_lb, aws_db_instance, launch_configuration` 

**output.tf:**

Output of dns of the app, ec2 user name and password.

**update.sh:**

Simple bash script to deploy WeightTracker app automatically


