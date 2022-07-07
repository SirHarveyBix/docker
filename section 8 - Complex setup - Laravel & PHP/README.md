# Docker

pour lancer initialier un projet php (si tout les outils sont installer):

```composer create-project --prefer-dist laravel/laravel```

puisque nous avont creer notre _utility container_ :

```yaml
composer:
    build:
      context: ./dockerfiles
      dockerfile: composer.dockerfile
    volumes:
      - ./src:/var/www/html
  ```

Lancez plutot :

```shell
docker-compose run --rm composer create-project --prefer-dist laravel/laravel .
```

il vous faudra desplacer le ficher [here.md](./src/here.md), il contient des infos concernant le fichier .env, et bloquera votre installation.

votre ficher src est maintenant le code source d'un appli laravel

pour lancer tout les services : ```docker-compose up```
mais ici nous ne voulons lancer (pour l'instant) que server, php, mysql

- ```docker-compose up -d --build server```
- ```--build```
  - dans docker compose permet de rebuild au changement du fichier 
- ```server``` lancera aussi : php, mysql, puisque :

  -
    ```yaml
    depends_on:
      - php
      - mysql
    ```

pour lancer l'artisant : ```docker compose run --rm artisan migrate```  

## context

_**important**_

la difference entre

```yaml
    build: 
      context: .
      dockerfile: dockerfiles/php.dockerfile
```

et

```yaml
    build: 
      context: ./dockerfiles
      dockerfile: composer.dockerfile
```

c'ets la localisation du contexte,
dans le cas ou ```context: .``` va determiner le context ou se situe le docker-compse et dans ce ca : ```context: ./dockerfiles``` dans le dossier concerné.
dans  `nginx.dockerfile` ou trouve la ligne :

```yaml
COPY src .
```

dans le cas ou ```context: .```, tout se passera bien, a la racine du docker-compose il existe bien un dossier src, en revance, ici : ```context: ./dockerfiles```, vous aurez une erreur, le dossier src n'exite pas dans ce dossier.

