#!/usr/bin/env bash
# Bootstrap the replica from the primary once, then hand off to the
# official postgres entrypoint. Must run BEFORE the server starts, so it
# lives here as the entrypoint, not in /docker-entrypoint-initdb.d/.
set -euo pipefail

primary_host="${PRIMARY_HOST:-fnbposai-db-pg-primary}"
primary_port="${PRIMARY_PORT:-5432}"
replication_user="${POSTGRES_USER:?POSTGRES_USER is required}"
replication_password="${POSTGRES_PASSWORD:?POSTGRES_PASSWORD is required}"

if [ ! -s "${PGDATA}/PG_VERSION" ]; then
    echo "waiting for primary ${primary_host}:${primary_port}"
    until pg_isready -h "${primary_host}" -p "${primary_port}" \
                     -U "${replication_user}" >/dev/null 2>&1; do
        sleep 2
    done

    echo "taking base backup from ${primary_host}:${primary_port}"
    mkdir -p "${PGDATA}"
    chown postgres:postgres "${PGDATA}"
    chmod 0700 "${PGDATA}"

    # Runs as root otherwise → files owned by root → postgres can't write.
    PGPASSWORD="${replication_password}" gosu postgres pg_basebackup \
        --host="${primary_host}" \
        --port="${primary_port}" \
        --username="${replication_user}" \
        --pgdata="${PGDATA}" \
        --wal-method=stream \
        --write-recovery-conf \
        --progress \
        --verbose
fi

# --write-recovery-conf writes primary_conninfo without the password, and
# the walreceiver inherits the postmaster's env. Export so libpq picks it up.
export PGPASSWORD="${replication_password}"

exec docker-entrypoint.sh "$@"
