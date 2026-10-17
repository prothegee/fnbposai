create table if not exists tenant(
    id              uuid        unique primary key default uuidv7(),
    id_ref          text        unique not null
                                generated always as (replace(id::text, '-', '')) stored,
    -- All lower case, only accept alphanumeric and 1 whitespace.
    name            text        unique not null,
    -- This is came from where user owner assign their tenant name
    -- accept combination upper+lower case, alphanumeric, 1 whitespace after char,
    -- and symbols. No emoji.
    name_display    text        not null,
    owner           uuid        not null,
    date_created    timestamp   not null default now(),
    last_update     timestamp   null,

    constraint fk_tenant_owner
        foreign key (owner)
        references account(id)
        on delete cascade
);

/* --------------------------------------------------------- */

create table if not exists tenant_branch(
    id              uuid        unique primary key default uuidv7(),
    id_ref          text        unique not null
                                generated always as (replace(id::text, '-', '')) stored,
    id_tenant       uuid        not null,
    -- All lower case, only accept alphanumeric and 1 whitespace.
    name            text        unique not null,
    -- This is came from where user owner assign their tenant name
    -- accept combination upper+lower case, alphanumeric, 1 whitespace after char,
    -- and symbols. No emoji.
    name_display    text        not null,
    owner           uuid        not null,
    pub_path        text        unique not null
                                generated always as
                                (
                                't/' ||
                                replace(id_tenant::text, '-', '') ||
                                '/' ||
                                replace(id::text, '-', '')
                                ) stored,
    pub_pict        text        null,
    date_created    timestamp   not null default now(),
    last_update     timestamp   null,

    constraint fk_branch_id_tenant
        foreign key (id_tenant)
        references tenant(id)
        on delete cascade,
    constraint fk_tenant_owner
        foreign key (owner)
        references account(id)
        on delete cascade
);

create table if not exists tenant_branch(
    id              uuid        unique primary key default uuidv7(),
    id_ref          text        unique not null
                                generated always as (replace(id::text, '-', '')) stored,
    id_tenant       uuid        not null,
    -- All lower case, only accept alphanumeric and 1 whitespace.
    name            text        not null,
    -- This is came from where user owner assign their tenant name
    -- accept combination upper+lower case, alphanumeric, 1 whitespace after char,
    -- and symbols. No emoji.
    name_display    text        not null,
    owner           uuid        not null,
    pub_path        text        unique not null
                                generated always as
                                (
                                't/' ||
                                replace(text, '-', '') ||
                                '/' ||
                                replace(id::text, '-', '')
                                ) stored,
    pub_pict        text        null,
    date_created    timestamp   not null default now(),
    last_update     timestamp   null,

    constraint fk_branch_id_tenant
        foreign key (id_tenant)
        references tenant(id)
        on delete cascade,
    constraint fk_tenant_owner
        foreign key (owner)
        references account(id)
        on delete cascade
);

/* --------------------------------------------------------- */

do $$
begin
    begin
        create type role_t as enum(
        /*
        NOTE:
        - 'owner':
            - Enum object in go/ts: `Owner`.
            - Can add/edit/remove member
              (role_definition by default is 'member').
            - Can add/edit member `members:position`
              (i.e. "Manager", "Barista", "Cashier", & etc.).
            - Can assign role_definition for member
              as 'tenant admin', 'branch admin', or 'member'.
        - 'tenant admin':
            - Enum object in go/ts: 'TenantAdmin'.
            - Can add/edit/remove member
              but not 'owner',
              (role_definition by default is 'member').
            - Can add/edit member `members:position`
              (i.e. "Manager", "Barista", "Cashier", & etc.).
            - Can assign role_definition for member
              as 'branch admin', or 'member'.
        - 'branch admin':
            - Enum object in go/ts: 'BranchAdmin'.
            - Can add/edit/remove member
              but not 'owner' & 'tenant admin',
              (role_definition by default is 'member').
            - Can add/edit member `members:position`
              (i.e. "Manager", "Barista", "Cashier", & etc.).
            - Can assign role_definition for member
              as 'branch admin', or 'member'.
        - 'member':
            - Enum object is go/ts: `Member`.
        */
        'owner', 'tenant admin', 'branch admin', 'member'
        );
    end;

    begin
    create type access_t as enum(
        /*
        NOTE:
        - When owner successfuly registered,
          all access below must be assign.
        */
        'items', 'orders', 'sales', 'tenant', 'stocks', 'monitor kiba'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

create table if not exists tenant_members(
    id_tenant           uuid            not null,
    id_tenant_branch    uuid            not null,
    id_account          uuid            not null,
    role                role_t          not null,
    position            text            null,
    accesses            access_t[]      null,
    date_created        timestamp       not null default now(),
    last_update         timestamp       null,

    primary key (id_tenant, id_tenant_branch, id_account),

    constraint fk_members_id_tenant
        foreign key (id_tenant)
        references tenant(id)
        on delete cascade,
    constraint fk_members_id_branch
        foreign key (id_tenant_branch)
        references tenant_branch(id)
        on delete cascade,
    constraint fk_members_id_account
        foreign key (id_account)
        references account(id)
        on delete cascade
);

create index if not exists idx_members_id_tenant_branch on tenant_members(id_tenant_branch);
create index if not exists idx_members_id_account on tenant_members(id_account);
