FROM openjdk:11-jdk AS BUILD_IMAGE
RUN apt-get update && apt-get install maven -y && apt-get clean
COPY ./ vprofile-project
RUN cd vprofile-project &&  mvn install -DskipTests

FROM tomcat:9.0-jdk11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE /vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
