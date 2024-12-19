# Use the official Amazon Linux base image
FROM amazonlinux:2

# Set the maintainer label (optional)
LABEL maintainer="yourname@example.com"

# Update the system and install some basic utilities
RUN yum update -y && \
    yum install -y \
    wget \
    git \
    java-1.8.0-openjdk-devel && \
    yum clean all

# Set up a working directory
WORKDIR /app

# Copy your application code to the container
# Make sure app.jar exists in the correct location (or update the path if needed)
COPY build/app.jar /app/

# Expose the port that your application will run on (if applicable)
EXPOSE 70

# Command to run the application (for example, a Java app)
CMD ["java", "-jar", "app.jar"]

