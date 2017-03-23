FROM elixir
MAINTAINER Jasin Bushnaief <jasin@iki.fi>
ENV DEBIAN_FRONTEND=noninteractive

RUN mix local.hex --force
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -y nodejs inotify-tools

# install Phoenix
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# init npm
RUN npm init -f
RUN npm i webpack --save-dev

WORKDIR /app

