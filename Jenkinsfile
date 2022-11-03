node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def mvn = tool 'MyMaven';
    withSonarQubeEnv() {
      sh "${mvn} clean verify sonar:sonar -Dsonar.projectKey=Mvn-Test"
    }
  }
  stage('MavenBuild') {
      sh 'mvn package'
      sh 'mvn deploy -DskipTests -Dmaven.install.skip=true'
  }
}
