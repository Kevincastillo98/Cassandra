## Creación de particiones

*Cassandra* es una base de datos que cumple con 2 características
del teoremas de CAP, los cuales son particionado y disponibilidad,
la particion de datos nos permite tener un mejor performance en la operación 
de datos ya que podemos mejorar la lectura de dtaos.Para poder particionar una familia de columnas
en cassandra es necesario usar un `partition key`, la cuál tiene un simil con 
un `primary key ` en el mundo de las bases de datos relacionales.

¿Cómo sabemos en qué nodo se almacenarán los datos que insertemos?

Cuando insertamos un dato, se hace uso de un algoritmo de hash no criptográfico
llamado murmur3, el cual nos permite convertir una cadena de caracteres en un 
id único, el cual es generado cuando creamos una `partition key`.

## Particionando nuestra base de datos

Una vez creada la base de datos `videos`, podemos darnos cuenta que
usamos el comando `PRIMARY KEY`, este comando nos permite crear la cantidad
de particiones de nuestra tabla para poderlas distribuir sobre el cluster de nodos
que creamos.

```cql
CREATE TABLE videos(video_id uuid,added_date timestamp,title text, PRIMARY KEY( (video_id) ));
```
El primer parametro dentro del comando `PRIMARY KEY` representará la `partition key` y la cual
será encerrado por dos paréntesis.Cabe resaltar que podemos agregar mas de una partición de datos.


