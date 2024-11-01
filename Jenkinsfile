//
//  Author: Nho Luong  Date: 2020-03-13 21:10:39 +0000 (Fri, 13 Mar 2020)
//
//  vim:ts=2:sts=2:sw=2:et
////  https://github.com/nholuongut/dockerfiles
//
//  License: see accompanying Nho Luong LICENSE file
//
//  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish

// Official Documentation:
//
// https://jenkins.io/doc/book/pipeline/syntax/
//
// https://www.jenkins.io/doc/pipeline/steps/
//
// https://www.jenkins.io/doc/pipeline/steps/workflow-basic-steps/


pipeline {
  // to run on Docker or Kubernetes, see the master Jenkinsfile template listed at the top
  agent any

  options {
    timestamps()

    timeout(time: 2, unit: 'HOURS')
  }

  triggers {
    cron('H 10 * * 1-5')
    pollSCM('H/2 * * * *')
  }

  stages {
    stage ('Checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/nholuongut/dockerfiles']]])
      }
    }

    stage('Build') {
      steps {
        echo "Running ${env.JOB_NAME} Build ${env.BUILD_ID} on ${env.JENKINS_URL}"
        echo 'Building...'
        timeout(time: 10, unit: 'MINUTES') {
          retry(3) {
//            sh 'apt update -q'
//            sh 'apt install -qy make'
//            sh 'make init'
            sh """
              setup/ci_bootstrap.sh &&
              make init
            """
          }
        }
        timeout(time: 180, unit: 'MINUTES') {
          sh 'make ci'
        }
      }
    }

    stage('Test') {
      options {
        retry(2)
      }
      steps {
        echo 'Testing...'
        timeout(time: 120, unit: 'MINUTES') {
          sh 'make test'
        }
      }
    }
  }
}
