FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  software-properties-common \
  postgresql \
  postgresql-client \
  postgresql-contrib
RUN add-apt-repository ppa:ubuntugis/ppa
RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
  postgresql-10-postgis-2.5 \
  postgresql-10-postgis-2.5-scripts \
  osm2pgsql

USER postgres
# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
#RUN /etc/init.d/postgresql start \
#  && psql --command "CREATE USER osm WITH SUPERUSER PASSWORD 'osm';" \
#  && createdb -E UTF8 -O osm gis \
#  && psql -d gis -c "CREATE EXTENSION postgis;" \
#  && psql -d gis -c "CREATE EXTENSION hstore;"
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
EXPOSE 5432
# Add VOLUMEs to allow backup of config, logs and databases
#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/10/bin/postgres", "-D", "/var/lib/postgresql/10/main", "-c", "config_file=/etc/postgresql/10/main/postgresql.conf"]