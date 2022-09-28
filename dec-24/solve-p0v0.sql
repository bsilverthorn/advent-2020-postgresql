--
-- INPUT
--

create temp table flips
(
    directions text[]
) ;
copy flips from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with numbered_flips as (
    select row_number() over () as flip, * from flips
),
vectors as (
    select
        flip,
        case
            when direction in ('e', 'ne') then 1
            when direction in ('w', 'sw') then -1
            else 0
        end as dx,
        case
            when direction in ('ne', 'nw') then 1
            when direction in ('se', 'sw') then -1
            else 0
        end as dy
    from numbered_flips
    cross join unnest(directions) d(direction)
),
coordinates as (
    select sum(dx) as x, sum(dy) as y from vectors group by flip
),
black_tiles as (
    select * from coordinates group by x, y having count(*) % 2 = 1
)
select count(*) from black_tiles ;
