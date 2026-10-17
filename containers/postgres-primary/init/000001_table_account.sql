create table if not exists account(
    id              uuid        unique primary key default uuidv7(),
    id_ref          text        unique not null
                                generated always as (replace(id::text, '-', '')) stored,
    email           text        unique not null,
    username        text        unique not null
                                generated always as
                                (regexp_replace(email, '[.@]', '', 'g')) stored,
    password        text        not null,
    pub_path        text        unique not null
                                generated always as
                                ('a/' || replace(id::text, '-', '')) stored,
    pub_pict        text null,
    date_created    timestamp   not null default now(),
    last_update     timestamp   null
);

create index if not exists idx_account_id_ref on account(id_ref);
create index if not exists idx_account_email_username
    on account(email, username);
