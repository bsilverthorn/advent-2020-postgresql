--
-- INPUT
--

create temp table actions_input
(
    t int,
    act varchar,
    arg int
) ;
copy actions_input from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

-- * Action N means to move the waypoint north by the given value.
-- * Action S means to move the waypoint south by the given value.
-- * Action E means to move the waypoint east by the given value.
-- * Action W means to move the waypoint west by the given value.
-- * Action L means to rotate the waypoint around the ship left
--   (counter-clockwise) the given number of degrees.
-- * Action R means to rotate the waypoint around the ship right (clockwise)
--   the given number of degrees.
-- * Action F means to move forward to the waypoint a number of times equal to
--   the given value.

with recursive actions as (
    select
        t,
        act,
        case when act in ('S', 'W', 'R') then -arg else arg end as sarg
    from actions_input
),
positions as (
    select
        0 as t,
        1::float as waynorth,
        10::float as wayeast,
        0::float as shipnorth,
        0::float as shipeast
    union all
    select
        t + 1,
        case
            when act in ('N', 'S') then waynorth + sarg
            when act in ('L', 'R') then sind(atan2d(waynorth, wayeast) + sarg) * sqrt(waynorth^2 + wayeast^2)
            else waynorth
        end,
        case
            when act in ('E', 'W') then wayeast + sarg
            when act in ('L', 'R') then cosd(atan2d(waynorth, wayeast) + sarg) * sqrt(waynorth^2 + wayeast^2)
            else wayeast
        end,
        shipnorth + case when act = 'F' then waynorth * sarg else 0 end,
        shipeast + case when act = 'F' then wayeast * sarg else 0 end
    from positions
    natural join actions
)
select round(abs(shipnorth) + abs(shipeast)) from positions order by t desc limit 1 ;
