# Docker

Les _utilities contaiers_ sont des container qui contiennent un environement de dev, comme: node, python etc ..., sans avoir a l'installer en local, tout en pouvant interagir avec .

**exemple** :

pour interagir avec node sans avoir besoin de l'installer : ```docker run --name custom_node -it -d node``` installera node dans un docker et permettra d'interagir avec (```-it```)

## Docker exec

Pour executer une commande dans un container :

**```docker exec node```**

- ```docker exec -it custom_node npm init```
  - ```-it``` pour rester connecté avec l'execution de la commande
  - ```npm init``` pour la commande a executer

dans le cas du _```npm init```_, la commande ```docker exec``` peut etre remplacée par :

-
  ```docker
  docker run -it node npm init
  ```

### Dockerfile & docker-compose

creation de limage:

- ```docker build -t node-util .```

**bind mount**

pour interagire proprement avec notre _utility container_, il nous faut un bind mount comme nous m'avons vu:

- ```docker run -it -v "chemin\complet\section 7 - Utility container - exec":/app node-util npm init``` _il serait plus scalable de creer un docker-compose.yml_
  - voila votre package.json créé 

**ENTRYPOINT [ "npm" ]**

dans [Dockerfile](Dockerfile), nous avons ajouter un point d'entré, _entrypoint_

- ```ENTRYPOINT [ "npm" ]```
  - toutes les commandes suiveront npm, npm n'est donc plus necessaire dans la saisie:
  - ```docker run -it -v "chemin\complet\section 7 - Utility container - exec":/app node-util init```
    - ```init```, ```install <DEPENDENCY>``` tout ce qi suit logiquement _npm_

**docker-compose.yml**

```yaml
services:
  custom_npm:
    build: ./
    stdin_open: true
    tty: true
    container_name: mynpm
    volumes:
      - ./:/app
```

pour lancer un seul service creer dans un docker compose :

- ```docker-compose run --rm custom_npm init```
  - lancera donc : ```npm init``` puisque ```ENTRYPOINT``` est set a ```npm```
  - ```docker-compose run``` ne supprime pas les container, retour de ```--rm```
