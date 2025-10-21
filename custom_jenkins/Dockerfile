# Use the Jenkins LTS image as base
FROM jenkins/jenkins:lts

# Switch to root to install dependencies
USER root

# Install Docker and prerequisites (without software-properties-common)
RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release docker.io && \
    apt-get clean

# Add Jenkins user to Docker group
RUN groupadd -f docker && \
    usermod -aG docker jenkins

# Create Docker directory for DinD
RUN mkdir -p /var/lib/docker
VOLUME /var/lib/docker

# Switch back to Jenkins user
USER jenkins
