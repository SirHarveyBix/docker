# *Docker*

pour lancer un container qui implique une interaction (ici avec le terminal)

il nous faut lancer la commande :

```docker start --attach --interactive <NAME/ID>``` (```--interactive``` ou ```-i``` & ```--attach``` ou ```-a```)

```--attach```: rend le container "***Listen Only***" son état par defaut est "***Read Only***"

ou
```docker run --interactive --tty <NAME/ID>```
permettra l'intercation avec le container en creer un terminal accessible (```--tty``` ou ```-t```)
