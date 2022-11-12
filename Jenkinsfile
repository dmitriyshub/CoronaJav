pipeline {
    agent any

  environment {
      IMAGE_TAG = "0.0.$BUILD_NUMBER"
      IMAGE_NAME = "Corona_Jar"
  }
  stages {
    stage('CheckoutSCM') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub-SSH', url: 'git@github.com:dmitriyshub/CoronaJav.git']]])
      }
    }
    stage('SonarQube Analysis') {
      steps {
        def mvn = tool 'MyMaven';
        withSonarQubeEnv() {
          sh "${mvn} clean verify sonar:sonar -Dsonar.projectKey=Mvn-Test"
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
    stage('SonarQube Build') {
      steps {
        sh 'echo'
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
