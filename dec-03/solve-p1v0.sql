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

create or replace aggregate mul(bigint) ( sfunc = int8mul, stype = bigint );

with width as ( select max(x) + 1 as width from map ),
height as ( select max(y) + 1 as height from map ),
slopes as (
    select * from (
        values (1, 1), (3, 1), (5, 1), (7, 1), (1, 2)
    ) ds(rdist, ddist)
),
moves as
(
    select
        slopes.*,
        (t * rdist % width) as xt,
        (t * ddist) as yt
    from generate_series(1, 1000) t, width, slopes
),
encountered as (
    select count(*) as trees
    from moves
    inner join map on x = xt and y = yt
    inner join height on height >= yt
    where c = '#'
    group by rdist, ddist
)
select mul(trees) from encountered ;
