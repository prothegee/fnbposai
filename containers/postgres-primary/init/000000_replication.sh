#!/bin/bash
set -e

echo "host replication ${POSTGRES_USER} all scram-sha-256" >> "$PGDATA/pg_hba.conf"
