FROM ubuntu:18.04
RUN  apt-get update && apt-get install -y vim curl openjdk-8-jre-headless
CMD  echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/"  >> /root/.bashrc
CMD  curl -OL http://apache.mirror.digitalpacific.com.au/cassandra/4.0.0/apache-cassandra-4.0.0-bin.tar.gz
CMD  tar -xvf apache-cassandra-4.0.0-bin.tar.gz



