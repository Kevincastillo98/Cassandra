from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

#Se tiene que usar un autenticador si es que se crean roles dentro de cassandra
#En caso de que el archivo cassandra.yaml tenga el parametro 
#authenticator: PasswordAuthenticator

auth_provider = PlainTextAuthProvider(username='cassandra', password='cassandra')
cluster = Cluster(auth_provider=auth_provider)
session = cluster.connect('killrvideo')

