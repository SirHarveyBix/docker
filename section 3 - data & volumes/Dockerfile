FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

# VOLUME [ "/app/feedback" ]
# ecoute le dossier /app/feedback dans le container

CMD [ "node", "server.js" ]