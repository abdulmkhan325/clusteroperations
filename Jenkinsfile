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
                sh """
                    pwd
                    ls
                    env
                """.stripIndent()
            }
        }
        // Ansible Check
        stage('Ansible Check') {
            steps { 
                sh "ansible --version"    
            }
        }
        // Rosa Login
        stage('ROSA Installation and Login') {
            steps { 
                sh "wget https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz
                    tar xvf rosa-linux.tar.gz
                    sudo mv rosa /usr/local/bin/rosa
                    rosa version
                    rosa login -t '${ROSA_TOKEN}'"    
            }
        }
        // Create AWS Cluster
        stage('Create AWS ROSA Cluster') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE'){
                    sh "ansible-playbook ansible/rosa-cluster-create-operations.yml -e 'cluster_name=${clusterName}' -e token='${ROSA_TOKEN}'"
                }
            }
        }
        // Delete AWS Cluster
        stage('Delete AWS Rosa Cluster') {
            steps {
                catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE'){
                    sh "ansible-playbook ansible/rosa-cluster-delete-operations.yml -e 'cluster_name=${clusterName}'"
                }
            }
        }        
    }
}