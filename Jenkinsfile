
// Jenkinsfile
pipeline{
agent {label 'aws'}

stages{
  stage('checkout') {
    steps{
    script {
      cleanWs()
      checkout scm
     }
    }
  }

    stage('S3download'){
              steps {
                   script {
                  withAWS(region:'us-east-1',credentials:'awsCredentials')\
                  {
                    s3Download bucket: 'web-app-bucket-gal', file: 'terraform.tfvars.json', path: 'terraform.tfvars.json'
                  }
              }
          }
          }

      stage('plan'){
              steps {
                   script {
                  withAWS(region:'us-east-1',credentials:'awsCredentials')\
                  {
                       sh 'terraform plan'
                  }
              }
          }
          }

          stage('apply and deploy')
          {
              steps {
               script {
                  withAWS(region:'us-east-1',credentials:'awsCredentials')\
                    {
                     sh 'terraform apply -auto-approve'
                    }
              }
          }
          }
}
}
}












