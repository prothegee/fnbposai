create table if not exists account(
    id              uuid        unique primary key default uuidv7(),
    id_ref          text        unique not null
                                generated always as (replace(id::text, '-', '')) stored,
    email           text        unique not null,
    -- username is trigger fills when omitted if not assign,
    -- see `account_set_username`
    username        text        unique not null,
    password        text        not null,
    -- -- single sign in: postpone
    -- single_sign_in  boolean     not null default false,
    -- signed_in       boolean     null,
    -- last_signed_in  timestamp   null,
    pub_path        text        unique not null
                                generated always as
                                ('a/' || replace(id::text, '-', '') || '/') stored,
    pub_pict        text        null,
    date_created    timestamp   not null default now(),
    last_update     timestamp   null
);

create index if not exists idx_account_id_ref on account(id_ref);
create index if not exists idx_account_email_username
    on account(email, username);

-- functions
create or replace function account_set_username()
returns trigger
language plpgsql
as $$
begin
    if new.username is null then
        new.username := replace(new.id::text, '-', '');
    end if;
    return new;
end;
$$;

-- trigger
drop trigger if exists trg_account_set_username on account;

create trigger trg_account_set_username
before insert on account
for each row
execute function account_set_username();
