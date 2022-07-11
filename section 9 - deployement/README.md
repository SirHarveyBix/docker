# docker

>[> **_small-app_**](/small-app)

**Bind Mounts, Volumes, & `COPY`**

Ces élements sont utile durant le developpement, mais mal utilisés, certains dangereux a deployer.

Le code exposé depuie le containter, ne doit pas etre exposé lors du deployment.

on prefera `COPY` au lieu des Bind Mounts.

## deployment

pour deployer un image, il nous faut un instance, ici nous avont choisi [AWS](https://aws.amazon.com/fr/), il nous faut creer une instance.

### Docker Hub

Le moyen le plus simple de deployer une image est de la rendre acessible en ligne avec Docker Hub, voici le repo de l'image : [Docker Hub](https://hub.docker.com/repository/docker/sirharvey/node-deploy/general), pour envoyer une image dans le Hub:

- ```docker login```
- ```docker build -t sirharvey/node-deploy .```
  - >```sirharvey/node-deploy``` : nom du repos + nom de l'image
  
- ```docker push sirharvey/node-deploy```

### AWS

en cas de besoins : [Academind : AWS - the basics](https://academind.com/tutorials/aws-the-basics)

coté AWS, avant de renter dans la console AWS, il nous faut rendre l'accès possible, ici, il faut generer un ficher `.pem`, et lancer:

- ```chmod 400 exemple.pem```,

et s'y connecter a l'aide de la commande indiquée :

- ```ssh -i "exemple.pem" ec2-user@ec2-44-204-64-103.compute-1.amazonaws.com```

un fois connecté :

- ```sudo yum update -y``` : _mettre a jour les package du repos distant_
- ```sudo amazon-linux-extras install docker``` : _installer docker_
- ```sudo service docker start``` : _lancer docker_
- ```sudo docker run -d --rm -p 80:80 sirharvey/node-deploy``` : _recuperer et lancer l'iamge_

il faut bien sur en amout admistirer la console, et autoriser l'accès dans _seucrity group_

le site sera alors accessible a l'adresse IP indiquée, ici : [44.204.64.103](http://44.204.64.103/)

cette partie cincerne le deploiement EC2 la partie suivante: ECS a été sautée (_Lecture 139. Deploying with AWS ECS: A Managed Docker Container Service_)
