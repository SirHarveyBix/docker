# docker

## Rappel

### creation de l'image

```docker build -t feedback-node .``` : cette commande build l'image et attiribu le tag : "feedback-node"

### creation du conteneur

```docker run -p 3000:80 -d --name feedbak-app --rm feedback-node``` :

- ```docker run feedback-node``` : lance l'image : feedback-node
- ```-p 3000:80``` :"publie" sur le port [3000](http://localhost:3000/), (l'appli est sur le port [80](http://localhost:80/))
- ```-d``` en mode "detached" => terminal accessible
- ```--name feedbak-app``` : nome le conteneur : "feedbak-app"
- ```--rm``` : supprime le conteneur une fois arreté.
