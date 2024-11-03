pipeline {
    agent any
    environment {
        //be sure to replace "DOCKER_IMAGE_NAME" with your own Docker Hub username
        DOCKER_IMAGE_NAME = "megatronxcoder/emotional_chatbot"
    }
    stages {
        stage("Checkout from github repo"){
            steps{
            //Replace with your github repo
            git url: 'https://github.com/Megatron-XCoder/emotional_chatbot.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                sh 'pnpm install' // Install project dependencies
            }
        }
        stage('Build') {
            steps {
                echo 'Building the Next.js app...'
                sh 'npm run build'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            steps {
                kubeconfig(caCertificate: 'YOUR_CA_CERTIFICATE_HERE', credentialsId: 'kubernetes-credentials', serverUrl: 'https://127.0.0.1:56335') {
                    echo 'Deploying to Kubernetes...'
                    sh 'kubectl apply -f deployment.yaml' // Deployment configuration
                    sh 'kubectl apply -f app-service.yaml' // Service configuration
                    sh 'kubectl rollout restart deployment emotional_chatbot' // Restart deployment with new image
                }
            }
        }
    }
}