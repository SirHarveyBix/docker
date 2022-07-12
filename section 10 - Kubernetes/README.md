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
