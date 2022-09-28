--
-- INPUT
--

create temp table rules
(
    outcolor varchar,
    qty int,
    incolor varchar
) ;
copy rules from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive paths as (
    select qty as total, incolor as color from rules where outcolor = 'shiny gold'
    union all
    select qty * total as total, incolor as color from paths join rules on outcolor = color
)
select sum(total) from paths ;
