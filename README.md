# Configuracion y despliegue de Apache Cassandra en Docker

Para poder crear un cluster dentro de docker, es necesario 
hacer un pull a la imagen de cassandra, la cual se encuentra disponible dentro
de [DockerHub](https://hub.docker.com/_/cassandra).

## Obteniendo la imagen 

```bash
$ docker pull cassandra
```
Como no estamos especificando la version especifica a descargar, automaticamente
nos traerá la version `latest`.

Para poder crear un cluster dentro de nuestro contenedor, primero tenemos que
definir el número de nodos sobre el cual queremos trabajar, en este caso yo sólo 
crearé un cluster con 3 nodos contenidos dentro del mismo data center.

## Creacion de carpetas

Para poder almacenar la información dentro de nuestra máquina, es necesario 
crear las carpetas don
