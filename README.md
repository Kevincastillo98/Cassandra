# Configuracion y despliegue de Apache Cassandra sobre Docker

Para poder crear un cluster dentro de docker, es necesario 
hacer un pull a la imagen de cassandra, la cual se encuentra disponible dentro
de [DockerHub](https://hub.docker.com/_/cassandra).

1. ## Hacemos un pull

```bash
$ docker pull cassandra
```
Como no estamos especificando la version especifica a descargar, automaticamente
nos traerá la version `latest`


