FROM node:current-slim

WORKDIR /app
RUN yarn install

CMD [ "yarn", "start" ]

COPY . /app