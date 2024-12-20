FROM amazonlinux:2

# Copy app.jar into the container
COPY app.jar /app/

# Test if the file is copied correctly by listing the contents
RUN ls -l /app
