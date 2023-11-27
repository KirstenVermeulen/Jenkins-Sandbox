pipeline {
    agent {
        label 'docker-agent-angular'
    }

    environment {
        DOCKERHUB_REPO = 'angular-pipeline'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Triggered on push event on the main branch
                git branch: 'main', credentialsId: 'b5d42895-ceb6-408c-8734-66b9c53f5e85', url: 'https://github.com/KirstenVermeulen/Jenkins-Sandbox.git'
            }
        }

        stage('Build Angular App') {
            steps {
                script {
                    // Assuming you have Node.js and Angular CLI installed on Jenkins agent
                    sh 'npm install'
                    sh 'ng build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Building Docker Image
                    sh "docker build -t ${DOCKERHUB_REPO}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        // Login to Docker Hub and push the image
                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                        sh "docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Deploying the Docker container
                    sh "docker run -d -p 80:80 ${DOCKERHUB_REPO}:${IMAGE_TAG}"
                }
            }
        }
    }
}