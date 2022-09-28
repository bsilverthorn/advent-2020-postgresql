--
-- INPUT
--

create temp table starting_cups
(
    cups int[]
) ;
copy starting_cups from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function destpos(cups int[]) returns int as $$
declare
    dc int := cups[1] - 1 ;
begin
    loop
        if dc = 0 then
            dc := cardinality(cups) ;
        end if ;

        if not cups[2:4] @> array[dc] then
            return array_position(cups, dc) ;
        else
            dc := dc - 1 ;
        end if ;
    end loop ;
end ;
$$ language plpgsql ;

with recursive moves as (
    select 0 as move, cups from starting_cups
    union
    select
        move + 1,
        cups[5:dc] || cups[2:4] || cups[dc + 1:] || cups[1]
    from moves
    cross join lateral (select destpos(cups) as dc) dc
    where move < :moves
)
select cups[oc + 1:] || cups[:oc - 1] as solution
from moves
cross join lateral (select array_position(cups, 1) as oc) oc
where move = :moves ;
