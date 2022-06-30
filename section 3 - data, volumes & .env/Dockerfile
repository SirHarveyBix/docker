FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

# VOLUME [ "/app/node_modules" ] => a reverifier
#  creer un volume anonyme pour empecher l'ecrasement generé par la commande :
#  -v "C:/Users/[USERNAME]/code/docker/section 3 - data & volumes:/app"
#  il est aussi possible d'ajouter a la suite de la commande precedente : -v /app/node_modules

COPY . .

ARG DEFAULT_PORT=80

ENV PORT $DEFAULT_PORT

EXPOSE $PORT

CMD [ "npm", "start" ]