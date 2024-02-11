import java.text.SimpleDateFormat
import java.util.Date

def date = new Date()
def dateStamp = new SimpleDateFormat("yyyy-MM-dd").format(date)
def clusterName = "rosatest-${dateStamp}"
echo "Cluster Name: ${clusterName}"

pipeline {  
    agent any
  
    environment {
        ROSA_TOKEN =  credentials('aws-token-rosa') 
    }

    stages { 
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                /*sh """
                    pwd
                    ls
                    env
                """.stripIndent()*/ 
            }
        }
        // Add more stages as needed for your pipeline sdfgsgfds
        stage('Create AWS Cluster') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE'){
                    sh "ansible-playbook ansible/rosa-cluster-create-operations.yml -e 'cluster_name=${clusterName}' -e credentials_file=NONE -e token='${ROSA_TOKEN}'  "
                }
            }
        }       
    }
}