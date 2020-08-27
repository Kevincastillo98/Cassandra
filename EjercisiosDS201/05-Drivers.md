## Conexión de cassandra con python3

*Cassandra* puede ser usada atraves de alguno de lso siguientes lenguajes de programación:

1. Python
2. Java
3. Scala
4. JavaScript
5. C#	
6. Ruby
7. PHP

Para poder conectar alguno de estos lenguajes, es necesario instalar uno de los
drivers proporcionado en la pagina de ![Cassandra](https://cassandra.apache.org/doc/latest/getting_started/drivers.html).
En este caso se implementará una conexión mediante python en su versión 3.8, para ello usaremos
el gestor de paquestes `pip3`.

```bash
$ pip3 install cassandra-driver
```

Una vez instalado, verificamos que el puerto  `9042` esté abierto en nuestro container
y para ello verificamos el archivo `docker-compose.yaml`.

Conexión:

```python
from cassandra.cluster import  Cluster

cluster = Cluster(['192.168.1.65'],port=9042)
session = cluster.connect('killrvideo')
elements =  session.execute("SELECT * FROM videos_by_tag")

for i in elements:
	print(i)

```

1. Instanciamos a la clase `Cluster` , la cuál recibe como parámetros una lista de ip address
y el puerto por el cuál se conectará.
2. Creamos una conexión a nuestro `keyspace`
3. creamos un objeto llamado elements, el cuál debe ser iterado para mostrar
cada uno de los registros de nuestra base de datos.

## Configuración de seguridad

Supongamos que tenemos un rol creado en nuestra base de datos, el cuál tiene ciertos
privilegios de lectura y escritura y el cuál fué creado de la siguiente forma:


```bash
$ cqlsh -u cassandra -p cassandra 
```

```cql
> CREATE ROLE kevin WITH PASSWORD=password AND SUPERUSER=false;
```

Para poder ejecutar el código anterior, es necesario editar el archivo
`cassandra.yaml`, especificamente la variable `authenticator`
especificando que todos los roles deben de acceder atraves de un password.

```yaml
authenticator: PasswordAuthenticator
```

Ahora para podernos conectarnos a traves del usuario  `kevin` mediante python
es necesario ejecutar el siguiente código:


```python 
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
 
auth_provider = PlainTextAuthProvider(username='kevin', password='password')
cluster = Cluster(auth_provider=auth_provider)
session = cluster.connect('killrvideo')

```


