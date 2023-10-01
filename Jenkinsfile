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
                    sh 'mvn clean deploy -Dmaven.test.skip=true=true'
                }
            }
            stage("test"){
                steps{
                    sh 'mvn surefire-report:report'
                }
            }
            stage('build && SonarQube analysis') {
                steps {
                    withSonarQubeEnv('sonar-cloud') {
                        // Optionally use a Maven environment you've configured already
        
                            sh 'mvn package sonar:sonar -Dsonar.organization=valaxy99 -Dproject.settings=sonar-project.properties'

                    }
                }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
       }
            }

}
