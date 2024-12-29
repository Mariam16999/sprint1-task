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

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container, exposing port 8082 on the host and binding it to the container's port 8082
                    sh 'docker run -d -p 8082:8082 $IMAGE_NAME:$IMAGE_TAG'
                    // Print the container logs to the console for debugging
                    sh "docker logs ${containerId}"
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
            // Remove running containers that are using the image
            sh 'docker ps -q --filter "ancestor=$IMAGE_NAME:$IMAGE_TAG" | xargs -r docker stop | xargs -r docker rm'
            
            // Force remove the Docker image if it is still present
            sh 'docker rmi -f $IMAGE_NAME:$IMAGE_TAG || true'
            
            // Prune unused Docker resources
            sh 'docker system prune -f'
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
