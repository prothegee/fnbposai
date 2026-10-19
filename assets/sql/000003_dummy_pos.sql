/*
IMPORTANT:
- This is for demo/debug only
*/

/* --------------------------------------------------------- */

/*
REFERENCES:
- id_tenant: 01a14e6f-ab53-74d4-af99-f9e541108ba0
- id_tenant_branch: 01a14e70-c4b6-70bb-b65a-899d4a53fc9d
*/

/* --------------------------------------------------------- */

insert into pos_items
(
    id,
    id_tenant,
    id_tenant_branch,
    name,
    use_sync_stock,
    thumbnail,
    category,
    tags
)
values
(
    -- #1
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Beef Burger',
    true,
    'beef_burger_NotSquare.png',
    'Burger',
    array['burger']::text
),
(
    -- #2
    '01a1536e-1f86-742d-9427-75c5b80200cd',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Blueberry Muffin',
    true,
    'blueeberry_muffin_NotSquare.png',
    'Pastry',
    array['pastry']::text
),
(
    -- #3
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Caesar Salad',
    true,
    'caesar_salad_NotSquare.png',
    'Salad',
    array['salad']::text
),
(
    -- #4
    '01a15367-835a-7e94-b35f-a0a23b834c65',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Cheesecake',
    true,
    'cheesecake_NotSquare.png',
    'Cake',
    array['cake']::text
),
(
    -- #5
    '01a15367-835a-7e94-b35f-a0a23b834c65',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Club Sandwich',
    true,
    'club_sandwich_NotSquare.png',
    'Pastry',
    array['pastry']::text
),
(
    -- #6
    '01a15364-b616-70a8-b8d4-568ee8c2040e',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Croissant',
    true,
    'croissant_NotSquare.png',
    'Pastry',
    array['pastry']::text
),
(
    -- #7
    '01a15362-4141-74fc-97db-0d1f8880f1b1',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Espresso',
    true,
    'espresso.png',
    'Drink',
    array['coffee']::text
),
(
    -- #8
    '01a1535e-24fc-73e2-b3c1-51e4f27b0cc7',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Flat White',
    true,
    'flat_white.png',
    'Drink',
    array['coffee']::text
),
(
    -- #9
    '01a15334-38b7-7f42-92e2-b3ebd545ac84',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Green Tea',
    true,
    'green_tea.png',
    'Drink',
    array['tea']::text
),
(
    -- #10
    '01a15331-f0fd-7b29-ab1e-242378eb71c1',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ice Americano',
    true,
    'ice_americano.png',
    'Drink',
    array['coffee', 'ice']::text
),
(
    -- #11
    '01a15328-d134-7a4f-95b7-08cb353fe453',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ice Americano',
    true,
    'ice_americano.png',
    'Drink',
    array['coffee', 'ice']::text
),
(
    -- #12
    '01a15325-77cb-7847-bc2a-40bfacc959b7',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Latte',
    true,
    'latte.png',
    'Drink',
    array['coffee']::text
);
