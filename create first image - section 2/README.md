# docker

```docker run node``` : lance l'image de node, elle sera telechargée si elle n'est pas en localdocker

```docker ps -a``` >>>
(all containers created)

```shell
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                        PORTS     NAMES
04bc4b53715b   node           "docker-entrypoint.s…"   1 minute ago     Exited (0)   58 seconds ago             vibrant_curie
965b239eb6bb   f8126319560a   "docker-entrypoint.s…"   39 minutes ago   Exited (137) 38 minutes ago             reverent_kare
38f87efdcf23   f8126319560a   "docker-entrypoint.s…"   43 minutes ago   Exited (137) 40 minutes ago             cranky_mestorf
68fb8759064e   f8126319560a   "docker-entrypoint.s…"   47 minutes ago   Exited (137) 44 minutes ago             focused_shamir
```

```docker run -it node``` >> run node iteractive, on pourra interagir avec le container

``` ```