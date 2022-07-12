# Kubernetes : [(k8s)](https://kubernetes.io/fr/)

Collection d'outils permetta des deployer des containers

- les containers peuvent crasher, ils seront relancés avec _health check_

- autoscaling (creer des replicas par exemple)
- distribue le traffic équitablement
- fichier de configuration lisible par toutes les plateformes - _si standardisé_

Kubernetes : **docker-compose pour _multi machines_**

---

- Installation
 _pour installer kubctl : [Install Tools](https://kubernetes.io/docs/tasks/tools/)_
_pour installer minikube  : [minikube start](https://minikube.sigs.k8s.io/docs/start)_
  - ```minikube start```
  - ```minikube dashboard```
  - ```minikube stop```

---

## initialisation d'un projet de deploiement

- ```minikube status```
  - en cas d'erreur de _kubectl_ utilisez cette commande.
- ```minikube start --driver=``` _choisir la machine virtuelle_
  - ```docker```
  - ```virtualbox```
  - _windows_ : ```hyperv```

```docker build -t minikube-app .```

- ```kubectl create deployment first-app --image=minikube-app```
  - ```create deployment``` : creer un deploiement
  - ```first-app``` : nom de l'app choisi
  - ```--image=minikube-app``` : lance l'image build par docker

- ```kubectl get deployments```

  - renvoie :

    ```shell
    NAME        READY   UP-TO-DATE   AVAILABLE   AGE
    first-app   0/1     1            0           2m8s
    ```

- ```kubectl get pods```

  - renvoie :

    ```shell
    NAME                         READY   STATUS             RESTARTS   AGE
    first-app-574cfdf94b-pnq8v   0/1     ImagePullBackOff   0          2m55s
    ```

- ```kubectl delete deployments first-app```
  - l'image est en erreur, meme si elle a bien été créee : `ImagePullBackOff`
    - par ce qu'elle n'existe que sur notre machine, en local, il faut la poussée en ligne:
    - ```docker tag minikube-app sirharvey/minikube-app```
    - ```docker push sirharvey/minikube-app```
    - ```kubectl create deployment first-app --image=sirharvey/minikube-app```
      - la voila disponible
- si aucune erreur ne s'affiche : ```minikube dashboard``` sinon ```minikube status```
  > ```kubectl create``` donnera la liste des possiblités de creation

---

**```minikube dashboard``` est lancé**

- ```kubectl expose deployment first-app --type=LoadBalancer --port=8080```
  - ```expose``` le ```--port=8080```
  - ```--type=loadBalancer``` : genere un adresse unqiue et distribu le traffic entre les pods : parfait pour la **scalabilité**
- ```kubectl get services```
  - renvoie :

    ```shell
    NAME         TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
    first-app    LoadBalancer   10.103.15.2   <pending>     8080:32385/TCP   7s
    kubernetes   ClusterIP      10.96.0.1     <none>        443/TCP          17h
    ```

- ```minikube service first-app```
  - ouvre le navigateur et renvoie :

   ```shell
  |-----------|-----------|-------------|---------------------------|
  | NAMESPACE |   NAME    | TARGET PORT |            URL            |
  |-----------|-----------|-------------|---------------------------|
  | default   | first-app |        8080 | http://192.168.49.2:32385 |
  |-----------|-----------|-------------|---------------------------|
  * Tunnel de démarrage pour le service first-app.
  |-----------|-----------|-------------|------------------------|
  | NAMESPACE |   NAME    | TARGET PORT |          URL           |
  |-----------|-----------|-------------|------------------------|
  | default   | first-app |             | http://127.0.0.1:49230 |
  |-----------|-----------|-------------|------------------------|
  * Ouverture du service default/first-app dans le navigateur par défaut...
  ! Comme vous utilisez un pilote Docker sur windows, le terminal doit être ouvert pour l'exécuter.
    ```

**scaling**

- ```kubectl scale deployment/first-app --replicas=3```
  - ```scale``` _type:_```deployement``` _nom du master node:_ ```/first-app```, ```--replicas=3``` _repliquera 3 pods_
  - ```kubectl get pods```
    - renvoies (ici en erreur):

    ```shell
    NAME                         READY   STATUS             RESTARTS   AGE
    first-app-574cfdf94b-lb5nj   0/1     ErrImagePull       0          10s
    first-app-574cfdf94b-pgt2c   0/1     ErrImagePull       0          10s
    first-app-574cfdf94b-pnq8v   0/1     ImagePullBackOff   0          80m
    firstapp-6d68b45fdf-7gcww    1/1     Running            0          38m
      ```

pour mettre a jours le code, il faut bien sur rebuild avec docker : ```docker build -t sirharvey/minikube-app:2.0 .``` et push : ```docker push sirharvey/minikube-app:2.0``` le tag doit etre changé a chaque nouvelle mise a jours, ensuite :

- ```kubectl set image deployment/first-app minikube-app=sirharvey/minikube-app:2.0```, puis ```kubectl rollout status deployment/first-app``` : affiche le status du deploiement
