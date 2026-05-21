FROM redhat/ubi10-minimal:latest

RUN microdnf update -y && microdnf install -y wget fontconfig java-21-openjdk
RUN wget -O /usr/share/java/jenkins.war https://get.jenkins.io/war-stable/2.555.2/jenkins.war

RUN useradd -u 1000 -m -s /bin/bash jenkins

EXPOSE 8080

CMD ["/usr/bin/java", "-Djava.awt.headless=true", "-jar", "/usr/share/java/jenkins.war", "--httpPort=8080"]
