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
COPY ./ ./
RUN apk update && apk add bash

RUN yarn install

# EXPOSE 3000
CMD ["yarn", "run", "dev"]
