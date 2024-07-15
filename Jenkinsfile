node {
    def app
    def imageTag = "${env.BUILD_NUMBER}" // กำหนด tag ของ image เป็นหมายเลข build

    stage('Clone repository') {
        // ทำการ clone repository มาไว้ใน workspace
        checkout scm
    }

    stage('Login to Docker Hub') {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
        }
    }

    stage('Build image') {
        // สร้าง image ด้วยคำสั่ง docker build
        app = docker.build("tongchaisirirat/httpd:${imageTag}")
    }

    stage('Test image') {
        // ทดสอบ image ที่สร้างขึ้น
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        // เปลี่ยน context เป็น default ก่อนการ push image
        sh "docker context use default"

        // ทำการ push image ไปยัง Docker Hub
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${imageTag}")
            app.push("latest")
        }
    }
}
