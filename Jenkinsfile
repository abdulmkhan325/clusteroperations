import java.text.SimpleDateFormat
import java.util.Date 

def date = new Date()
def dateStamp = new SimpleDateFormat("yyyy-MM-dd").format(date)
def clusterName = "rosa-${dateStamp}"
echo "Cluster Name: ${clusterName}"

pipeline {  
    agent any
  
    environment {
        ROSA_TOKEN =  credentials('aws-token-rosa') 
        AWS_CREDENTIALS_ID = 'aws-majid-v2'
    }

    stages { 
        // Checkout code from Git repository
        stage('Enviroment Variables') {
            steps {
                sh """
                    ls
                """.stripIndent()
            }
        }
        // Check sudo permissions for jenkins
        stage('Check sudo privileage') {
            steps { 
                sh """
                    whoami
                    sudo ls
                """
            }
        }
        // Upgrade yum Package Manager
        stage('Yum Upgrade') { 
            steps {
                sh """  
                    sudo yum upgrade -y
                    yum --version
                """.stripIndent()  
            }
        } 
        // Ansible Install and Check
        stage('Ansible Install and Check') {
            steps {
                sh """
                    sudo yum install ansible -y
                    ansible --version
                    """.stripIndent()  
            }
        }
        // Rosa Download and Install
        stage('ROSA Download and Install') {
            steps {
                script {
                    // Check if rosa command exists
                    def rosaCommand = sh(script: 'rosa', returnStatus: true)  
                    println "this is print ln output = ${rosaCommand}"
                    if (rosaCommand == 127) {
                        sh """
                            wget https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz
                            tar xvf rosa-linux.tar.gz 
                            sudo mv rosa /usr/local/bin/rosa
                           """.stripIndent()
                    } else {
                        sh "rosa version"
                    }
                }
            }  
        } 
        // Rosa Login
        stage('ROSA Login') {
            steps {
                withCredentials([[ 
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "${AWS_CREDENTIALS_ID}",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh """  
                        rosa login --region=ap-southeast-2 --token="${ROSA_TOKEN}"
                        rosa whoami --region=ap-southeast-2
                    """.stripIndent()
                }
            }
        }  
    }
}