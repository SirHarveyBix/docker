FROM node

WORKDIR /app

COPY package.json /app

RUN yarn 

COPY . /app

EXPOSE 80

ENV MONGODB_USERNAME=guillaume
ENV MONGODB_PASSWORD=secret

CMD [ "yarn", "start" ]