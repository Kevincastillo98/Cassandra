FROM ubuntu:18.04

RUN  apt-get update; \
     apt-get install -y  --no-install-recommends \
     # curl es necesario para poder verificar las llaves con las cuales fué firmado el conjunto de paquetes de cassandra
     curl \
     # cassandra requiere de java en su version 8 
     openjdk-8-jre-headless \
     # gpg nos ayuda a añadir las llaves 	     
     gpg \
     rm -rf /var/lib/apt/lists/*

     # Seguimos los pasos de instalacion de la pagina de cassandra: https://cassandra.apache.org/doc/latest/getting_started/installing.html

     # Primero se añade la variable de entorno de java
RUN  echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/"  >> /root/.bashrc
     # agregamos el repositorio de cassandra
RUN  echo "deb https://downloads.apache.org/cassandra/debian 311x main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list
     # agregamos claves del repositorio
RUN  curl https://downloads.apache.org/cassandra/KEYS | apt-key add -
     # actualizamos el repositorio e instalamos el paquete de cassandra
RUN  apt-get update && apt-get install -y  cassandra
     # iniciamos servicio de cassandra
RUN  service cassandra start

