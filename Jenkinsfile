pipeline{
    tools{
        maven 'MAVEN_HOME'
        jdk 'JDK'
    }
    agent {label 'buildServer'}
    stages{
        stage('SCM-CHeckout'){
            steps{
                git 'https://github.com/arvind61h/ShoppingCart.git'
            }
        }
        stage('Test-And-DockerImage'){
            steps{
                sh 'mvn clean install'
                sh 'docker image prune -f'
                sh 'docker container prune -f'
                sh 'docker volume prune -f'
                sh 'docker system prune -f'
                sh 'docker build -t 92840/shop:dev1 .'
            }
            post{
                success{
                    archiveArtifacts artifacts: '**/*.jar, *.war', followSymlinks: false
                    //step([$class: 'JUnitResultArchiver', checksName: '', testResults: 'target/surefire-reports/*.xml'])
                }
            }
        }
        stage('CodeAnalysis'){
            steps{
               sh 'mvn sonar:sonar'
            }
            post{
                always{
                        jacoco buildOverBuild: true, deltaBranchCoverage: '60', deltaClassCoverage: '60', deltaComplexityCoverage: '60', deltaInstructionCoverage: '60', deltaLineCoverage: '60', deltaMethodCoverage: '60', maximumBranchCoverage: '80', maximumClassCoverage: '80', maximumComplexityCoverage: '80', maximumInstructionCoverage: '80', maximumLineCoverage: '80', maximumMethodCoverage: '80', minimumBranchCoverage: '80', minimumClassCoverage: '80', minimumComplexityCoverage: '80', minimumInstructionCoverage: '80', minimumLineCoverage: '80', minimumMethodCoverage: '80'
                        //slackSend channel: '﻿shopingcart', message: 'Hi Jenkins started' ${JOB_NAME} "- " ${BUILD_NUMBER} "- " ${BUILD_URL} Open
                        slackSend (channel: '﻿shopingcart', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                }
            }
        }
        stage('Deploying-Artifcts-Nexus'){
            steps{
              sh 'mvn deploy'
              sh 'docker push 92840/shop:dev1'
            }
        }
    }
}