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
                    env 
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
    }
}