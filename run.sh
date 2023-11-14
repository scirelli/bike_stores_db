#!/usr/bin/env bash

docker build -t biker-postgres --no-cache=true .

# docker run \
#     --name bikedb \
#     --env POSTGRES_PASSWORD=password \
#     --detach \
#     -p 5432:5432 \
#     --network dbnetwork \
#     biker-postgres
