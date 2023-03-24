FROM node:18.12.1-alpine
# FROM node:18.12.1

ARG HOMEDIR="app"

ENV HOME=/$HOMEDIR \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    # コンテナのnuxt.jsをブラウザから参照するため
    HOST=0.0.0.0

# RUN echo $HOMEDIR
# RUN echo $CONTAINER_PORT

WORKDIR $HOMEDIR
COPY package*.json ./
COPY  .yarnrc ./

RUN apk update && \
    apk upgrade && \
    npm install -g n && \
    yarn install &&\
    rm -rf /var/cache/apk/*

COPY ./ ./

# EXPOSE 3000
# CMD ["yarn", "run", "dev"]
