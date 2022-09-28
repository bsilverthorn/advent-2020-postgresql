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
    select outcolor as color from rules where incolor = 'shiny gold'
    union
    select outcolor as color from paths join rules on incolor = color
)
select count(*) from paths ;
