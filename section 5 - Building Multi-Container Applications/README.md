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

