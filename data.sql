insert into users(id, name)
select
    gs.i, gs.i
    from generate_series(1, 1000) gs(i); 

insert into languages(language)
select
    md5(gs.i::text)
    from generate_series(1, 1000) gs(i); 

insert into user_config(user_id, language)
select
    gs.i, md5(gs.i::text)
    from generate_series(1, 1000) gs(i); 

vacuum analyze;