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
                kubeconfig(caCertificate: 'MIIDBjCCAe6gAwIBAgIBATANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwptaW5p
                                           a3ViZUNBMB4XDTI0MTEwMjE1MzEyM1oXDTM0MTEwMTE1MzEyM1owFTETMBEGA1UE
                                           AxMKbWluaWt1YmVDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALlo
                                           P9Ud/zlGNZ6E5JvpuGJ5W370F1k2aWqZfhOFQhT+N/9e1a97RZChM/nwhRcHr52q
                                           xGGk7KRe29ZMhhsiEOsR5/fJudni6uOuxK6MpCVWKCMdiNqFi1welVLMFLhNOBsf
                                           pmEa/8MZOdnX6Y/2tQfzCV5813qkXhcYEENOQkvJXAYmjx/GHQiJSH3mvNw3llBy
                                           6Gmk8sPzoKJ4wW/LE5wVspu1nBZOi2nvioNsdFMM5YStxIXg8coNKTTkrO3B02tB
                                           KBT3XQ2It/q8arldMBjLUmZyaA45db5+GNPIqLRu1xyENMVvuxaPXvAVu0GlY9pd
                                           s5xLNeoVOX+s/16Tff8CAwEAAaNhMF8wDgYDVR0PAQH/BAQDAgKkMB0GA1UdJQQW
                                           MBQGCCsGAQUFBwMCBggrBgEFBQcDATAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQW
                                           BBSTG800Mnufnu9kYNI0/5n+a39nDDANBgkqhkiG9w0BAQsFAAOCAQEARQcHePzx
                                           BKZsfaPnQr4Ci0hGAweQo5cec0kdsckt7artfTQAGIqBJoW+AXrb2ieorgKqZ99R
                                           3Hw3JZVjjFQ/rr4Pxqs+23izWz0BjRBVWXXxAELArs0T9vvIh8f+1FUCuL92IDDa
                                           VwRKwNKStVCYBoRqTMJtt4xw5WK0qSFTC20xrYdaDrOymhPIo933vzJy/mBCdOxR
                                           QW5TCbDrSrr2G/2ooSWDVz/MSjFxGATcNGG8s3uuRcOD6q7MzkOGwoTx5QB/9MYQ
                                           K3kL3ACM1fCus4N1MygbSwM7OJ2krR0SiUajpcCGXJ6fE99FkYfqpV70EZiP0dAd
                                           uHcD4WMj/WfHTg==', credentialsId: 'kubernetes', serverUrl: 'https://127.0.0.1:56335') {
                    echo 'Deploying to Kubernetes...'
                    sh 'kubectl apply -f deployment.yaml' // Deployment configuration
                    sh 'kubectl apply -f app-service.yaml' // Service configuration
                    sh 'kubectl rollout restart deployment emotional_chatbot' // Restart deployment with new image
                }
            }
        }
    }
}