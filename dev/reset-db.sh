#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

if [[ -f .env ]]; then
    while IFS='=' read -r name value || [[ -n "$name" ]]; do
        value="${value%$'\r'}"
        case "$name" in
            FITGRESS_DB_NAME)
                if [[ -z ${FITGRESS_DB_NAME+x} ]]; then export FITGRESS_DB_NAME="$value"; fi
                ;;
            FITGRESS_DB_USER)
                if [[ -z ${FITGRESS_DB_USER+x} ]]; then export FITGRESS_DB_USER="$value"; fi
                ;;
            FITGRESS_DB_PASSWORD)
                if [[ -z ${FITGRESS_DB_PASSWORD+x} ]]; then export FITGRESS_DB_PASSWORD="$value"; fi
                ;;
            POSTGRES_PORT)
                if [[ -z ${POSTGRES_PORT+x} ]]; then export POSTGRES_PORT="$value"; fi
                ;;
        esac
    done < .env
fi

export FITGRESS_DB_NAME="${FITGRESS_DB_NAME:-fitgress}"
export FITGRESS_DB_USER="${FITGRESS_DB_USER:-fitgress}"
export FITGRESS_DB_PASSWORD="${FITGRESS_DB_PASSWORD:-fitgress}"
export POSTGRES_PORT="${POSTGRES_PORT:-5432}"
export FITGRESS_DB_URL="${FITGRESS_DB_URL:-jdbc:postgresql://localhost:${POSTGRES_PORT}/${FITGRESS_DB_NAME}}"

if [[ -x backend/mvnw ]]; then
    exec ./backend/mvnw -f backend/pom.xml -Dflyway.cleanDisabled=false flyway:clean flyway:migrate "$@"
elif [[ -f backend/mvnw ]]; then
    exec bash backend/mvnw -f backend/pom.xml -Dflyway.cleanDisabled=false flyway:clean flyway:migrate "$@"
else
    exec mvn -f backend/pom.xml -Dflyway.cleanDisabled=false flyway:clean flyway:migrate "$@"
fi
