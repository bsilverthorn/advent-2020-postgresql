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
select * into tiles from black_tiles ;

create or replace procedure advance_state_once() as $$
begin
    create temp table tiles_next as
    select
        tiles.x + xd as x,
        tiles.y + yd as y
    from tiles
    cross join (
        values
        ( 0,  0),
        ( 1,  0), -- e
        ( 1,  1), -- ne
        ( 0, -1), -- se
        (-1,  0), -- w
        (-1, -1), -- sw
        ( 0,  1)  -- nw
    ) as neighborhood(xd, yd)
    group by 1, 2
    having
        count(case when xd <> 0 or yd <> 0 then true end) = 2
        or (
            count(case when xd <> 0 or yd <> 0 then true end) = 1
            and bool_or(xd = 0 and yd = 0)
        ) ;

    drop table tiles ;
    alter table tiles_next rename to tiles ;
end ;
$$ language plpgsql ;

create or replace procedure advance_state(steps int) as $$
declare
    t int ;
begin
    for t in 1..steps loop
        call advance_state_once() ;
    end loop ;
end ;
$$ language plpgsql ;

call advance_state(100) ;

select count(*) from tiles ; 
