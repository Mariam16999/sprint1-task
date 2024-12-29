# Use OpenJDK 21 as the base image for the build stage
FROM openjdk:21-slim AS builder

# Install Maven
RUN apt-get update && apt-get install -y \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src

# Build the project using Maven
RUN mvn clean package -DskipTests

# List the contents of the /app/target directory to verify the JAR file path
RUN ls -l /app/target

# Use OpenJDK 21 for the runtime stage
FROM openjdk:21-slim

# Set the working directory
WORKDIR /app

# Copy the built .jar file from the builder image
COPY --from=builder /app/target/task1-git-1.0-SNAPSHOT.jar /app/sprint1-task.jar

# Run the application
CMD ["java", "-jar", "sprint1-task.jar"]
