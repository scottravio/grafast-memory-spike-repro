PG_PASSWORD := 'mysecretpassword1'

postgres:
	docker run -e POSTGRES_PASSWORD=$(PG_PASSWORD) -p 5432:5432 -d postgres:15

schema:
	 PGPASSWORD=$(PG_PASSWORD) psql -h localhost -U postgres < ./schema.sql

data:
	 PGPASSWORD=$(PG_PASSWORD) psql -h localhost -U postgres grafast_repro < ./data.sql