pipeline{
    
    agent {
        node{
            label 'maven'
        }
    }
    environment{
        PATH = "/opt/apache-maven-3.9.4/bin/:$PATH"
        
    }
    
    stages{
      stage('Build'){
    steps{
        sh 'mvn clean deploy'
    }
    }
    }
        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonar-cloud') {
                    // Optionally use a Maven environment you've configured already
    
                        sh 'mvn clean package sonar:sonar'

                }
            }
        }

}
