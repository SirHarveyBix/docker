# docker

suivi du cours : [Docker & Kubernetes: The Practical Guide [2022 Edition]](https://www.udemy.com/course/docker-kubernetes-the-practical-guide/)

## Sections de cours

**Containers & images : [section 2 - images & containers basics](./section%202%20-%20images%20&%20containers%20basics)**

- ```docker build -t NAME:TAG .``` _creer une image_
- ```docker run --name NAME --rm -d IMAGE``` _lance une image_
- ```docker push ROPOSITORY/NAME:TAG``` & ```docker pull ROPOSITORY/NAME:TAG``` _Docker Hub_

**Volumes : [section 3 - Bind Mounts, Volumes & .env](./section%203%20-%20data,%20volumes%20&%20.env)**

- ```-v /local/path:/container/path``` : _isolated_ Bind Mount : "_sauvegarde_" les données
- ```-v NAME:/container/path``` : _stateless_ Volumes
  - doivent etre decalrés dans [docker-compose.yml](./Section%206%20-%20Docker%20Compose%20-%20Elegant%20Multi-Container%20Orchestration/docker-compose.yaml)

**connecter les containers : [section 4 - Networking (Cross-)Container Communication](./Section%204%20-%20Networking%20(Cross-)Container%20Communication)**

**Multi-Container : [section 5 - Building Multi-Container Applications](./section%205%20-%20Building%20Multi-Container%20Applications)**

**Docker Composer : [section 6 - Docker Compose - Elegant Multi-Container Orchestration](./Section%206%20-%20Docker%20Compose%20-%20Elegant%20Multi-Container%20Orchestration)**

- un ficher `.yaml` : execute les Dockerfile [docker-compose.yml](./Section%206%20-%20Docker%20Compose%20-%20Elegant%20Multi-Container%20Orchestration/docker-compose.yaml)
  - ```docker-compose up```
  - ```docker-compose down```

**Utility container : [section 7 - Utility container - exec](./section%207%20-%20Utility%20container%20-%20exec)**

**Example : Utility Container (concret & complexe) : [section 8 - Complex setup - Laravel & PHP](./section%208%20-%20Complex%20setup%20-%20Laravel%20&%20PHP)**

- installer une ressource gourmande, comme Python, ou PHP dans un container

**Deployement : [section 9 - deployement](./section%209%20-%20deployement)**

- les Bind Mounts doivent etre remplacés par `COPY`, ou Volumes, il ne doivent etre laissée en production
- Multi-stages

**Kubernetes : [section 10 - Kubernetes](./section%2010%20-%20Kubernetes)**

**volumes, persistance & env : [section 11 - data & volumes](./section%2011%20-%20data%20&%20volumes)**
