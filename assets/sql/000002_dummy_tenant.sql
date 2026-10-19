/*
IMPORTANT:
- This is for demo/debug only
*/

/* --------------------------------------------------------- */

/*
- id:           01a14e6f-ab53-74d4-af99-f9e541108ba0
- id_ref:       01a14e6fab5374d4af99f9e541108ba0
- name_display: Sunrise Cafe
- owner:        01a14e6f-1b71-79e1-b42c-cfe9c0cbde32

*/
insert into tenant
(
    id,
    name_display,
    owner
)
values
(
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    'Sunrise Cafe',
    '01a14e6f-1b71-79e1-b42c-cfe9c0cbde32'
)
on conflict do nothing;

/* --------------------------------------------------------- */

/*
- id:           01a14e70-c4b6-70bb-b65a-899d4a53fc9d
- id_ref:       01a14e70c4b670bbb65a899d4a53fc9d
- id_tenant:    01a14e6f-ab53-74d4-af99-f9e541108ba0
- name_display: Downtown Branch
*/
insert into tenant_branch
(
    id,
    id_tenant,
    name_display
)
values
(
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    'Downtown Branch'
)
on conflict do nothing;

/* --------------------------------------------------------- */

insert into tenant_members
(
    id_tenant,
    id_tenant_branch,
    id_account,
    role,
    position,
    accesses
)
values
(
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    '01a14e6f-1b71-79e1-b42c-cfe9c0cbde32',
    'owner',
    'Owner',
    array['items', 'orders', 'sales', 'tenant', 'stocks', 'monitor kiba']::access_t[]
),
(
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    '01a150a7-b99b-7063-999f-188f1e6c2499',
    'staff',
    'Cashier',
    array['orders']::access_t[]
)
on conflict do nothing;

/* --------------------------------------------------------- */

insert into tenant_taxes
(
    id,
    id_tenant,
    id_tenant_branch,
    name_of_tax_display,
    percentage,
    applied_as_default
)
values
(
    '01a15307-7dc6-70d3-aea9-ec47401c0e7f', 
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'VAT',
    12.00,
    true
)
on conflict do nothing;
