# FROM ruby:3.1.2
FROM ruby:3.1.2-alpine

ENV LANG C.UTF-8
ENV APP_ROOT /app
ENV BUNDLE_JOBS 4
# ENV BUNDLER_VERSION 2.3.25

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN apk update && \
    apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs yarn tzdata bash mysql-dev && \
    apk add --no-cache -t .build-packages --no-cache build-base curl-dev mysql-client && \
    bundle install -j4 && \
    apk del --purge .build-packages

# RUN gem install bundler -v $BUNDLER_VERSION
# RUN bundle -v
# RUN bundle install

COPY . $APP_ROOT

COPY ./docker/web/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

EXPOSE 3000

# 起動の度にデフォルトでrails sする（entrypoint.shに持たせても良い）
# CMD ["sh", "./docker/web/start-server.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]