pipeline {

    agent {label 'aws'}

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
                    s3Download bucket: 'web-app-bucket-gal', file: "${env.JOB_NAME}/terraform.tfvars.json", path: "${env.JOB_NAME}/terraform.tfvars.json"
                }
            }
        }

        // this stage init terraform
        stage ('terraform init') {
            steps {
                dir("${env.JOB_NAME}") {
                    sh 'terraform init'
                }
            }
        }

        // this stage init terraform
        stage ('terraform apply') {
            steps {
                sh 'cp -f inventorybase inventory'
                sh 'cp -f deploybase.yml deploy.yml'
                dir("${env.JOB_NAME}") {
                    sh 'terraform apply --auto-approve'
                }
            }
        }

        stage ('s3Upload ansible vars') {
          steps {
            withAWS(region:'us-east-1',credentials:'awsCredentials') {
              s3Upload bucket: "web-app-bucket-gal/${env.JOB_NAME}", workingDir:'', includePathPattern:'inventory'
              s3Upload bucket: "web-app-bucket-gal/${env.JOB_NAME}", workingDir:'', includePathPattern:'deploy.yml'
              }
             }
          }
    }
}
