FROM openjdk:8
COPY target/*.jar ttrend.jar 
ENTRYPOINT [ "java","-jar","ttrend.jar" ]