FROM ubuntu:18.04
RUN  apt-get update && apt-get install -y vim curl openjdk-8-jre-headless gpg
CMD  echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/"  >> /root/.bashrc
CMD  echo "deb https://downloads.apache.org/cassandra/debian 311x main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list
CMD  curl https://downloads.apache.org/cassandra/KEYS | apt-key add -
CMD  apt-get update && apt-get install cassandra

