FROM jenkins
USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt

## JAVA INSTALLATION
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends oracle-java8-installer && apt-get clean all

## JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get update && apt-get install -y vpnc wget ssh sudo nano vim python-pip
RUN wget -qO- https://get.docker.com/ | sh
RUN docker run hello-world
RUN pip install -U docker-compose
RUN docker-compose --version
RUN cd /usr/local/lib && curl -LOJ https://dl.bintray.com/sbt/native-packages/sbt/0.13.8/sbt-0.13.8.zip && unzip sbt-0.13.8.zip
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

RUN passwd -d jenkins

EXPOSE 8080

