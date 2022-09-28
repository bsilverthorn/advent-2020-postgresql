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

select
    seq,
    number,
    exists (
        select true
        from xmas x, xmas y
        where
            x.seq <> y.seq
            and x.seq between m.seq - :prelen and m.seq - 1
            and y.seq between m.seq - :prelen and m.seq - 1
            and x.number + y.number = m.number
    ) as valid
from xmas m
where seq >= :prelen
order by 3 desc, 2 ;
