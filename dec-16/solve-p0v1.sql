--
-- INPUT
--

create temp table fields_input
(
    name varchar,
    lower int,
    upper int
) ;
copy fields_input from :'fields_inpath' delimiter ',' csv header ;

create temp table tickets_input
(
    whose varchar,
    ticket int,
    position int,
    value int
) ;
copy tickets_input from :'tickets_inpath' delimiter ',' csv header ;

--
-- SOLVE
--

select sum(value)
from tickets_input
where not exists (
    select from fields_input where value between lower and upper
) ;
