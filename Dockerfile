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

# Stage 2: Deploy the WAR file to Tomcat
FROM tomcat:8.0

# Copy the WAR file from the first stage to Tomcat's webapps directory
COPY --from=build /usr/src/app/target/*.war /usr/local/tomcat/webapps/

# Expose port 8080 for the application
EXPOSE 8080

# Set the working directory
WORKDIR /usr/local/tomcat/webapps/

# Start Tomcat
CMD ["catalina.sh", "run"]
