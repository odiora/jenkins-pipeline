pipeline {
    agent {
        docker {
            image '34.88.187.2:8123/boxfuse:$tag'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
        }
    }

    stages {
        stage ('git clone') {
            steps {
                git 'https://github.com/odiora/boxfuse.git'
            }
        }
        stage ('build app') {
            steps {
                sh 'mvn package'
            }
        }
        stage ('build & push image') {
            steps {
                sh 'docker build -t myweb:$tag .'
                sh 'docker tag myweb:$tag $registry:$tag && docker push $registry:$tag'
            }
        }
        stage ('run application') {
            steps {
                    sh 'ssh-keyscan -H 34.88.176.33 >> ~/.ssh/known_hosts'
                    sh ''' ssh root@34.88.176.33 << EOF
                      	git clone https://github.com/odiora//jenkins-pipeline.git /home/jenkins-pipeline
                      	cd /home/jenkins-pipeline
                      	docker-compose up -d EOF'''
            }
        }
    }
}
