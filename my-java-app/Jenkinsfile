pipeline{
    agetn any

    tools{
        maven "Maven 3.9"
        jdk "JDK-23"
    }

    triggers{
        pollSCM "H/2 * * * *"
    }

    environment{
        DOCKER_IMAGE = "dhruvamaheshwari47/jenkins_etp_java_v2"
        DOCKER_TAG = "latest"
        CONTAINER_NAME = "jenkins_etp_java_v2"
        PORT = 8080
    }

    stages{
        stage('clone')
        {
            steps{
                git url : "https://github.com/Dhruvamaheshwari/jenkins_etp_sem_6_java_v2.git",
                branch: "main"
            }
        }

        stage("install the dependency")
        {
            steps{
                bat "mvn clean install"
            }
        }

        stage("create the docker image"){
            steps{
                bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        stage("push the image on docker hub")
        {
            steps{
                withCredentials([
                    usernamePassword(
                        credentialsId:"dockerhub"
                        usenameVariable:"DOCKER_USERNAME",
                        passwordVariable:"DOCKER_PASSWORD"
                    )
                ]){
                    bat """ 
                        echo %DOCKER_PASSWORD%| docker login -u %DOCKER_USERNAME% --password-stdin
                    """
                }
            }
        }

        stage("stop the old container")
        {
            steps{
                bat "docker rm -f ${CONTAINER_NAME} || true"
            }
        }
        stage("re_run the container")
        {
            steps{
                bat "docker run -d -p ${PORT}:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }

    post{
        success{
            echo "pipeline is done"
        }
    }
}