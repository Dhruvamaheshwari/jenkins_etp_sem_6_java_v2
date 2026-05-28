FROM eclipse-temurein:23jdk

WORKDIR /app

COPY target/*.jar /app.jar

ENTRYPOINT [ "java" ,"-jar" ,"app.jar"]