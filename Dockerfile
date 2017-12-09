# Use the latest jenkins base image.
FROM jenkins:latest

# Change to root in order to install system-wide packages.
USER root

# Install Clojure packages.
RUN curl -sL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o lein
RUN chmod +x lein
RUN mv lein /usr/local/bin/ 

# Install Jenkins plugins.
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# Go back to jenkins user.
USER jenkins

# Add version file to the workspace.
COPY VERSION .

# Jenkins uses port 8080 for interacting with it through browser.
EXPOSE 8080