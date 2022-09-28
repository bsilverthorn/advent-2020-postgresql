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
    with adjacent as (
        select
            amap.x as ax,
            amap.y as ay,
            count(case when bmap.spot = '#' then true end) as neighbors
        from seats amap
        join seats bmap on (bmap.x - amap.x)^2 + (bmap.y - amap.y)^2 between 1 and 2
        group by 1, 2
    )
    update seats
    set spot = case
        when spot = 'L' and neighbors = 0 then '#'
        when spot = '#' and neighbors >= 4 then 'L'
        else spot
    end
    from adjacent
    where ax = x and ay = y ;
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
