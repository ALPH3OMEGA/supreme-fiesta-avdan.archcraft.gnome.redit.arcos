#!/bin/bash
set -e

DB_USER1="jira"
DB_USER2="confluence"
DB_USER3="crowd"
DB_PASS="1931"

POSTGRES="psql --username ${POSTGRES_USER}"

echo "Creating database role: ${DB_USER1}"

$POSTGRES <<-EOSQL
CREATE USER ${DB_USER1} WITH CREATEDB PASSWORD '${DB_PASS}';
EOSQL

echo "Creating database role: ${DB_USER2}"

$POSTGRES <<-EOSQL
CREATE USER ${DB_USER2} WITH CREATEDB PASSWORD '${DB_PASS}';
EOSQL

echo "Creating database role: ${DB_USER3}"

$POSTGRES <<-EOSQL
CREATE USER ${DB_USER3} WITH CREATEDB PASSWORD '${DB_PASS}';
EOSQL