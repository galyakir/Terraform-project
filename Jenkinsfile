pipeline{

agent {node 'aws'}

stages{
    stage('checkout') {
        steps{
            script{
                  cleanWs()
                  checkout scm
            }
        }
    }
    stage('download from S3 ') {
     steps{
      script{
       withAWS(region:'us-east-1',credentials:'awsCredentials')\{
          s3Download bucket: 'web-app-bucket-gal', file: 'terraform.tfvars.json', path: 'terraform.tfvars.json'
           }
         }
       }
     }
    stage('init') {
            steps{
                script{
                      sh 'terraform init'
                }
            }
        }
    stage('apply') {
      steps{
       script{
         sh 'terraform apply -auto-approve'
         }
       }
     }
    }
  }
}
