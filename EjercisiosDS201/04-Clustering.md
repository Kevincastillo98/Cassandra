## Usando el ordenamiento de columnas mediante el cluster column

El cliente con el cual trabajamos nos llama para pedirnos una nueva base de datos,
la cual tiene el fin de almacenar nueva información acera de archivos de video, para ello
nos da las siguientes caracteristicas de la base de datos:

|Nombre de la variable | tipo de la variable|
|---|---|
|`tag`| text|
| `video_id`| uuid|
|`added_date`| timestamp|
|`title`| text|

Sin embargo nos dice que esta base de datos contiene un número bastante grande de regitros,
los cuales son recolectados de diferentes sucursales distribuidas a lo largo del país.

Uno de los requisitos fundamentales del cliente es que al  leer el conjunto de datos
estos estén ordenados de forma ascendente por la hora en la que se registró la compra.

## Creando la base de datos

Como vimos en el archivo anterior, pudimos usar un `primary key` para poder
particionar nuestra base de datos y poder disribuir nuestros registros sobre un 
conjunto de nodos, pues ahora usaremos de igual forma un comando que nos permite 
ordenar dichas particiones, para ello usaremos el comando `CLUSTERING`.


```cql
CREATE TABLE videos_by_tag(
						tag text,
						video_id  uuid,
						added_date timestamp,
						title text,
						PRIMARY KEY((tag),added_date))
 						WITH CLUSTERING ORDER BY(added_date ASC);
```

Como podemos ver el primer parámetro que está dentro del comando 'PRIMARY KEY'
representa la `partition key`  y el segundo parámetro representa el  `cluster column`
lo cual nos indica que será particionado por el `tag` y  ordenado ascendentemente por
la hora de compra.

