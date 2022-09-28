--
-- INPUT
--

create temp table map
(
    x int,
    y int,
    c char
) ;
copy map from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with width as ( select max(x) + 1 as width from map ),
height as ( select max(y) + 1 as height from map ),
moves as
(
    select
        (t * 3 % width) as xt,
        (t * 1) as yt
    from generate_series(1, 1000) t
    cross join width
)
select count(*) from moves
join map on x = xt and y = yt
join height on height >= yt
where c = '#' ;
