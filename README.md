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

Tambien podemos ejecutar el nodo con las siguientes opciones de configuracion, las
cuales son variables de entorno que nos permiten modificar los valores del archivo
`/etc/cassandra/cassandra.yaml`

1. `CASSANDRA_CLUSTER_NAME`
2. `CASSANDRA_NUM_TOKENS`
3. `CASSANDRA_DC`
4. `CASSANDRA_RACK`
5. `CASSANDRA_ENDOPOINT_SNITCH`
6. `CASSANDRA_SEEDS`

Sin embargo también podemos configurar el archivo `/etc/cassandra/cassandra.yaml` lanzando
una shell después de haber ejecutado la imagen, ambas prácticas son válidas, sin embargo el 
modificar las variables de entorno nos facilitará la tarea de edición de archivo.

Si deseamos editar las variables de entorno, lo hariamos de la sigueinte forma:

```bash
$ docker run --name nodo1  --network redprueba -d cassandra \
  -e CASSANDRA_CLUSTER_NAME="clustertest" \
  -e CASSANDRA_NUM_TOKENS="8" \
  -e CASSANDRA_DC="dc1" \
  -e CASSANDRA_RACK="rack1" \
  -e CASSANDRA_ENDPOINT_SNITCH="GossipingPropertyFileSnitch" \
  -e CASSANDRA_SEEDS="$(docker inspect -f "{{.NetworkSettings.IPAddress}}") nodo1" \ 
  -v /var/lib/container_data/nodo1:/var/lib/cassandra -d cassandra 
```

## Almacenamiento local

Una vez creada nuestra carpeta `/var/lib/container_data`
y haber creado las carpetas `nodo1` `nodo2` `nodo3` podemos  almacenar de forma local 
los datos de nuestros keyspaces.

```bash 
$ docker run --name nodo1 -v /var/lib/container_data/nodo1:/var/lib/cassandra -d cassandra
$ docker run --name nodo2 -v /var/lib/container_data/nodo2:/var/lib/cassandra -d cassandra
$ docker run --name nodo3 -v /var/lib/container_data/nodo3:/var/lib/cassandra -d cassandra
```

## Lanzar una shell

Para poder hacer uso de una shell, después de inicializar una imagen:

```bash 
$ docker  run -it nodo1 bash
$ docker  run -it nodo2 bash
$ docker  run -it nodo3 bash
```
Lanzar una shell nos permitirá modificar el archivo `/etc/cassandra/cassandra.yaml` y poder 
configurar las variables que anteriormente se mencionaba.

## Monitoreo de servicios

Una vez que se inicializó la imagen de cassandra y haber lanzado el comando `bash`, podremos
monitorear el servicio de `cassandra, para ello podemos ejecutar el siguiente comando:

```bash 
# service cassandra status
```
Si queremos parar,reiniciar o iniciar el servicio basta con colocar:

```bash
# service cassandra [stop|restart|start]
```
Y para verificar que el nodo está encendido, podemos usar la herramienta `nodetool`
la cual nos permitirá efectuar algunas acciones sobre el nodo, una de ellas es  la de verificar
el estado del nodo, mediante:

```bash
# nodetool status
```

## Logs

una vez que iniciemos nuestros contenedores, podemos verificar los logs en caso de falla en algun nodo:

```bash
$ docker logs nodo1
$ docker logs nodo2
$ docker logs nodo3
```

En caso de mostrar algún error en algún nodo, solo basta con detener el contenedor y volver
a inicializarlo

```bash 
$ docker  stop    nodoX
$ docker  start   nodoX
$ docker  attach  nodoX
```
donde `nodoX` representa alguno de los nodos creados anteriormente

