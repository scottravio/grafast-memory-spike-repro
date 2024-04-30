PG_PASSWORD := 'mysecretpassword1'
CONTAINER_NAME := 'grafast-repro-postgres'

.PHONY: postgres schema data all

postgres:
	@docker rm -f $(CONTAINER_NAME)
	@docker run --name $(CONTAINER_NAME) -e POSTGRES_PASSWORD=$(PG_PASSWORD) -p 5432:5432 -d postgres:15
	@echo sleeping 5s to give postgres time to start...
	@sleep 5

schema:
	 @PGPASSWORD=$(PG_PASSWORD) psql -h localhost -U postgres < ./schema.sql

data:
	 @PGPASSWORD=$(PG_PASSWORD) psql -h localhost -U postgres grafast_repro < ./data.sql

all: postgres schema data