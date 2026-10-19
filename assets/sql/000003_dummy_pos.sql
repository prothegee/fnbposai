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
    '01a1537a-3f6e-71bf-8cbe-cffb28bf71be',
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

/* --------------------------------------------------------- */

insert into pos_stocks
(
    id,
    id_tenant,
    id_tenant_branch,
    name,
    thumbnail,
    quantity,
    quantity_warning,
    weight,
    weight_unit,
    weight_deduct
)
values
(
    -- #1 American Cheese Slice
    '01a15395-7ae3-72b7-a9f9-b9f897a3d155',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'American Cheese Slice',
    'american_cheese_slice.png',
    10,
    2,
    20,
    'g',
    10
),
(
    -- #2 Anchovy Fillets (Canned)
    '01a15395-7ae5-70af-b5bc-6f237c1bb00c',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Anchovy Fillets (Canned)',
    'anchovy_fillets_canned.png',
    10,
    2,
    5,
    'g',
    2.5
),
(
    -- #3 Beef Mince
    '01a15395-7ae7-774e-978d-d6f957846971',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Beef Mince',
    'beef_mince.png',
    10,
    2,
    300,
    'g',
    150
),
(
    -- #4 Blueberry Muffin
    '01a15395-7ae9-7fb8-b171-690fe30470a3',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Blueberry Muffin',
    'blueberry_muffin_NotSquare.png',
    10,
    2,
    200,
    'g',
    100
),
(
    -- #5 Burger Bun
    '01a15395-7aeb-7d5b-bce3-7b3d64cf5408',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Burger Bun',
    'burger_bun.png',
    10,
    2,
    60,
    'g',
    30
),
(
    -- #6 Cheesecake
    '01a15395-7aed-7107-92fb-095b9b0f1f14',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Cheesecake',
    'cheesecake_NotSquare.png',
    10,
    2,
    240,
    'g',
    120
),
(
    -- #7 Clean Fresh Water
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Clean Fresh Water',
    'clean_fresh_water_1_gallon.png',
    10,
    2,
    3785,
    'ml',
    250
),
(
    -- #8 Club Sandwich
    '01a15395-7af0-7012-b64f-fdecc2f187f1',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Club Sandwich',
    'club_sandwich_NotSquare.png',
    10,
    2,
    250,
    'g',
    125
),
(
    -- #9 Croissant
    '01a15395-7af2-7f77-b1e9-2856ca785cd5',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Croissant',
    'croissant_NotSquare.png',
    10,
    2,
    120,
    'g',
    60
),
(
    -- #10 Croutons (Ciabatta/Sourdough)
    '01a15395-7af3-77b9-87b4-764a083fcf45',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Croutons (Ciabatta/Sourdough)',
    'croutons_ciabatta_or_sourdough.png',
    10,
    2,
    100,
    'g',
    50
),
(
    -- #11 Dijon Mustard
    '01a15395-7af5-7137-96a2-344f41541141',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Dijon Mustard',
    'dijo_mustard.png',
    10,
    2,
    200,
    'ml',
    5
),
(
    -- #12 Fresh Lemon Juice
    '01a15395-7af7-7c3b-aa1a-be4666d2d9c6',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Fresh Lemon Juice',
    'fresh_lemon_juice.png',
    10,
    2,
    100,
    'ml',
    30
),
(
    -- #13 Fresh Milk
    '01a15395-7af9-740a-a0d3-57359028f616',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Fresh Milk',
    'fresh_milk_1L.png',
    10,
    2,
    1000,
    'ml',
    150
),
(
    -- #14 Garlic Clove
    '01a15395-7afa-7a27-977b-7a2e0c1eaabe',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Garlic Clove',
    'garlic_clove.png',
    10,
    2,
    3,
    'g',
    1.5
),
(
    -- #15 Grated Parmesan Cheese
    '01a15395-7afc-7939-9689-2f3d42719753',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Grated Parmesan Cheese',
    'grated_parmesan_cheese.png',
    10,
    2,
    100,
    'g',
    30
),
(
    -- #16 Ground Black Pepper
    '01a15395-7afe-77ac-bae2-7a3f59f40e92',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ground Black Pepper',
    'ground_black_pepper.png',
    10,
    2,
    100,
    'g',
    0.5
),
(
    -- #17 Ground Coffee Beans (Fine)
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ground Coffee Beans (Fine)',
    'ground_coffee_beans_fine.png',
    10,
    2,
    1000,
    'g',
    18
),
(
    -- #18 Ground Salt
    '01a15395-7b01-7a2e-ac25-99a0ff531c37',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ground Salt',
    'ground_salt.png',
    10,
    2,
    500,
    'g',
    1
),
(
    -- #19 Ice Cubes
    '01a15395-7b03-741f-be44-ece80f3ee2b7',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Ice Cubes',
    'ices.png',
    10,
    2,
    1000,
    'g',
    100
),
(
    -- #20 Loose Green Tea Leaves
    '01a15395-7b05-7ca2-b7fb-731ad077b0c7',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Loose Green Tea Leaves',
    'loose_green_tea_leaves.png',
    10,
    2,
    100,
    'g',
    3
),
(
    -- #21 Mayonnaise
    '01a15395-7b07-71dc-9031-b4bedf3ddc08',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Mayonnaise',
    'mayonnaise.png',
    10,
    2,
    500,
    'g',
    20
),
(
    -- #22 Olive Oil
    '01a15395-7b08-74d9-94f0-2e3fd54f923d',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Olive Oil',
    'olive_oil.png',
    10,
    2,
    500,
    'ml',
    50
),
(
    -- #23 Pickle Slices
    '01a15395-7b0a-7dca-acfd-31147819e8a6',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Pickle Slices',
    'pickle_slices.png',
    10,
    2,
    100,
    'g',
    15
),
(
    -- #24 Red Onion Slices
    '01a15395-7b0c-7b77-88b6-acddfb45ea5f',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Red Onion Slices',
    'red_onion_slices.png',
    10,
    2,
    100,
    'g',
    15
),
(
    -- #25 Red Tomato Slices
    '01a15395-7b0e-72ec-8589-11850e5cbe1c',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Red Tomato Slices',
    'red_tomato_slices.png',
    10,
    2,
    100,
    'g',
    20
),
(
    -- #26 Romaine Lettuce
    '01a15395-7b0f-752f-b2e6-2b475e732722',
    '01a14e6f-ab53-74d4-af99-f9e541108ba0',
    '01a14e70-c4b6-70bb-b65a-899d4a53fc9d',
    'Romaine Lettuce',
    'romaine_lettuce.png',
    10,
    2,
    500,
    'g',
    10
);

/* --------------------------------------------------------- */

insert into pos_items_builder
(
    id_item,
    id_stock,
    stock_weight,
    stock_weight_unit
)
values
(
    -- # Beef Burger / Beef Mince
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7ae7-774e-978d-d6f957846971',
    150,
    'g'
),
(
    -- # Beef Burger / Ground Salt
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b01-7a2e-ac25-99a0ff531c37',
    1,
    'g'
),
(
    -- # Beef Burger / Ground Black Pepper
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7afe-77ac-bae2-7a3f59f40e92',
    0.5,
    'g'
),
(
    -- # Beef Burger / Burger Bun
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7aeb-7d5b-bce3-7b3d64cf5408',
    60,
    'g'
),
(
    -- # Beef Burger / American Cheese Slice
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7ae3-72b7-a9f9-b9f897a3d155',
    20,
    'g'
),
(
    -- # Beef Burger / Romaine Lettuce
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b0f-752f-b2e6-2b475e732722',
    10,
    'g'
),
(
    -- # Beef Burger / Red Tomato Slices
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b0e-72ec-8589-11850e5cbe1c',
    20,
    'g'
),
(
    -- # Beef Burger / Red Onion Slices
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b0c-7b77-88b6-acddfb45ea5f',
    15,
    'g'
),
(
    -- # Beef Burger / Pickle Slices
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b0a-7dca-acfd-31147819e8a6',
    15,
    'g'
),
(
    -- # Beef Burger / Mayonnaise
    '01a15373-18ae-7c49-be39-047825841ff6',
    '01a15395-7b07-71dc-9031-b4bedf3ddc08',
    20,
    'g'
),
(
    -- # Blueberry Muffin
    '01a1536e-1f86-742d-9427-75c5b80200cd',
    '01a15395-7ae9-7fb8-b171-690fe30470a3',
    200,
    'g'
),
(
    -- # Caesar Salad / Romaine Lettuce
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7b0f-752f-b2e6-2b475e732722',
    300,
    'g'
),
(
    -- # Caesar Salad / Grated Parmesan Cheese
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7afc-7939-9689-2f3d42719753',
    30,
    'g'
),
(
    -- # Caesar Salad / Croutons (Ciabatta/Sourdough)
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7af3-77b9-87b4-764a083fcf45',
    50,
    'g'
),
(
    -- # Caesar Salad / Anchovy Fillets (Canned)
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7ae5-70af-b5bc-6f237c1bb00c',
    10,
    'g'
),
(
    -- # Caesar Salad / Garlic Clove
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7afa-7a27-977b-7a2e0c1eaabe',
    3,
    'g'
),
(
    -- # Caesar Salad / Mayonnaise
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7b07-71dc-9031-b4bedf3ddc08',
    50,
    'g'
),
(
    -- # Caesar Salad / Fresh Lemon Juice
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7af7-7c3b-aa1a-be4666d2d9c6',
    30,
    'ml'
),
(
    -- # Caesar Salad / Olive Oil
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7b08-74d9-94f0-2e3fd54f923d',
    50,
    'ml'
),
(
    -- # Caesar Salad / Dijon Mustard
    '01a1536c-d918-7fc5-a307-da595cc4f40d',
    '01a15395-7af5-7137-96a2-344f41541141',
    5,
    'ml'
),
(
    -- # Cheesecake
    '01a1537a-3f6e-71bf-8cbe-cffb28bf71be',
    '01a15395-7aed-7107-92fb-095b9b0f1f14',
    240,
    'g'
),
(
    -- # Club Sandwich
    '01a15367-835a-7e94-b35f-a0a23b834c65',
    '01a15395-7af0-7012-b64f-fdecc2f187f1',
    250,
    'g'
),
(
    -- # Croissant
    '01a15364-b616-70a8-b8d4-568ee8c2040e',
    '01a15395-7af2-7f77-b1e9-2856ca785cd5',
    120,
    'g'
),
(
    -- # Espresso / Ground Coffee Beans (Fine)
    '01a15362-4141-74fc-97db-0d1f8880f1b1',
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    18,
    'g'
),
(
    -- # Espresso / Clean Fresh Water
    '01a15362-4141-74fc-97db-0d1f8880f1b1',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    40,
    'ml'
),
(
    -- # Flat White / Ground Coffee Beans (Fine)
    '01a1535e-24fc-73e2-b3c1-51e4f27b0cc7',
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    18,
    'g'
),
(
    -- # Flat White / Fresh Milk
    '01a1535e-24fc-73e2-b3c1-51e4f27b0cc7',
    '01a15395-7af9-740a-a0d3-57359028f616',
    100,
    'ml'
),
(
    -- # Flat White / Clean Fresh Water
    '01a1535e-24fc-73e2-b3c1-51e4f27b0cc7',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    40,
    'ml'
),
(
    -- # Green Tea / Loose Green Tea Leaves
    '01a15334-38b7-7f42-92e2-b3ebd545ac84',
    '01a15395-7b05-7ca2-b7fb-731ad077b0c7',
    3,
    'g'
),
(
    -- # Green Tea / Clean Fresh Water
    '01a15334-38b7-7f42-92e2-b3ebd545ac84',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    250,
    'ml'
),
(
    -- # Ice Americano #1 / Ground Coffee Beans (Fine)
    '01a15331-f0fd-7b29-ab1e-242378eb71c1',
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    18,
    'g'
),
(
    -- # Ice Americano #1 / Clean Fresh Water
    '01a15331-f0fd-7b29-ab1e-242378eb71c1',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    190,
    'ml'
),
(
    -- # Ice Americano #1 / Ice Cubes
    '01a15331-f0fd-7b29-ab1e-242378eb71c1',
    '01a15395-7b03-741f-be44-ece80f3ee2b7',
    100,
    'g'
),
(
    -- # Ice Americano #2 / Ground Coffee Beans (Fine)
    '01a15328-d134-7a4f-95b7-08cb353fe453',
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    18,
    'g'
),
(
    -- # Ice Americano #2 / Clean Fresh Water
    '01a15328-d134-7a4f-95b7-08cb353fe453',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    190,
    'ml'
),
(
    -- # Ice Americano #2 / Ice Cubes
    '01a15328-d134-7a4f-95b7-08cb353fe453',
    '01a15395-7b03-741f-be44-ece80f3ee2b7',
    100,
    'g'
),
(
    -- # Latte / Ground Coffee Beans (Fine)
    '01a15325-77cb-7847-bc2a-40bfacc959b7',
    '01a15395-7b00-70e0-ba3d-fef4ffc3ea56',
    18,
    'g'
),
(
    -- # Latte / Fresh Milk
    '01a15325-77cb-7847-bc2a-40bfacc959b7',
    '01a15395-7af9-740a-a0d3-57359028f616',
    250,
    'ml'
),
(
    -- # Latte / Clean Fresh Water
    '01a15325-77cb-7847-bc2a-40bfacc959b7',
    '01a15395-7aee-730c-81df-89ebdcfb49ff',
    40,
    'ml'
);
