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

    }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
       }

       stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"e3786ae1-bcfe-4c90-9c17-4c62034e5551"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }
        }

}
