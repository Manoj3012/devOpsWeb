# Stage 1: Build Maven App
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /usr/src/app

# Copy the POM file and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the application source code
COPY src src

# Build the application
RUN mvn clean install

FROM tomcat:8.0

ADD ./target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

WORKDIR /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]

