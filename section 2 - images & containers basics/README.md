# docker

```docker run node``` : lance l'image de node, elle sera telechargée si elle n'est pas en local

```docker ps -a``` >>>
(all containers created)

```shell
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                        PORTS     NAMES
2aa2e387c198   5e2b6054a9de   "python rng.py"          24 minutes ago   Up 11 seconds                           goalsapp
ab40b3d26082   5e2b6054a9de   "python rng.py"          27 minutes ago   Exited (1) 27 minutes ago               reverent_perlman
27475624419b   8cb3378a947a   "docker-entrypoint.s…"   2 days ago       Exited (137) 14 minutes ago             hungry_curran
f4254e725371   8cb3378a947a   "docker-entrypoint.s…"   2 days ago       Exited (137) 2 days ago                 eloquent_lamport
```

```docker run -it node``` >> run node iteractive, on pourra interagir avec le container (arrive rarement)

##### les image peuvent être

- nomées : au build ```docker build tag <NAME/ID>:latest .``` ou ```-t``` ici ```<NAME/ID>:latest``` le tag se trouve après " **:** "
- listées : ```docker images```
- analysées : ```docker image inspect <NAME/ID>```
- supprimées : ```docker rmi``` ou ```docker image prune``` + ```-a``` si taggées

##### les containers peuvent être

- només : ```--name <YOURNAME> <NAME/ID>```
- configurés en details : voir ```--help```
- listés : ```docker ps``` + ```-a``` pour ```--all``` affichera les containers arretés
- supprimés : ```docker rm``` ou ```docker container prune```
  - automatiquement : ```docker run --rm <NAME/ID>```

###### running / stopped containers

- re/lancés : ```docker start <NAME/ID>``` en mode "detaché" : (backgroung non interactif)
- lancés : ```docker run -p 8000:80 <NAME/ID>``` en mode "attaché" : (foregroung interactif)
  - ou ```-d <NAME/ID>``` pour le mode "detaché"
- suivis : ex:  ```docker logs -f <NAME/ID>```
  - ```logs``` affichera les logs (en mode detaché)
  - ```logs -f``` suivira les logs en temps réel, ```-f```: follow
- voir : 👉[```--attach```](./interactions)

```docker image inspect <NAME/ID>``` : renvoies les details de l'image, ses couches "*layers*", ses variables d'environement, ports ...

copier des fichier dans ou depuis le cintainer :

- ```docker cp interactions/test.txt <NAME/ID>:/test.txt``` : local to vers container, le dossier sera créé s'il n'existe pas

- ```docker cp <NAME/ID>:/test.txt interactions/lol.txt``` : container vers local
