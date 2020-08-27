## Primeros pasos con CQL

La compañia KillrVideo te contrata para construir un sistema de base de datos distribuida, la cual 
alamacenará información de todas sus sucursales.Tú primera actividad se encuentra en la siguiente sección.

## Tareas a realizar
1. Crear un keyspace llamado killrvideo
2. Crear una tabla para almacenar la metadata de los videos
3. Cargar datos de un archivo CSV para poblar la tabla  

La tabla contendrá los siguientes atributos:

|Nombre de la columna   |  Tipo de dato  |  
|---|---|
| `video_id`  | uuid  |   
| `added_date` | timestamp  |  
| `title` | text  | 

## Realizando nuestro trabajo

En primer lugar, debemos crear un keyspace (simil a un schema en SQL)

```cql
CREATE KEYSPACE killrvideo WITH replication={'class':'SimpleStrategy' , 'replication_factor':3};
```

¿Cúal es la función principal de un `KEYSPACE`?
 
Un keyspace contiene toda la información almacenada y la arquitectura de las
tablas creadas.

¿Qué significa `replication`?

*Cassandra*  es una base de datos distribuida,en donde cada nodo dentro de una red
representa una unidad de almacenamiento y sobre los cuales podemos replicar datos, ya que
esto nos permite tener mayor disponibilidad de los datos en caso de fallas, en este caso
usaremos un factor de replicación igual a 3, ya que más adelate tocaremos el tema de
los niveles de consistencia y nos daremos cuenta porque 3 es un número común en 
la configuración del  `replication_factor`.

¿Qué significa `SimpleStrategy` ? 

*Cassandra*  nos permite crear clusters de máquinas, las cuales pueden ser alamcenadas en un 
datacenter o úbicación geográfica de donde se alamacenan los nodos, en este caso puede ser un conjunto
de contenedores intercomunicado entre ellos y  distribuidos sobre una misma red.
En este caso sólo crearemos un data center, así que usaremos `SimpleStrategy`  como parámetro de configuración.

Una vez creado nuestro *Keyspace* , podemos crear nuestras tablas.

```cql
USE killrvideo;
CREATE TABLE videos(video_id uuid,added_date timestamp,title text, PRIMARY KEY(video_id));
``` 
Ahora podemos insertar datos dentro de nuestra tabla `videos`

```cql
INSERT INTO videos(video_id,added_date,title) VALUES (1645ea59-14bd-11e5-a993-8138354b7e31,'2014-01-29','Cassandra History');
INSERT INTO videos(video_id,added_date,title) VALUES (245e8024-14bd-11e5-9743-8238356b7e32,'2012-04-03','Cassandra & SSDs');
INSERT INTO videos(video_id,added_date,title) VALUES (3452f7de-14bd-11e5-855e-8738355b7e3a,'2013-03-17','Cassandra Intro');
INSERT INTO videos(video_id,added_date,title) VALUES (4845ed97-14bd-11e5-8a40-8338255b7e33,'2013-10-16','DataStax DevCenter');
INSERT INTO videos(video_id,added_date,title) VALUES (5645f8bd-14bd-11e5-af1a-8638355b8e3a,'2013-04-16','What is DataStax Enterprise?');
```
Podemos visualizar los datos insertados:

```cql
SELECT * FROM videos;
``` 

Sin embargo también queremos importar datos de un archivo `.csv` el cual se encuentra dentro de la ruta
`~/DS201/labwork/videos.csv`, para ellos podemos usar el comando  `COPY`

```cql
COPY videos(video_id,added_date,title) FROM  '~/DS201/labwork/videos.csv' WITH HEADER=true;
```


