	createuser --createdb --superuser -Upostgres cononrails
	psql -c "ALTER USER cononrails WITH PASSWORD 'password';"
	psql -c "create database con_on_rails_development owner cononrails encoding 'UTF8' TEMPLATE template0;"
	psql -c "create database con_on_rails_test        owner cononrails encoding 'UTF8' TEMPLATE template0;"
	psql -d con_on_rails_development -c "CREATE EXTENSION hstore;"
	psql -d con_on_rails_development -c "CREATE EXTENSION pg_trgm;"
