--
-- INPUT
--

create temp table actions
(
    t int,
    act varchar,
    arg int
) ;
copy actions from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

-- Action N means to move north by the given value.
-- Action S means to move south by the given value.
-- Action E means to move east by the given value.
-- Action W means to move west by the given value.
-- Action L means to turn left the given number of degrees.
-- Action R means to turn right the given number of degrees.
-- Action F means to move forward by the given value in the direction the ship
-- is currently facing.

with recursive positions as (
    select
        0 as t,
        0::float as heading,
        0::float as northing,
        0::float as easting
    union all
    select
        t + 1,
        heading + case
            when act = 'L' then arg
            when act = 'R' then -arg
            else 0
        end,
        northing + case
            when act = 'N' then arg
            when act = 'S' then -arg
            when act = 'F' then sind(heading) * arg
            else 0
        end,
        easting + case
            when act = 'E' then arg
            when act = 'W' then -arg
            when act = 'F' then cosd(heading) * arg
            else 0
        end
    from positions
    natural join actions
)
select abs(northing) + abs(easting) from positions order by t desc limit 1 ;
