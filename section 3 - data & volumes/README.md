# docker

Ce simple projet Node permet de creer des fichiers, lancez [http://localhost:3000](http://localhost:3000), entrez un title (sans espace), par exemple test, rendez vous sur [http://localhost:3000/feedback/test.txt](http://localhost:3000/feedback/test.txt), vous aurrez le contenu saisi dans 'Document Text'.
L'idée et d'appréhender ce qui se passe dans un container durant son cycle de vie.

**info :** dans *scripts* de [packages.json](./package.json), il est ajouter l'element : ```-L```, il ne concerne que les utilisateurs windows, utilisant WSL 2.

## Rappel

L'image est par defaut *Read-only*, contrairement au container et au volume : *Read-write*, pour forcer un volume en *Read-only*, on peu ajouter après la commande **```:ro```** : ```-v feedback:/app/feedback:ro```

### Creation de l'image

```docker build -t feedback-node:volumes .``` : cette commande build l'image et lui attiribu le nom : "*feedback-node*", et le tag : "*volumes*"

### Creation du conteneur

```docker
docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v "C:/Users/[USERNAME]/code/docker/section 3 - data & volumes:/app" -v /app/node_modules feedback-node:volumes
```

- ```docker run feedback-node:volumes``` : lance l'image : feedback-node, qui porte le tag : "volumes"
- ```-p 3000:80``` :"publie" sur le port [3000](http://localhost:3000/), (l'appli est sur le port [80](http://localhost:80/))
- ```-d``` en mode "detached" => terminal accessible
- ```--name feedback-app``` : nome le conteneur : "feedback-app"
- ```--rm``` : supprime le conteneur une fois stoppé .
- cmd : ```docker images``` :

  - ```shell
    REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
    feedback-node           volumes   720a3a9f1d6d   7 minutes ago   950MB
    feedback-node           latest    602f59bc5171   3 hours ago     950MB
    goals                   NEWone    5c6ae238501f   46 hours ago    1GB
    ```

---

## Volumes & Bind Mounts

- ```-v``` : pour volume. créer un volume dans le container, sans argument il sera 'anonyme'.
  - ```feedback:/app/feedback``` : ```feedback``` defini le nom, ```/app/feedback``` defini le chemin d'accès dans le container
  - ```"C:/Users/[USERNAME]/code/docker/section 3 - data & volumes:/app"``` : creer un Bind Mount qui ecoute le dossier en question : **permet l'edition du code.**
    - pour eviter de copier le chemin d'accès complet, remplaces la ligne precedente par celle ci :
      - macOS & Linux : ```$(pwd):/app```
      - windows : ```"%cd%":/app```
  - ```/app/node_modules``` : volume anonyme, empeche l'ecrasement des *node_modules* causé par la commande precedente

Afficher les volumes : ```docker volume ls```

suppression des volumes :

- ```docker volume prune``` : supprimera tout les volumes non utilisés.
- ```docker volume rm [VOL_NAME]``` : supprimera le volume mentionné.

Les *volumes* sont gérés par docker, a l'inverse des *Binds Mounts*.
Les volumes sont des dossier / ficher locaux, en dehors du container, ils sont disponible pour le container, et mappés dans le container, si on ajouter un fichier en local, il se retrouvera aussi dans le container, a l'inverse, un ficher ajouter dans le container se retrouvera localement.

commande complete :

```docker
docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback -v "%cd%":/app:ro -v /app/temp -v /app/node_modules feedback-node:volumes
```

## Arguments & Variable d'Environnement

dans server.js, le port ancienement *80*, a été remplacé par ```process.env.PORT```
dans [Dockerfile](./Dockerfile) ces elements ont été modifiés :

```ENV PORT 80``` : connecte ```process.env.PORT``` au port *80*
```EXPOSE $PORT``` : *```$```* = varibale

Il est aussi possible d'ajouter cette variable dans la commande : ```-p 3000:8000 --env PORT=8000``` ou ```-e```
