FROM node:14-alpine

WORKDIR /app

COPY package.json /app

RUN yarn

COPY . /app

EXPOSE 8080

CMD [ "node", "app.js" ]