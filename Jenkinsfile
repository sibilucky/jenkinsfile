node {
    def DOCKER_IMAGE = 'amazon-linux'
    def DOCKER_TAG = 'latest'
    def DOCKER_REGISTRY = 'docker.io'  // Specify your Docker registry if needed
    def DOCKER_CREDENTIALS_ID = 'docker-credentials-id'  // Docker Hub credentials ID (update this with your credentials ID)

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
            sh "docker build -t amazon-linux:latest."
        }

        // Stage for deployment
        stage('Deploy') {
            echo 'Deploying the project...'
            sh "docker run -d --name amazon-linux-container -p 70:70 amazon-linux:latest"

            // Optional: Push the image to Docker registry (if needed)
            echo 'Pushing Docker image to registry...'
            sh "docker tag amazon-linux:latest docker.io/amazon-linux:latest"
            sh "docker push docker.io/amazon-linux:latest"
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
