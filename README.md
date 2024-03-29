# jklose/pg10-osm2pgsql

## OpenStreetMap Ready PostgreSQL With Tools

A docker image with a prepared Postgres database and [osm2pgsql](https://github.com/openstreetmap/osm2pgsql), the tool for importing and updating data into the db.

## Used Versions

| software   | version |
| ---------- | ------- |
| postgresql | 10      |
| postgis    | 2.5     |
| osm2pgsql  | 0.94    |


## Create database example

```
docker exec your_container /bin/bash -c "psql --command \"CREATE USER osm WITH SUPERUSER PASSWORD 'osm';\" && createdb -E UTF8 -O osm gis && psql -d gis -c \"CREATE EXTENSION postgis;\"  && psql -d gis -c \"CREATE EXTENSION hstore;\""
```