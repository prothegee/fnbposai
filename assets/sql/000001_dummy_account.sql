/*
IMPORTANT:
- This is for demo/debug only
- password:
    - raw: password123!
    - hash: $argon2id$v=19$m=524288,t=2,p=4$ZTOntipimObyepo9xSwuGw$t0Ul1bcwbNQaA2ao/HFsoP5oVAnhTkBTBZeTgJQhoQo
*/
insert into account
(
    id,
    email,
    username,
    password
)
values
(
    '01a14e6f-1b71-79e1-b42c-cfe9c0cbde32',
    'keena@sunrisecafe.com',
    'keena',
    '$argon2id$v=19$m=524288,t=2,p=4$ZTOntipimObyepo9xSwuGw$t0Ul1bcwbNQaA2ao/HFsoP5oVAnhTkBTBZeTgJQhoQo'
),
(
    '01a150a7-b99b-7063-999f-188f1e6c2499',
    'j.doe@gmail.com',
    'jdoe',
    '$argon2id$v=19$m=524288,t=2,p=4$ZTOntipimObyepo9xSwuGw$t0Ul1bcwbNQaA2ao/HFsoP5oVAnhTkBTBZeTgJQhoQo'
)
on conflict do nothing;
