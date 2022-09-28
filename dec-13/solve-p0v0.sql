--
-- INPUT
--

create temp table notes
(
    i int,
    arrival int,
    bus int
) ;
copy notes from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with buses as ( select bus, bus - arrival % bus as wait from notes )
select bus * wait from buses order by wait limit 1 ;
