import java.text.SimpleDateFormat
import java.util.Date

pipeline {  
    agent any
      
    environment {
        ROSA_TOKEN =  credentials('aws-token-rosa') 
    }

    stages {
        stage('Initialize') {
            steps {
                script {
                    def date = new Date()
                    def dateStamp = new SimpleDateFormat("yyyy-MM-dd").format(date)
                    def clusterName = "rosatest-${dateStamp}"
                    echo "Cluster Name: ${clusterName}"
                }
            }
        }
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                /*sh """
                    pwd
                    ls
                    env
                """.stripIndent()*/
                echo 'Checking out from Git Repo....'
            }
        }
        // Add more stages as needed for your pipeline sdfgsgfds
        stage('Create AWS Cluster') {
            steps {
                /*catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE'){
                    sh "ansible-playbook ansible/rosa-cluster-create-operations.yml -e 'cluster_name=${clusterName}' "
                    clusterDeleted = true
                }*/
                echo 'Creating AWS cluster...'
            }
        }

        stage('ROSA TOKEN PRINT') {
            steps {
                script {
                    echo "ROSA_TOKEN value: ${env.ROSA_TOKEN}"
                }
            }
        }
        
    }
}