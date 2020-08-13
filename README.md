# Apache Cassandra sobre Docker

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
crear las carpetas donde se alojarán los archivos creados por cassandra, para ello
crearemos un carpeta dentro de `/var/lib`.

```bash
$ sudo mkdir -p /var/lib/container_data/cassandra-nodo-1
$ sudo mkdir -p /var/lib/container_data/cassandra-nodo-2
$ sudo mkdir -p /var/lib/container_data/cassandra-nodo-3
```
## Inicializando una imagen de docker

Una vez se obtuvo la imagen de cassandra, podremos inicializar a imagen.

```bash
$ docker run --name nodo1  --network redprueba -d cassandra 
$ docker run --name nodo2  --network redprueba -d cassandra 
$ docker run --name nodo3  --network redprueba -d cassandra 
```

Ya que nosotros queremos interconectar nustros nodos, necesitaremos cambiar los 
parametros de configuración, dentro de los que se encontrarán:

1. `CASSANDRA_CLUSTER_NAME`
2. `CASSANDRA_NUM_TOKENS`
3. `CASSANDRA_DC`
4. `CASSANDRA_RACK`
5. `CASSANDRA_ENDOPOINT_SNITCH`
6. `CASSANDRA_SEEDS`

Para crear un cluster, es necesario establecer el mismo `CLUSTER_NAME`, en donde el nombre
será `cluster_test`.

La variable `CASSANDRA_NUM_TOKENS` nos dice

Para poder obtener la ip de un contenedor basta ejecutar la siguinte linea:

```bash
$ docker inspect -f "{{.NetworkSettings.IPAddress}}" <nombre de container o imagen>
```


