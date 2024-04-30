drop database if exists grafast_repro;
create database grafast_repro;
\c grafast_repro;

create extension pgcrypto;

create table users (
    id int primary key,
    name text not null,
    created_at timestamptz not null default now()
);

create table languages (
    language text not null primary key
);

create table user_config (
    user_id int not null references users(id) on delete cascade,
    language text not null references languages(language) on delete restrict,
    created_at timestamptz not null default now()
);


create index idx_user_config_user_id on user_config(user_id);
create index idx_user_config_language on user_config(language);