FROM jenkins
USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN apt-get update && apt-get install -y vpnc wget ssh sudo nano vim
RUN cd /usr/local/lib && curl -LOJ https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.zip && unzip sbt-0.13.8.zip
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

USER jenkins
