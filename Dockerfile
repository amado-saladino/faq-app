FROM node:current-slim

WORKDIR /app
COPY ./package.json ./
RUN yarn install
COPY . /app
CMD [ "yarn", "start" ]
