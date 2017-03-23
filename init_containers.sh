#!/bin/sh

# start the web image
docker-compose up -d web

# fetch project dependencies
docker-compose run web mix do deps.get, compile

# init database
docker-compose run web mix ecto.create 
docker-compose run web mix ecto.migrate

# install js deps
docker-compose run web npm config set strict-ssl false
docker-compose run web npm install

# stop the web image
docker-compose stop web

