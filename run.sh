#!/usr/bin/env bash

#docker build -t biker-postgres --no-cache=true .

# docker run \
#     --name bikedb \
#     --env POSTGRES_PASSWORD=password \
#     --detach \
#     -p 5432:5432 \
#     --network dbnetwork \
#     biker-postgres

docker run -p 8080:80 \
    --name pgAdmin \
    --network dbnetwork \
    --env 'PGADMIN_DEFAULT_EMAIL=example@cirelli.org' \
    --env 'PGADMIN_DEFAULT_PASSWORD=password' \
    --detach dpage/pgadmin4
