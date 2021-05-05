pipeline {

    agent {label 'aws'}
    environment {
            env = 'true'
            DB_ENGINE    = 'sqlite'
        }
    stages {

        // this stage clean the environment
        stage ('checkout') {
            steps{
                cleanWs()
                checkout scm
            }
       }

        // this stage download variables file for terraform from S3
        stage ('S3 download tfvars') {
            steps {
                withAWS(region:'us-east-1',credentials:'awsCredentials') {
                    s3Download bucket: 'web-app-bucket-gal', file: '{env}/terraform.tfvars.json', path: '{env}/terraform.tfvars.json'
                }
            }
        }

        // this stage init terraform
        stage ('{env} - terraform init') {
            steps {
                dir("staging") {
                    sh 'terraform init'
                }
            }
        }

        // this stage init terraform
        stage ('{env} - terraform apply') {
            steps {
                sh 'cp -f inventorybase inventory'
                sh 'cp -f deploybase.yml deploy.yml'
                dir("staging") {
                    sh 'terraform apply --auto-approve'
                }
            }
        }

        stage ('{env} - update ansible vars to S3') {
          steps {
            withAWS(region:'us-east-1',credentials:'awsCredentials') {
              s3Upload bucket: "web-app-bucket-gal/staging/", workingDir:'', includePathPattern:'inventory deploy.yml'
              }
             }
          }
    }
}
