FROM maven:3.6.3 AS maven
## MAINTAINER Philipp Gysel <pmgysel@ucdavis.edu>
#
#EXPOSE 8080 8080
#
#WORKDIR "/app"
#ADD . /app
#RUN mvn clean install
##
#CMD ["java", "-jar", "target/spring-boot-app-0.0.1-SNAPSHOT.jar"]

# AS <NAME> to name this stage as maven


WORKDIR /usr/src/app
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package

# For Java 11,

FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=spring-boot-app-0.0.1-SNAPSHOT.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/
EXPOSE 8080 8080
ENTRYPOINT ["java","-jar","spring-boot-app-0.0.1-SNAPSHOT.jar"]