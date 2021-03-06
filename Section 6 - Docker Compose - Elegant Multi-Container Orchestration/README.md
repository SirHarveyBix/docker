# Docker Compose

permet de remplacer ```docker build``` ```docker run```, dans un seul fichier de configuration, et gerer les multi-containers.

pour utiliser docker-compose :

- **```docker-compose up```** : pour lancer, *```-d``` pour le mode detaché*
- **```docker-compose down```** : pour supprimer les containers, *```-v``` pour supprimer les volumes*
- **```docker-compose build```** : build les images sans *```run```*

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
  mongodb: # --name + nom du dossier + nombre
    image: 'mongo' 
    container_name: mongodb # --name mongodb
    volumes:
      - data:/data/db
    env_file:
      - ./pathto/.env
    # ou si il n'y a pas de .env : 
    environment:
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

- **volumes** :
tous les volumes present dans le docker-compose doivent etre enumérés a la fin du ficher :

  ```yaml
  volumes:
    data:
    logs:
  ```
