pipeline {
    agent any
    
    tools {
        maven 'Maven'
        jdk 'JDK11'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from GitHub..."
                checkout scm
                
                // Log checkout event
                script {

                    sh """
                        curl -X POST http://172.19.0.5:5000 \
                        -H 'Content-Type: application/json' \
                        -d '{"message":"Code checkout complete","stage":"checkout","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"checkout"}'
                    """
                   
                }
            }
        }
        
        stage('Build') {
            steps {
                echo "Building the application..."
                sh 'mvn clean compile'
                
                // Log build event
                script {
                    def buildLog = sh(script: 'find . -name "*.log" | xargs cat || echo "No log files found"', returnStdout: true)
                    sh """
                        curl -X POST http://172.19.0.5:5000 \
                        -H 'Content-Type: application/json' \
                        -d '{"message":"Build completed successfully","stage":"build","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"build"}'
                    """
                }
            }
        }
        
        stage('Test') {
            steps {
                echo "Running tests..."
                sh 'mvn test'
                
                // Log test event
                script {
                    def testLog = sh(script: 'find target/surefire-reports -name "*.txt" | xargs cat || echo "No test logs found"', returnStdout: true)
                    sh """
                        curl -X POST http://172.19.0.5:500\
                        -H 'Content-Type: application/json' \
                        -d '{"message":"Tests completed successfully","stage":"test","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"test"}'
                    """
                }
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Package') {
            steps {
                echo "Packaging application..."
                sh 'mvn package -DskipTests'
                
                // Log packaging event
                script {
                    sh """
                        curl -X POST http://172.19.0.5:5000 \
                        -H 'Content-Type: application/json' \
                        -d '{"message":"Application packaged successfully","stage":"package","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"package"}'
                    """
                }
                
                // Archive artifacts
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying application..."
                // Remplacez par votre commande de déploiement réelle
                sh 'echo "Deploying application to server" > deploy.log'
                
                // Log deployment event
                script {
                    def deployLog = sh(script: 'cat deploy.log', returnStdout: true)
                    sh """
                        curl -X POST http://172.19.0.5:5000 \
                        -H 'Content-Type: application/json' \
                        -d '{"message":"Application deployed successfully","stage":"deploy","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"deploy","deploy_log":"${deployLog.replaceAll('"', '\\\\"')}"}'
                    """
                }
            }
        }
    }
    
    post {
        always {
            echo "Pipeline completed with status: ${currentBuild.result}"
            
            // Log pipeline completion
            script {
                sh """
                    curl -X POST http://172.19.0.5:5000 \
                    -H 'Content-Type: application/json' \
                    -d '{"message":"Pipeline completed with status: ${currentBuild.result}","stage":"post","job_name":"${env.JOB_NAME}","build_number":"${env.BUILD_NUMBER}","log_type":"pipeline"}'
                """
            }
        }
        success {
            echo "Build succeeded!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
