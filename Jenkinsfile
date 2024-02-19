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
                    env
                """.stripIndent()
            }
        }
        // Ansible Check
        stage('Ansible Install and Check') {
            steps {
                sh """
                    sudo yum install ansible
                    ansible --version
                    """.stripIndent()  
            }
        }
        // Rosa Login
        stage('ROSA Install and Login') {
            steps { 
                sh """
                    wget https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz
                    tar xvf rosa-linux.tar.gz 
                    sudo mv rosa /usr/local/bin/rosa
                    rosa version
                    rosa login -t '${ROSA_TOKEN}'
                    """.stripIndent()    
            }
        }
    }
}