# Dockerfile

# Use Maven for the build stage
FROM maven:3.9.0-openjdk-21-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project using Maven
RUN mvn clean package -DskipTests

# Use OpenJDK for the runtime stage
FROM openjdk:21-slim

# Set the working directory
WORKDIR /app

# Copy the built .jar file from the builder image
COPY --from=builder /app/target/sprint1-task-1.0-SNAPSHOT.jar /app/sprint1-task.jar

# Run the application
CMD ["java", "-jar", "sprint1-task.jar"]
