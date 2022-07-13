# Kubernetes : [(k8s)](https://kubernetes.io/fr/)

```docker-compose up -d --build```

- <http://localhost:8080/signup> (postman)
- <http://localhost:8080/login> (postman)
  - POST :
  
    ```json
    {
      "email": "sir@harvey.me",
      "password": "password"
    }
    ```

- <http://localhost:8000/tasks> (postman)
  - POST :
  
    ```headers
    Authorization : Bearer abc
    ```

    ```json
    {
      "title": "Authorization",
      "text": "Bearer abc - Do you get it ?"
    }
    ```
  
  - GET
  
- <http://localhost/verify-token/abc> (postman)
  - GET : fail - pas exposé publiquement

---

## Lancement du projet

preparer le terain:

- ```minikube status```
  - ```minikube start```

- ```kubectl get service``` & ```kubectl get deployments```
  - ```kubectl delete service SERVICE-NAME``` meme chose avec ```deployment```

---

### creer l'image : **Users**

- ```cd users-api```
  - ```docker build -t sirharvey/kube-users .```
  - ```docker push sirharvey/kube-users```

creer le deploiement :

- ```cd ../kubernetes```
  - ```kubectl apply -f=users-deployment.yaml```

et le service :

- ```kubectl apply -f=users-service.yaml```
  - ```minikube service users-service```

### creer l'image : **Auth**

- ```cd auth-api```
  - ```docker build -t sirharvey/kube-auth .```
  - ```docker push sirharvey/kube-auth```

## Variable d'environement

[docker-compose.yaml](docker-compose.yaml)

```yaml
    environment:
      AUTH_ADDRESS: auth
      AUTH_SERVICE_SERVICE_HOST: auth
```

[users-app.js](users-api/users-app.js)

```js
  const hashedPW = await axios.get(`http://${process.env.AUTH_SERVICE_SERVICE_HOST}/hashed-password/` + password);
```

la variable `AUTH_SERVICE_SERVICE_HOST` est auto generée par kubernetes:

- `AUTH_SERVICE` : indique le nom du service concerné ([auth-service.yaml](kubernetes/auth-service.yaml))
- `SERVICE_HOST` : adresse auto generée

### creer l'image : **Tasks**

- ```cd tasks-api```
  - ```docker build -t sirharvey/kube-tasks .```
  - ```docker push sirharvey/kube-tasks```

creer le deploiement :

- ```cd ../kubernetes```
  - ```kubectl apply -f=tasks-deployment.yaml```

et le service :

- ```kubectl apply -f=tasks-service.yaml```
  - ```minikube service tasks-service```


### creer l'image : **Frontend**

l'accès au tasks-service dans le front se faut comme ça :
[nginx.conf](frontend/conf/nginx.conf) :

```nginx
  location /api/ {
    proxy_pass http://tasks-service.default:8000/;
  }
```

- ```tasks-service``` : le service lancé [tasks-service.yaml](kubernetes/tasks-service.yaml)
- ```.default``` : transforme le servie en URL accessible
- ```:8000``` : le port d'ecoute : [tasks-service.yaml](kubernetes/tasks-service.yaml) et [Dockerfile](tasks-api/Dockerfile)




dans [App.js](frontend/src/App.js), il est recuperé de cette maniere :

```jsx
    fetch(`/api/tasks`, {
      headers: {
        'Authorization': 'Bearer abc'
      }
    })
```

cette URL est visible après avoir lancer : ```minikube service tasks-service```, depuis le dossier [`tasks-api`](tasks-api)

- ```docker build -t sirharvey/kube-front .```
  - ```docker run -p 80:80 --rm -d sirharvey/kube-front```

- ```docker push sirharvey/kube-front```

on peu appliquer service et deploiement

- ```kubectl apply -f=front-service.yaml -f=front-deployment.yaml```
- ```minikube service front-service```
