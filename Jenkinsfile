pipeline {
    agent any

  environment {
      IMAGE_TAG = "0.0.$BUILD_NUMBER"
      IMAGE_NAME = "corona_jar"
  }

  stages {
    stage('CheckoutSCM') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-SSH', url: 'git@github.com:dmitriyshub/CoronaJav.git']]])
      }
    }

    stage('SonarQube Verify Analysis') {
      steps {
        withSonarQubeEnv('SonarQubeMvn') {
          sh "/usr/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=Mvn-Test"
        }
      }
    }

    stage('Maven Build') {
      steps {
        sh 'mvn package'
        //sh 'mvn deploy -DskipTests -Dmaven.install.skip=true'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
      }
    }

    stage('SonarQube Package Analysis') {
      steps {
        withSonarQubeEnv('SonarQubeMvn') {
          sh "/usr/bin/mvn clean package sonar:sonar"
        }
      }
    }

    stage('Nexus Jar File Upload') {
      steps {
        nexusArtifactUploader artifacts: [
          [
           artifactId: 'covid-tracker-application',
           classifier: '',
           file: 'target/covid-tracker-application-0.0.1-SNAPSHOT.jar',
           type: 'jar'
          ]
      ],
            credentialsId: 'Nexus',
            groupId: 'com.application',
            nexusUrl: 'http://localhost:8081',
            nexusVersion: 'nexus3', 
            protocol: 'http', 
            repository: 'maven-releases', 
            version: '0.0.1'
          }
    }

    stage('Clean WorkSpace') {
      steps {
        cleanWs()
      }
    }
    //stage('MavenDeploy') {
    //    sh 'java -jar target/covid-tracker-application-0.0.1-SNAPSHOT.jar --server.port=8181'
    //}
  }
}
