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
    }

    stages { 
        // Checkout code from Git repository
        stage('Enviroment Variables') {
            steps {
                sh """
                    pwd
                    ls  
                    aws --version
                """.stripIndent()
            }
        }
        // Ansible Check
        stage('Ansible Install and Check') {
            steps {
                sh """
                    sudo -S yum install ansible -y
                    ansible --version
                    """.stripIndent()  
            }
        }
    }
}