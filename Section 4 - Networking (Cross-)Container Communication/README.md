# docker

**en cas de doute : ```docker logs -f <NAME/ID>```**

## cross-container

application a besoin de communiquer avec un second container :
[app.js](./app.js)

```js
mongoose.connect(
  // 'mongodb://localhost:27017/swfavorites', (premiere version)
  'mongodb://host.docker.internal:27017/swfavorites', // ici
  { useNewUrlParser: true },
  (err) => {
    if (err) {
      console.log(err);
    } else {
      app.listen(3000);
    }
  }
);
```

```docker run -d --name mongodb mongo```  => pour installer (pull) le container de mongodb.

en inspectant le container : ```docker container inspect mongodb``` on decouvre *IPAddress* :

```shell
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": ""
```

on peu alors remplacer notre code par :

```js
mongoose.connect(
  'mongodb://172.17.0.2:27017/swfavorites',
);
```

### ```--network```

dans le cas de cross-container, il faut utiliser cette commande : ```--network``` pour partager le meme reseau, et pouvoir échanger des données.

Cette commande : ```docker run -d --name mongodb --network favorite-net mongo``` utilise le network *favorite-net*.
Contraitement aux volumes, il est necessaire de creer le *network* avant de s'y connecter : ```docker network create favorite-net```, pour plus de details : ```docker network --help```

maintenant que notre container **mongodb** est connecté au *network :* **favorite-net**, il faut editer le code en ce sens :

```js
mongoose.connect(
  'mongodb://mongodb:27017/swfavorites'
);
```

```mongodb:27017``` => nom du container, et numero de son port

une fois edité : ```docker build -t movies .```
puis : ```docker run --name favorite --network favorite-net -d --rm -p 3000:3000 movies```

## synthèse

pour que 2 containers se connecte entre eux il faut un reseau commun, et ce avant meme le build des images :
```docker network create chosen-network-name```

ensuite ces containers doivent se connecter au *network* :

container 1 - image mongo de docker hub :

```docker run -d --name mongodb --network chosen-network-name mongo``` 

container 2 - notre projet :

```docker run -d --name favorite --network chosen-network-name --rm -p 3000:3000 movies```

le code doit evidement etre coherent avec ces container :

```js
mongoose.connect(
  'mongodb://mongodb:27017/swfavorites'
);
```
