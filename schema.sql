drop database if exists grafast_repro ;
create database grafast_repro;
\c grafast_repro;

create extension pgcrypto;

create schema app_public;

create table app_public.users (
    id int primary key,
    name text not null,
    created_at timestamptz not null default now()
);

create table app_public.languages (
    language text not null primary key
);

create table app_public.user_config (
    user_id int not null references app_public.users(id) on delete cascade,
    language text not null references app_public.languages(language) on delete restrict,
    created_at timestamptz not null default now()
);


create index idx_user_config_user_id on app_public.user_config(user_id);
create index idx_user_config_language on app_public.user_config(language);