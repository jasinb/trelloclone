#!/bin/sh

docker-compose run -e MIX_ENV=test web mix test
