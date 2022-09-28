--
-- INPUT
--

create temp table seats
(
    x int,
    y int,
    spot varchar,
    n int
) ;
copy seats from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

-- * If a seat is empty (L) and there are no occupied seats adjacent to it, the
--   seat becomes occupied.
-- * If a seat is occupied (#) and four or more seats adjacent to it are also
--   occupied, the seat becomes empty.
-- * Otherwise, the seat's state does not change.

create or replace function adv_state() returns void as $$
begin
    with
    adjacent as (
        select distinct on (1, 2, 3, 4)
            amap.x as ax,
            amap.y as ay,
            sign(bmap.x - amap.x) as dx,
            sign(bmap.y - amap.y) as dy,
            abs(amap.x - bmap.x) + abs(amap.y - bmap.y) as distance,
            bmap.spot as aspot
        from seats amap
        join seats bmap on
            bmap.spot <> '.'
            and (bmap.x <> amap.x or bmap.y <> amap.y)
            and (
                bmap.x = amap.x
                or bmap.y = amap.y
                or abs(bmap.x - amap.x) = abs(bmap.y - amap.y)
            )
        order by 1, 2, 3, 4, 5
    ),
    neighbors as (
        select
            x as nx,
            y as ny,
            count(case when aspot = '#' then true end) as neighbors
        from seats map
        inner join adjacent on ax = x and ay = y
        group by 1, 2
    )
    update seats
    set spot = case
        when spot = 'L' and neighbors = 0 then '#'
        when spot = '#' and neighbors >= 5 then 'L'
        else spot
    end
    from neighbors
    where nx = x and ny = y ;
end ;
$$ language plpgsql ;

create or replace function adv_state_to_fp() returns void as $$
declare
    state_hash varchar ;
    last_state_hash varchar ;
begin
    loop
        exit when state_hash = last_state_hash ;

        last_state_hash := state_hash;

        perform adv_state() ;

        select into state_hash string_agg(spot, '' order by x, y) from seats ;
    end loop ;
end ;
$$ language plpgsql ;

select adv_state_to_fp() ;
select string_agg(spot, '' order by x) from seats group by y order by y ;
select count(*) from seats where spot = '#' ;
