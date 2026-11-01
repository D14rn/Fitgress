#!/bin/sh
set -eu

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" --dbname postgres \
  -v app_user="$FITGRESS_DB_USER" \
  -v app_password="$FITGRESS_DB_PASSWORD" \
  -v app_db="$FITGRESS_DB_NAME" <<'EOSQL'
CREATE ROLE :"app_user" LOGIN PASSWORD :'app_password';
CREATE DATABASE :"app_db" OWNER :"app_user";
REVOKE ALL ON DATABASE :"app_db" FROM PUBLIC;
EOSQL

psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRES_USER" --dbname "$FITGRESS_DB_NAME" \
  -v app_user="$FITGRESS_DB_USER" \
  -v app_db="$FITGRESS_DB_NAME" <<'EOSQL'
CREATE SCHEMA fitgress AUTHORIZATION :"app_user";
ALTER ROLE :"app_user" IN DATABASE :"app_db" SET search_path = fitgress;
EOSQL
