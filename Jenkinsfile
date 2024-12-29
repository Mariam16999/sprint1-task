// Jenkinsfile
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mariam16999/sprint1-task'  // Docker Hub repository name
        IMAGE_TAG = 'latest'  // Image tag
        DOCKERHUB_CREDENTIALS = 'docker' // Jenkins credentials ID for Docker Hub login
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git 'https://github.com/Mariam16999/sprint1-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using Dockerfile
                    sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Remove the Docker image after the process
                    sh 'docker rmi $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker resources if necessary
            sh 'docker system prune -f'
        }
    }
}
