# docker

Ce simple projet Node permet de creer des fichiers, lancez [http://localhost:3000](http://localhost:3000), entrez un title (sans espace), par exemple test, rendez vous sur [http://localhost:3000/feedback/test.txt](http://localhost:3000/feedback/test.txt), vous aurrez le contenu saisi dans 'Document Text'.
L'idée et d'appréhender ce qui se passe dans un container durant son cycle de vie.

## Rappel

L'image est par defaut *Read-only*, contrairement au container : *Read-write*.

### Creation de l'image

```docker build -t feedback-node:volumes .``` : cette commande build l'image et lui attiribu le nom : "feedback-node", et le tag : "volumes"

### Creation du conteneur

```docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes``` :

- ```docker run feedback-node:volumes``` : lance l'image : feedback-node, qui poert le tag : "volumes"
- ```-p 3000:80``` :"publie" sur le port [3000](http://localhost:3000/), (l'appli est sur le port [80](http://localhost:80/))
- ```-d``` en mode "detached" => terminal accessible
- ```--name feedback-app``` : nome le conteneur : "feedback-app"
- ```--rm``` : supprime le conteneur une fois stoppé .
- ```docker images``` :

  - ```shell
    REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
    feedback-node           volumes   720a3a9f1d6d   7 minutes ago   950MB
    feedback-node           latest    602f59bc5171   3 hours ago     950MB
    goals                   NEWone    5c6ae238501f   46 hours ago    1GB
    ```

---

## Volumes

- ```-v``` : pour volume, créer un volume dans le container, sans argument il sera 'anonyme'.
  - ```feedback:/app/feedback``` : ```feedback``` defini le nom, ```/app/feedback``` defini le chemin d'accès dans le container

suppressions des volumes :

- ```docker volume prune``` : supprimera tout les volumes 'anonyme'
- ```docker volume rm [VOL_NAME]``` : supprimera le volume mentionné.

Les volumes sont des dossier / ficher locaux, en dehors du container, ils sont disponible pour le container, et mappés dans le container, si on ajouter un fichier en local, il se retrouvera aussi dans le container, a l'inverse, un ficher ajouter dans le container se retrouvera localement.
