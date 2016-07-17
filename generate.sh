#!/usr/bin/env bash

set -e # exit on error

function generate() {
    local template="${1}"
    local output="${2}"
    rm -f "${output}"
    envsubst < "${template}" > "${output}"
    chmod go= "${output}"
}

set -a # export declared variables
source "app.env"
source "db.env"
set +a

# required variables
echo "Chosen app directory: '${APP_PATH:?"is required, please edit 'app.env'"}'"
echo "Chosen persistent data directory: '${APP_DB_DIR:?"is required, please edit 'app.env'"}'"
echo "Chosen database user: '${APP_DB_USER:?"is required, please edit 'app.env'"}'"
echo "Chosen container's data directory: '${PGDATA:?"is required, please edit 'db.env'"}'"

generate "template.docker-compose.yml" "docker-compose.yml"
generate "template.Dockerfile.app" "Dockerfile.app"
generate "template.00_db_init.sql" "dbsetup/00_db_init.sql"
