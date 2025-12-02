# Stage 1: Build
FROM openjdk:11-jdk AS BUILD_IMAGE

RUN apt-get update && apt-get install -y maven && apt-get clean

WORKDIR /app
COPY . .

RUN mvn clean install -DskipTests

# Stage 2: Tomcat runtime
FROM tomcat:9.0-jdk11

LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
