SHELL=bash

.PHONY: build
build:
	@docker build -t biker-postgres --no-cache=true .
	@docker network create -d bridge dbnetwork

.PHONY: run
run:
	@docker run \
		--name bikedb \
		--env POSTGRES_PASSWORD=password \
		--env POSTGRES_DB=bikestores \
		--detach \
		-p 5432:5432 \
		--network dbnetwork \
		biker-postgres

.PHONY: clean
clean:
	@docker stop bikedb || echo 'Not running'
	@docker rm bikedb || echo 'No container to remove'
	@docker rmi biker-postgres || echo 'No image to remove'

.PHONY: logs
logs:
	@docker logs bikedb

.PHONY: psql
psql:
	@docker run -it --rm --network dbnetwork --env PGPASSWORD=password postgres psql -h bikedb -U postgres -d bikestores
.PHONY: sql
sql: psql

all: build
	$(MAKE) run
	$(MAKE) logs
