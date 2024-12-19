node {
    def DOCKER_IMAGE = 'amazon-linux'
    def DOCKER_TAG = 'latest'
    def DOCKER_REGISTRY = 'docker.io'  // Docker registry (change if necessary)
    def DOCKER_CREDENTIALS_ID = 'docker-credentials-id'  // Docker Hub credentials ID

    try {
        // Stage for checking out the source code
        stage("Checkout") {
            checkout scmGit(
                branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[
                    credentialsId: DOCKER_CREDENTIALS_ID,  // Use Docker credentials ID here
                    url: 'https://github.com/sibilucky/jenkinsfile.git'
                ]]
            )
        }

        // Stage for building the Docker image
        stage('Build Docker Image') {
            echo 'Building the Docker image...'
            // Make sure you are in the correct directory if Dockerfile is not in root
            sh "docker build -t amazon-linux:latest ."
        }

        // Stage for deploying the Docker container
        stage('Deploy') {
            echo 'Deploying the project...'
            sh "docker run -d --name amazon-linux-container -p 7070:7070 amazon-linux:latest"

            // Optional: Push the image to Docker registry (if needed)
            echo 'Pushing Docker image to registry...'
            // Login to Docker Hub using the credentials stored in Jenkins
            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                sh """
                    echo devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                    docker tag amazon-linux:latest docker.io/amazon-linux:latest
                    docker push docker.io/amazon-linux:latest
                """
            }
        }

    } catch (Exception e) {
        // Mark the build as failure in case of any error
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        // Cleanup stage to remove unused Docker resources
        echo 'Cleaning up...'
        sh 'docker system prune -f'
    }
}
