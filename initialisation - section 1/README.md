# docker

```docker build .``` : creer l'image avec les instruction de [Dockerfile](Dockerfile)

```docker run -p 3000:3000 <docker image id>```

```-p 3000:3000``` >> expose le port en question pour l'accès a l'image docker

ici : <http://localhost:3000/>

```docker ps``` : liste les container en cours
```docker stop <NAME>``` : pour arreter le container 