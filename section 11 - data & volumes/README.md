# Kubernetes : [(k8s)](https://kubernetes.io/fr/)

Pour interagir avec ce projet utilisez postman :

- > ```docker compose up -d --build```

  - POST : [localhost/story](http://localhost/story)
  - GET : [localhost/story](http://localhost/story)

preparer le deploiement

- ```docker build -t sirharvey/kube-story .```
- ```docker push sirharvey/kube-story```

  - ```minikube status``` :

    ```sh
      minikube
      type: Control Plane
      host: Running
      kubelet: Stopped
      apiserver: Stopped
      kubeconfig: Configured
    ```

- ```minikube start```
  - ```--driver=``` ```docker``` suffit
  
- ```kubectl apply -f=service.yaml -f=deployment.yaml```
  - ```Kubectl get deployments``` :

      ```shell
      NAME               READY   UP-TO-DATE   AVAILABLE   AGE
      story-deployment   1/1     1            1           44s
      ```

- ```minikube service story-service``` :

  ```shell
  |-----------|---------------|---------------|---------------------------|
  | NAMESPACE |     NAME      |  TARGET PORT  |            URL            |
  |-----------|---------------|---------------|---------------------------|
  | default   | story-service | story-port/80 | http://192.168.49.2:32376 |
  |-----------|---------------|---------------|---------------------------|
  * Tunnel de démarrage pour le service story-service.
  |-----------|---------------|-------------|------------------------|
  | NAMESPACE |     NAME      | TARGET PORT |          URL           |
  |-----------|---------------|-------------|------------------------|
  | default   | story-service |             | http://127.0.0.1:57479 | <<<
  |-----------|---------------|-------------|------------------------|
  * Ouverture du service default/story-service dans le navigateur par défaut...
  ! Comme vous utilisez un pilote Docker sur windows, le terminal doit être ouvert pour l'exécuter.
  ```

recuperez l'URL ici <http://127.0.0.1:57479>, et toujours via postman POST / GET [/story](/)
