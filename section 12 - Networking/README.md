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
