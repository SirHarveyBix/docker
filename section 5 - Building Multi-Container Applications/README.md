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
