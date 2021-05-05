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
                    s3Download bucket: 'web-app-bucket-gal', file: 'staging/terraform.tfvars.json', path: 'staging/terraform.tfvars.json'
                    s3Download bucket: 'web-app-bucket-gal', file: 'prod/terraform.tfvars.json', path: 'prod/terraform.tfvars.json'
                }
            }
        }

        // this stage init terraform
        stage ('staging - terraform init') {
            steps {
                dir("staging") {
                    sh 'terraform init'
                }
            }
        }

        // this stage init terraform
        stage ('staging - terraform apply') {
            steps {
                sh 'cp -f inventorybase inventory'
                sh 'cp -f deploybase.yml deploy.yml'
                dir("staging") {
                    sh 'terraform apply --auto-approve'
                }
            }
        }

        stage ('staging - update vars to S3') {
                    steps {
                       withAWS(region:'us-east-1',credentials:'awsCredentials') {
                         s3Upload bucket: "web-app-bucket-gal/staging/", workingDir:'', includePathPattern:'inventory deploy.yml'
                       }
                    }
                }



        // deploy application to staging
        //stage ('staging - deploy') {
         //   steps {
         //           sh 'ansible-playbook deploy.yml'
         //   }
       // }

        // Deploy approval
        stage('Deploy approval'){
           steps{
                input "Deploy to prod?"
           }
        }

        // this stage init terraform at prod
        stage ('prod - terraform init') {
            steps {
                dir("prod") {
                    sh 'terraform init'
                }
            }
        }

        // this stage apply terraform
        stage ('prod - terraform apply') {
            steps {
                sh 'cp -f inventorybase inventory'
                sh 'cp -f deploybase.yml deploy.yml'
                dir("prod") {
                    sh 'terraform apply --auto-approve'
                }
            }
        }

         stage ('prod - update vars to S3') {
           steps {
             withAWS(region:'us-east-1',credentials:'awsCredentials') {
               s3Upload bucket: "web-app-bucket-gal/prod/", workingDir:'', includePathPattern:'inventory deploy.yml'
                }
             }
           }

       // deploy application to prod
        // stage ('prod - deploy') {
      //      steps {
        //            sh 'ansible-playbook deploy.yml'
      //      }
      //  }
    }
}
