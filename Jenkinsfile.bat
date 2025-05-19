pipeline {
    agent any

    parameters {
        string(name: 'DEPLOYMENT_MESSAGE', defaultValue: 'Default deployment message', description: 'Message for this deployment')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                bat 'ls -la'
                echo "Code checked out."
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
                bat 'echo "Build successful!" > build_status.txt'
                echo "Project built."
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                bat 'echo "All tests passed!" > test_results.txt'
                echo "Tests completed."
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the project with message: ${params.DEPLOYMENT_MESSAGE}"
                bat "chmod +x app.sh || true"
                bat "./app.sh '${params.DEPLOYMENT_MESSAGE}'"
                echo "Project deployed."
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
