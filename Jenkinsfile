pipeline {

 agent {label 'aws'}
stages{

// this stage clean the environment
 stage ('checkout'){
   steps{
		cleanWs()
		checkout scm
        }
       }

// this stage download variables file for terraform from S3
 stage ('S3download'){
   steps{
                  withAWS(region:'us-east-1',credentials:'awsCredentials')\
                                    {
                                        s3Download bucket: 'web-app-bucket-gal', file: 'terraform.tfvars.json', path: 'terraform.tfvars.json'
                                    }
        }
       }

// this stage init terraform
 stage ('init'){
   steps{
				  sh 'terraform init'
        }
       }

// this stage destroy auto_scaling module so the user_date will update
stage ('destroy'){
   steps{
         sh 'terraform destroy -target module.auto_scaling -auto-approve'
        }
       }

// this stage apply terraform
  stage ('apply'){
   steps{
				   sh 'terraform apply -auto-approve'
        }
       }
 }
}
