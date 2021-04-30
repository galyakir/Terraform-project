pipeline {

    agent any
    stages {

        // this stage clean the environment
        stage ('checkout') {
            steps{
                cleanWs()
            }
       }

        // this stage download variables file for terraform from S3
        stage ('S3 download tfvars') {
            steps {
                withAWS(region:'us-east-1',credentials:'awsCredentials') {
                    s3Download bucket: 'web-app-bucket-gal', file: 'staging/terraform.tfvars.json', path: 'staging/terraform.tfvars.json'
                    s3Download bucket: 'web-app-bucket-gal', file: 'prod/terraform.tfvars.json', path: 'prod/terraform.tfvars.json'
                }
            }
        }

        // this stage init terraform
        stage ('staging - terraform init & apply') {
            steps {
                dir("staging") {
                    sh 'terraform init & terraform apply --auto-approve'
                }
            }
        }

        // deploy application to staging
        stage ('staging - deploy') {
            steps {
                dir("staging") {
                    sh 'ansible-playbook staging.yml'
                }
            }
        }

        // Deploy approval
        stage('Deploy approval'){
           steps{
                input "Deploy to prod?"
           }
        }

        // this stage init terraform
        stage ('prod - terraform init & apply') {
            steps {
                dir("prod") {
                    sh 'terraform init & terraform apply --auto-approve'
                }
            }
        }

        // deploy application to staging
        stage ('prod - deploy') {
            steps {
                dir("prod") {
                    sh 'ansible-playbook prod.yml'
                }
            }
        }
    }
}
