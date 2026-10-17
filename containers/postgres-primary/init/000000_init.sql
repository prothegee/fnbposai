select 'create database fnbposai_pg'
    where not exists (select from pg_database where datname = 'fnbposai_pg')
\gexec

/* --------------------------------------------------------- */

-- the streaming replication role of postgres-replica.
do $$
begin
    if not exists (select 1 from pg_roles where rolname = 'replicator') then
        create role replicator with replication login password 'replicator';
    end if;
end;
$$;

-- a read only role for a reporting tool. it can read every account table but
-- never write one.
do $$
begin
    if not exists (select 1 from pg_roles where rolname = 'reader') then
        create role reader nologin;
    end if;
end;
$$;

grant usage on schema public to reader;
grant select on all tables in schema public to reader;

alter default privileges in schema public
    grant select on tables to reader;
