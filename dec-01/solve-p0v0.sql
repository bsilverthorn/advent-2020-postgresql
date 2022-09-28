--
-- INPUT
--

create temp table numbers
(
    number int
) ;
copy numbers from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

select x.number * y.number
from numbers x, numbers y
where x.number + y.number = 2020 ;
