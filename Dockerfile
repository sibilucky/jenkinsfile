# Use the official Amazon Linux image as the base image
FROM amazonlinux:2

# Set the maintainer label
LABEL maintainer="sibisidhu4242@gmail.com"

# Update the package repository and install common tools
RUN yum --disablerepo=amzn2-core -y update
  yum -y install \
    git \
    curl \
    vim \
    wget \
    python3 \
    gcc \
    make \
    java-11-amazon-corretto

# Clean up the package manager cache to reduce image size
RUN yum clean all

# Set the working directory in the container
WORKDIR /app

# Copy your application code (if you have it) into the container
# COPY ./app /app

# Expose a port (for example, port 70)
EXPOSE 70

# Set the command to run when the container starts
CMD ["bash"]

