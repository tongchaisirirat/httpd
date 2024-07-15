node {
    def app
    def imageName = "tongchaisirirat/httpd"
    def imageTag = "${env.BUILD_NUMBER}"

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("${imageName}:${imageTag}")
        echo "Built image: ${imageName}:${imageTag}"
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${imageTag}")
            app.push("latest")
            echo "Pushed image: ${imageName}:${imageTag}"
            echo "Pushed image: ${imageName}:latest"
        }
    }
}
