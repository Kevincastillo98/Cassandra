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
| video_id  | uuid  |   
| added_date | timestamp  |  
| title  | text  | 

## Realizando nuestro trabajo

En primer lugar, debemos crear un keyspace (simil a un schema en SQL)

```cql
CREATE KEYSPACE killrvideo WITH replication=
	{'class':'SimpleStrategy' , 'replication_factor':3};
```




