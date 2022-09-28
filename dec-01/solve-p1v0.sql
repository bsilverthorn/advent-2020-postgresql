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

select x.number * y.number * z.number
from numbers x, numbers y, numbers z
where x.number + y.number + z.number = 2020 ;
