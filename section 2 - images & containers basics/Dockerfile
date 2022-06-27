FROM node

WORKDIR /app

COPY package.json /app
# copy package.json first to rebuild faster.

RUN npm install
# executed when the image is created

COPY . /app
# '.' > all files in the current folder, '/app'> path inside of the image

EXPOSE 80
# expose a certain port to our local system, but unecessary,
# to publish under a port : -p 3000:80

CMD ["node", "server.js"]
# executed when the container is started, not when the image is created