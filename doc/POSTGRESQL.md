This is not really intended as instructions (yet) -- just notes to make sure pieces don't get left out.

Eventually, deployment scripts should automate some of this.


sudo aptitude install postgres-8.4 libpq-dev

	createuser --createdb --superuser -Upostgres con_on_rails
	psql -c "ALTER USER con_on_rails WITH PASSWORD 'password';"
	psql -c "create database con_on_rails_production owner con_on_rails encoding 'UTF8' TEMPLATE template0;"
#    psql -c "create database con_on_rails_development owner con_on_rails encoding 'UTF8' TEMPLATE template0;"
#	psql -c "create database con_on_rails_test        owner con_on_rails encoding 'UTF8' TEMPLATE template0;"
#	psql -d con_on_rails_development -c "CREATE EXTENSION hstore;"
#	psql -d con_on_rails_development -c "CREATE EXTENSION pg_trgm;"
