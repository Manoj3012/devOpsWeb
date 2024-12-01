pipeline {
    agent any
    
    environment {
        DOCKER_PASSWORD = credentials('docker-cred')
        DOCKER_USERNAME = "dinesh10275"
        DOCKER_REGISTRY = "docker.io"
        DOCKER_IMAGE_NAME = "dinesh10275/dev-backend"
        GITHUB_REPO_URL = "https://github.com/TheTym-ProjectManagement/dev-backend.git"
        GIT_CREDENTIALS_ID = "Git-cred"
        STACK_NAME = "backend-dev-stack"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:v0.${BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        def dockerImageTag = "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:v0.${BUILD_NUMBER}"
                        sh "docker login -u ${env.DOCKER_USERNAME} -p ${env.DOCKER_PASSWORD} ${DOCKER_REGISTRY}"
                        sh "docker push ${dockerImageTag}"
                    }
                }
            }
        }

    }
}
