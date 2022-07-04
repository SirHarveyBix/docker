# Docker Compose

permet de remplacer ```docker build``` ```docker run```, dans un seul fichier de configuration, et gerer les multi-containers.

plutot que d'avoir une ligne de commande de ce type :

- [docker-commands](./docker-commands.txt) =>

  ```shell
  docker run --name mongodb \
    -e MONGO_INITDB_ROOT_USERNAME=max \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    -v data:/data/db \
    --rm \
    -d \
    --network goals-net \
    mongo
  ```

## docker-compose.yaml

les ficher docker-compose s'ecrivent en yaml, c'est donc l'indentation qui compte :

```yaml
version: "3.8" 

services:
  mongodb: # --name
    image: 'mongo' 
    volumes:
      - data:/data/db
    environment:
      env_file:
        - ./pathto/.env
      # ou si il n'y a pas de .env :
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: secret
```

pour comparaison, voir l'equivalement en invite de commande ci-dessus.

par defaut ```--rm``` est activé, en revance pas besoin de specifier ```-d```

- **```--network```** : les container creer par docker-compose n'ont pas besoin de la specification *```--network```*, puisqu'il seront executé dans le meme reseau, si toutefois on veut leurs donner un nom : 

  ```yaml
  services:
    mongodb:
      image: 'mongo'
      networks:
        - goals-net
  ```

