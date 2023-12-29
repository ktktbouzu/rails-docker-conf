FROM ruby:3.0.0-alpine3.13

ENV ROOT="/rails"

ENV RAILS_ENV="development"
RUN apk update
RUN apk add --no-cache make
RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache build-base
RUN apk add --no-cache sqlite-libs
RUN apk add --no-cache --virtual=.build-deps \
    git \
    openssh-client \
    mariadb-dev \
    sqlite-dev \
    vips-dev \ 
    pkgconfig \
    nodejs \
    && apk del .build-deps

WORKDIR ${ROOT}

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN gem install bundler

RUN bundle update
RUN bundle install