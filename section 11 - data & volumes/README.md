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

## volumes

[deployment.yaml](deployment.yaml) :

```yaml
    spec:
      containers:
        - name: story
          image: sirharvey/kube-story
          imagePullPolicy: Always
          volumeMounts:
            - name: story-volume
              mountPath: /app/story # define in docker-compose.yaml
      volumes:
        - name: story-volume
          emptyDir: {} # keep data as long as the pod is alive
```

n'est relatif qu'au pod:

```yaml
          emptyDir: {} # creer un dossier vide dans les pods
```

les volumes sont liés a docker, particulierement dans ce cas

```yaml
          hostPath: 
            path: /data # partager avec le container type Bind mount
            type: DirectoryOrCreate # sera creer si il n'existe pas
```

Jusque la tous les volumes ne persistent que tant que les pods sont _alive_ .

maintenant tout les pods ont accès aux volumes
fichier de confoguration des volumes de pods : [host-pv.yaml](host-pv.yaml)

```yaml
spec:
  capacity:
    storage: 4Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /data
    type: DirectoryOrCreate
```

retour dans [deployment.yaml](deployment.yaml), pour etablir la connection des volumes entre les pods grace a _persistent volume claim_

```yaml
      volumes:
        - name: story-volume
          persistentVolumeClaim:
            claimName: host-pvc
```

## .env Variables

mise en place des variables d'environement :
grace a Node: `process.env.`
[app.js](app.js)

```js
const filePath = path.join(__dirname, process.env.STORY_FOLDER, 'text.txt');
```

c'ets cette varible qui est crée ici : `STORY_FOLDER`
[deployment.yaml](deployment.yaml)

```yaml
          env:
            - name: STORY_FOLDER # nom de la variable
              value: 'story' # dossier creer dans app/story
```

dans le cas de la creation d'un [fichier d'environement](environment.yaml)

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: data-store-env

data:
  nomDuDossier: 'story'
```

 il faut editer le fichier [deployment.yaml](deployment.yaml) en consequence:

```yaml
           env:
            - name: STORY_FOLDER # nom de la variable
              valueFrom:
                configMapKeyRef:
                  name: data-store-env # nom de l'environement crééer dans environment.yaml
                  key: nomDuDossier # nom de la clé dans le meme fichier
```
