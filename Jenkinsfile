pipeline {
    agent { label "master" }
    environment {
        COMPOSE_PROJECT_NAME = "${env.JOB_NAME}"
        GITHUB_TOKEN = credentials('masbuild-github-token')
    }
    stages {
        stage('prepare') {
          steps {
            sh "docker-compose -f docker-compose.yml build --force-rm"
            sh "docker-compose -f docker-compose.yml up -d"
          }
        }
        stage ('branch-test') {
          when { not { branch 'PR-*' } }
            steps {
                sh "docker-compose -f docker-compose.yml run --rm rails ./test.sh"
            }
        }
        stage ('pr-test') {
          when { branch 'PR-*' }
            environment {
              DANGER_CHANGE_ID = "${env.CHANGE_ID}"
              DANGER_CHANGE_URL = "${env.CHANGE_URL}"
              DANGER_JENKINS_URL = "${env.JENKINS_URL}"
            }
            steps {
                sh "docker-compose -f docker-compose.yml run --rm rails ./test.sh"
            }
        }
        stage('build') {
          when { branch 'master' }
          steps {
            sh "docker-compose -f docker-compose.yml run --rm rails ./build.sh"
          }
        }
    }
    post {
        always {
            sh 'docker-compose -f docker-compose.yml down --remove-orphans'
            cleanWs()
        }
    }
}
