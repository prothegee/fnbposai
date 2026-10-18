do $$
begin
    begin
    create type currency_t as enum(
        'USD'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

do $$
begin
    begin
    create type weight_t as enum(
        -- pcs can't be convert for now
        'ton', 'kg', 'g', 'mg', 'galon', 'L', 'ml', 'pcs'
    );
    exception when duplicate_object then null;
    end;

    -- begin
    -- /*
    -- Only apply if weight use pcs,
    -- on use pcs_convertion
    -- */
    -- create type weight_correction_t as enum(
    --     'ton', 'kg', 'g', 'mg', 'galon', 'L', 'ml'
    -- );
    -- exception when duplicate_object then null;
    -- end;

    begin
    create type length_t as enum(
        'mm', 'cm', 'm'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

create table if not exists pos_items(
    id                          uuid                primary key default uuidv7(),
    id_tenant                   uuid                not null,
    id_tenant_branch            uuid                not null,
    name                        text                not null,
    /*
    If true,
    and item from the order create and the status on processing,
    the ammount of _deduct will be reduce from stocks respectively.
    */
    use_sync_stock              boolean             not null default false,
    thumbnail                   text                not null default '',
    description                 text                null,
    category                    text                null,
    tags                        text[]              null,
    out_of_order                boolean             not null default false,
    /*
    If true,
    after item that've been ordered status is on processing and mark as completed,
    and stock is lacking, the out_of_order is set to true.
    */
    use_auto_out_of_order       boolean             not null default false,
    price                       numeric(15,2)       not null,
    currency                    currency_t          not null default 'USD',
    /*
    A time to process fo this items when customer make an order.
    In monitor kiba, if the process time more than this. It's should has danger or warn.
    Format hh:mm:ss
    */
    processing_time             time                not null,
    /*
    A cancelation processing time, customer sometime want to cancel their order.
    But if this time is hit, they can't cancel their order. Stock already deduct.
    */
    cancelation_processing_time time                not null default '00:00:30',
    weight                      numeric(15,2)       null,
    weight_unit                 weight_t            null,
    -- weight_correction           numeric(15,2)       null,
    -- weight_correction_unit      weight_correction_t null,
    dimension_x                 numeric             null,
    dimension_y                 numeric             null,
    dimension_z                 numeric             null,
    dimension_unit              length_t            null,
    date_created                timestamp           not null default now(),
    last_update                 timestamp           null,

    constraint chk_pos_items_tags_max
        check (tags is null or cardinality(tags) <= 6),
    constraint chk_pos_items_price
        check (price >= 0)
);

create index if not exists idx_pos_items_id_tenant on pos_items(id_tenant);
create index if not exists idx_pos_items_id_tenant_branch on pos_items(id_tenant_branch);
create index if not exists idx_pos_items_name on pos_items(name);

/* --------------------------------------------------------- */

create table if not exists pos_stocks(
    id                  uuid                primary key default uuidv7(),
    id_tenant           uuid                not null,
    id_tenant_branch    uuid                not null,
    name                text                not null,
    quantity            bigint              not null default 0,
    quantity_warning    bigint              not null default 0,
    thumbnail           text                not null default '',
    description         text                null,
    category            text                null,
    tags                text[]              null,
    out_of_stock        boolean             not null default false,
    extra_info          text                null,
    weight              numeric             null,
    weight_deduct       numeric             not null default 0,
    weight_unit         weight_t            null,
    dimension_x         numeric             null,
    dimension_y         numeric             null,
    dimension_z         numeric             null,
    dimension_unit      length_t            null,
    date_created        timestamp           not null default now(),
    last_update         timestamp           null,

    constraint chk_stocks_tags_max
        check (tags is null or cardinality(tags) <= 6),
    constraint chk_stocks_quantity
        check (quantity >= 0),
    constraint chk_stocks_quantity_warning
        check (quantity_warning >= 0),
    constraint chk_stocks_weight_deduct
        check (
            (weight is null and weight_deduct = 0)
            or
            (
                weight is not null
                and weight > 0
                and weight_deduct >= 0
                and weight_deduct < weight
            )
        )
);

create index if not exists idx_pos_stocks_id_tenant on pos_stocks(id_tenant);
create index if not exists idx_pos_stocks_id_tenant_branch on pos_stocks(id_tenant_branch);
create index if not exists idx_pos_stocks_name on pos_stocks(name);

/* --------------------------------------------------------- */

create table if not exists pos_items_builder(
    id                      uuid            primary key default uuidv7(),
    id_item                 uuid            not null,
    id_stock                uuid            not null,
    stock_weight            numeric         not null,
    stock_weight_unit       weight_t        not null default 'kg',
    date_created            timestamp       not null default now(),
    last_update             timestamp       null,

    constraint fk_pos_items_builder_id_item
        foreign key (id_item)
        references pos_items(id)
        on delete cascade,
    constraint fk_pos_items_builder_id_stock
        foreign key (id_stock)
        references pos_stocks(id)
        on delete cascade
);

create index if not exists idx_pos_items_builder_id_item on pos_items_builder(id_item);
create index if not exists idx_pos_items_builder_stock_id on pos_items_builder(id_stock);

/* --------------------------------------------------------- */

/*
NOTE:
- A branch can have multiple registers.
- No unique constraint on (id_branch, name) is intentional,
  so this is allowed.
- Each shift references one register via pos_shifts.register_id.
*/
create table if not exists pos_registers(
    id                  uuid            primary key default uuidv7(),
    id_tenant           uuid            not null,
    id_tenant_branch    uuid            not null,
    /*
    examples:
    - Register 1
    - Front Counter
    - Drive-thru
    - Bar Drawer
    - Walking Cashier #1
    - etc.
    */
    name                text            not null,
    note                text            null,
    date_created        timestamp       not null default now(),
    last_update         timestamp       null,

    constraint fk_pos_registers_id_tenant
        foreign key (id_tenant)
        references tenant(id)
        on delete cascade,
    constraint fk_pos_registers_id_branch
        foreign key (id_tenant_branch)
        references tenant_branch(id)
        on delete cascade
);

create index if not exists idx_pos_registers_id_tenant on pos_registers(id_tenant);
create index if not exists idx_pos_registers_id_branch on pos_registers(id_tenant_branch);

/* --------------------------------------------------------- */

do $$
begin
    begin
    create type shift_t as enum(
        'open', 'closed'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

create table if not exists pos_shifts(
    id                  uuid            primary key default uuidv7(),
    id_tenant           uuid            not null,
    id_tenant_branch    uuid            not null,
    id_account          uuid            not null,
    id_register         uuid            null,
    opening_cash        numeric(15,2)   not null default 0,
    closing_cash        numeric(15,2)   null,
    opened_at           timestamp       not null default now(),
    closed_at           timestamp       null,
    notes               text            null,
    status              shift_t         not null default 'open',

    constraint fk_pos_shifts_id_tenant
        foreign key (id_tenant)
        references tenant(id)
        on delete cascade,
    constraint fk_pos_shifts_id_tenant_branch
        foreign key (id_tenant_branch)
        references tenant_branch(id)
        on delete cascade,
    constraint fk_pos_shifts_id_account
        foreign key (id_account)
        references account(id)
        on delete cascade,
    constraint fk_pos_shifts_id_register
        foreign key (id_register)
        references pos_registers(id)
        on delete set null
);

create index if not exists idx_pos_shifts_id_tenant on pos_shifts(id_tenant);
create index if not exists idx_pos_shifts_id_tenant_branch on pos_shifts(id_tenant_branch);
create index if not exists idx_pos_shifts_id_account on pos_shifts(id_account);
create index if not exists idx_pos_shifts_status on pos_shifts(status);

/*
NOTE:
- A user can only have one open shift per branch.
- A partial unique index keeps that rule while the closed shifts stay.
*/
create unique index if not exists uq_pos_shifts_open_per_account_branch
    on pos_shifts(id_tenant_branch, id_account)
    where status = 'open';

/* --------------------------------------------------------- */

do $$
begin
    begin
    create type order_t as enum('dine in', 'take away', 'online order');
    exception when duplicate_object then null;
    end;

    begin
    create type order_status_t as enum(
        'pending', 'processing', 'ready', 'completed', 'cancel'
    );
    exception when duplicate_object then null;
    end;
end;
$$;

create table if not exists pos_orders(
    id                  uuid                primary key default uuidv7(),
    id_tenant           uuid                not null,
    id_tenant_branch    uuid                not null,
    -- author who create the order
    id_author_account   uuid                not null,
    id_shift            uuid                null,
    -- list of applied taxex
    id_tenant_taxes     uuid[]              null,
    type                order_t             not null default 'dine in',
    is_open_bill        boolean             not null default false,
    customer_name       text                null,
    customer_phone      text                null,
    customer_email      text                null,
    note                text                null,
    table_number        text                null,
    date_created        timestamp           not null default now(),
    last_update         timestamp           null,

    constraint fk_orders_id_shift
        foreign key (id_shift)
        references pos_shifts(id)
        on delete set null
);

create index if not exists idx_pos_orders_id_tenant on pos_orders(id_tenant);
create index if not exists idx_pos_orders_id_tenant_branch on pos_orders(id_tenant_branch);
create index if not exists idx_pos_orders_id_author_account on pos_orders(id_author_account);
create index if not exists idx_pos_orders_type on pos_orders(type);
create index if not exists idx_pos_orders_customer_info
    on pos_orders(customer_name, customer_phone, customer_email);
create index if not exists idx_pos_orders_id_shift on pos_orders(id_shift);
create index if not exists idx_pos_orders_tenant_branch_created
    on pos_orders(id_tenant_branch, date_created desc);

/* --------------------------------------------------------- */

/*
NOTE:
- `status` carries the kitchen state of one line, and the bulk complete
  action of the orders page sets the checked lines to `completed`.
- When no line is left to serve, the order itself walks the flow to
  `completed`, which is what lets its shift close.
- `date_created` is the order line time the contract answers.
*/
create table if not exists pos_orders_items(
    id                  uuid            primary key default uuidv7(),
    id_order            uuid            not null,
    id_item             uuid            not null,
    quantity            bigint          not null default 1,
    -- multiplied by this quantity
    price_at_order      numeric(15,2)   not null,
    currency_at_order   currency_t      not null default 'USD',
    status              order_status_t  not null default 'pending',
    date_created        timestamp       not null default now(),
    last_update         timestamp       null,

    constraint fk_pos_orders_items_id_order
        foreign key (id_order)
        references pos_orders(id)
        on delete cascade,
    constraint fk_pos_orders_items_id_item
        foreign key (id_item)
        references pos_items(id)
        on delete cascade
);

create index if not exists idx_pos_orders_items_id_order on pos_orders_items(id_order);
create index if not exists idx_pos_orders_items_id_item on pos_orders_items(id_item);

/* --------------------------------------------------------- */

do $$
begin
    begin
    create type payment_t as enum('pending', 'declined', 'paid');
    exception when duplicate_object then null;
    end;

    begin
    create type payment_method_t as enum('cash', 'debit', 'credit', 'qr');
    exception when duplicate_object then null;
    end;
end;
$$;

create table if not exists pos_orders_payments(
    id_order            uuid                primary key,
    total               numeric(15,2)       not null,
    currency            currency_t          not null default 'USD',
    status              payment_t           not null default 'pending',
    method              payment_method_t    not null default 'cash',
    date_created        timestamp           not null default now(),
    last_update         timestamp           null,

    constraint fk_pos_orders_payments_id_order
        foreign key (id_order)
        references pos_orders(id)
        on delete cascade
);

/* --------------------------------------------------------- */
-- POSTONE

-- do $$
-- begin
--     begin
--     create type notification_t as enum(
--         'order in'
--     );
--     exception when duplicate_object then null;
--     end;
-- end;
-- $$;
--
-- create table if not exists pos_notifications(
--     id                  uuid            primary key default uuidv7(),
--     id_tenant           uuid            not null,
--     id_tenant_branch    uuid            not null,
--     data                jsonb           null,
--     type                notification_t  not null,
--     date_created        timestamp       not null default now(),
--     last_update         timestamp       null,
--
--     constraint fk_pos_notification_id_tenant
--         foreign key (id_tenant)
--         references tenant(id)
--         on delete cascade,
--     constraint fk_pos_notification_id_tenant_branch
--         foreign key (id_tenant_branch)
--         references tenant_branch(id)
--         on delete cascade
-- );
--
-- create index if not exists idx_pos_notifications_id_tenant
--     on pos_notifications(id_tenant);
-- create index if not exists idx_pos_notifications_id_tenant_branch
--     on pos_notifications(id_tenant_branch);
