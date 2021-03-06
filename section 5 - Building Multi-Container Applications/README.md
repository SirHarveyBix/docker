# Docker

## Local

Project : React app Node + Mongodb backend.
[frontend](./frontend/)
[backend](./backend/)

Il est necessaire d'installer localement mongodb, mais docker nous permet de jouer avec le container : ```docker run --name mongodb --rm -d -p 27017:27017 mongo```
*le port 27017 est le port par defaut de mongodb*

ensuite :
```cd frontend && yarn && cd ..```
```cd backend && yarn && cd ..```
lancez le projet comme a votre habitude : ```yarn start``` (dans frontend & backend)

## Dockerization

### ```cd backend```

```docker build -t goals-node .```
```docker run --name goals-backend --rm -d goals-node```

l'url de connection a mongodb dasn [app.js](backend/app.js) n'est plus valide :

 ```js
mongoose.connect(
  'mongodb://localhost:27017/course-goals'
);
 ```

 l'url doit etre remplacée :

 ```js
mongoose.connect(
  'mongodb://host.docker.internal:27017/course-goals'
);
 ```

```docker build -t goals-node .```
```docker run --name goals-backend --rm -d -p 80:80 goals-node```

maintenant, le backend est correctement connecté a mongobd, et grace à ```-p 80:80``` le frontend peu correctement communiquer avec le backend (mais le front end est toujours en local)

### ```cd ../frontend```

```docker build -t goals-react .```

```docker run --name goals-frontend --rm -d -p 3000:3000 goals-react```

en cas d'erreur il nous faut ajouter : ```-it```

```docker ps``` :

```shell
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS                      NAMES
fdda743afc09   goals-react   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3000->3000/tcp     goals-frontend
bec6c6a880d3   goals-node    "docker-entrypoint.s…"   26 minutes ago       Up 26 minutes       0.0.0.0:80->80/tcp         goals-backend
ac12875a292f   mongo         "docker-entrypoint.s…"   27 minutes ago       Up 27 minutes       0.0.0.0:27017->27017/tcp   mongodb
```

#### Amélioration

##### ```--network```

```docker network ls``` pour lister les networks

```docker network create goals```

**les commandes ```-p``` ne sont plus necessaire : ```--network goals``` connecte les containers sur ce reseau** :

1. ```docker run --name mongodb --rm -d --network goals mongo```,
2. ```docker run --name goals-backend --rm -d --network goals goals-node``` :
    2.1 dans le cas ou nou n'utilisont plus ```-p 80:80``` ce code n'est plus valide :

    ```js
    mongoose.connect(
      'mongodb://host.docker.internal:27017/course-goals'
    );
    ```

    il doit etre remplacé par :

    ```js
    mongoose.connect(
        'mongodb://mongodb:27017/course-goals',
        // mongodb => nom du container 1. ( --name mongodb )
    );
    ```

    2.2 et rebuildé ```docker build -t goals-node .```, puis relancé (2.)

3. ```docker run --name goals-frontend --network goals --rm -d -p 3000:3000 goals-react```
   ici le port d'entré est toujours necessaire.
   3.1 meme chose pour le front dans [App.js](./frontend/src/App.js) :

    ```js
        const response = await fetch('http://localhost/goals');
    ```

    a chaque iteration, doit etre remplacé par :

    ```js
        const response = await fetch('http://goals-backend/goals');
        // goals-backend => nom du container 2. ( --name goals-backend )
    ```

    3.2 et rebuildé ```docker build -t goals-react .```, puis relancé (3.)
    3.3 le code de react est lu par le navigateur, l'url doit rester : ```http://localhost/goals```

4. retour sur le backend le port doit aussi etre afficher ```--publish```, pour que le front puisse y acceder :
   ```docker run --name goals-backend --rm -d --network goals -p 80:80 goals-node```
   le front n'a plus besoin de *network* : ```docker run --name goals-frontend --rm -d -p 3000:3000 goals-react```

#### Persistance des donnée (mongodb)

1. ##### ```--volume```

- pour que les données persistent, la [doc](https://hub.docker.com/_/mongo) nous indique le chemin du volume :
  *```docker --name some-mongo -v myData/dir:/data/db -d mongo```* :
  **```docker run --name mongodb -v data:/data/db --rm -d --network goals mongo```**

- pour le backend ajouter ce volumes :

  ```shell
  docker run --name goals-backend 
  -v '/Users/guillaumemini/Documents/VScode/docker/section 5 - Building Multi-Container Applications/backend':/app
  -v logs:/app/logs
  -v /app/node_modules
  --rm -d --network goals -p 80:80
  goals-node
  ```

- pour le frontend ajouter ce volumes :
  
  ```shell
  docker run --name goals-frontend --network goals 
  -v '/Users/guillaumemini/Documents/VScode/docker/section 5 - Building Multi-Container Applications/frontend/src':/app/src
  --rm -d -p 3000:3000
  goals-react
  ```

il vous faut ajouter le chemin d'accès complet pour creer ces bind mounts :

- ```-v '/Users/guillaumemini/Documents/VScode/docker/section 5 - Building Multi-Container Applications/backend':/app```

1. ##### ```--env``` ou ```-e```

- securité : on peu ajouer des *.env* pour mongodb , ici :
  - ```MONGO_INITDB_ROOT_USERNAME=```
  - ```MONGO_INITDB_ROOT_PASSWORD=```
- ```docker run --name mongodb -v data:/data/db --rm -d --network goals -e MONGO_INITDB_ROOT_USERNAME=guillaume -e MONGO_INITDB_ROOT_PASSWORD=secret mongo```
- le code dans [app.js](./backend/app.js) a besoin d'etre edité :

  ```js
  mongoose.connect(
  `mongodb://${process.env.MONGODB_USERNAME}:${process.env.MONGODB_PASSWORD}@mongodb:27017/course-goals?authSource=admin`,
  );
  ```

  les variable doivent etre ajoutées dans le [Dockerfile](backend/Dockerfile)

  ```shell
  ENV MONGODB_USERNAME=guillaume
  ENV MONGODB_PASSWORD=secret 
  ```

## Sythese

avant de commencer vous devez creer votre network :

- ```docker network create goals```

ensuite, *pull* l'image de mongodb :
```docker run --name mongodb -v data:/data/db --rm -d --network goals -e MONGO_INITDB_ROOT_USERNAME=guillaume -e MONGO_INITDB_ROOT_PASSWORD=secret mongo```

- ```-v data:/data/db``` : permet creer le volume qui fera perister les données 
- ```-e``` : vous permet d'ajouter les vaible d'environement

creer l'image du back :

- ```docker build -t goals-node .```
  
  ```shell
  docker run --name goals-backend 
  -v '/Users/guillaumemini/Documents/VScode/docker/section 5 - Building Multi-Container Applications/backend':/app
  -v logs:/app/logs
  -v /app/node_modules
  --rm -d --network goals -p 80:80
  goals-node
  ```

- celle du front ;
  
    ```shell
  docker run --name goals-frontend
  -v '/Users/guillaumemini/Documents/VScode/docker/section 5 - Building Multi-Container Applications/frontend/src':/app/src
  --rm -d --network goals -p 3000:3000
  goals-react
  ```

rendez-vous sur [localhost:3000](http://localhost:3000/)
