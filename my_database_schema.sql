create extension if not exists citext;
create table my_table (
  id int generated always as identity,
  username citext not null unique
);
