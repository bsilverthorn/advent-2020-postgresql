--
-- INPUT
--

create temp table initial_cubes
(
    x int,
    y int
) ;
copy initial_cubes from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace procedure advance_state_once() as $$
begin
    create temp table cubes_next as
    select
        cubes.x + xd as x,
        cubes.y + yd as y,
        cubes.z + zd as z
    from cubes
    cross join (values (-1), (0), (1)) as xds(xd)
    cross join (values (-1), (0), (1)) as yds(yd)
    cross join (values (-1), (0), (1)) as zds(zd)
    group by 1, 2, 3
    having
        count(case when xd <> 0 or yd <> 0 or zd <> 0 then true end) = 3
        or (
            count(case when xd <> 0 or yd <> 0 or zd <> 0 then true end) = 2
            and bool_or(xd = 0 and yd = 0 and zd = 0)
        ) ;

    drop table cubes ;
    alter table cubes_next rename to cubes ;
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

create temp table cubes as select *, 0 as z from initial_cubes ;

call advance_state(6) ;

select count(*) from cubes ;
