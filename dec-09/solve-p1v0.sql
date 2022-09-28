-- \set target 18272118

--
-- INPUT
--

create temp table xmas
(
    seq int,
    number numeric
) ;
copy xmas from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive candidates as (
    select
        seq as first,
        number as total,
        1 as length
    from xmas
    union all
    select
        first,
        total + number,
        length + 1
    from candidates
    inner join xmas on seq = first + length
    where total < :target
)
select min(number) + max(number)
from candidates
inner join xmas on seq between first and first + length - 1
where
    total = :target
    and length >= 2 ;
