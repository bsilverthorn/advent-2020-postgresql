--
-- INPUT
--

create temp table rules
(
    number int,
    symbols text
) ;
copy rules from :'rules_inpath' delimiter ',' csv header ;

create temp table messages
(
    body text
) ;
copy messages from :'messages_inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive patterns as (
    select symbols from rules where number = 0
    union
    select replace(p.symbols, ' ' || r.number || ' ', '(' || r.symbols || ')')
    from patterns p
    inner join rules r on r.number = (regexp_match(p.symbols, '\d+'))[1]::int
),
final as (
    select '^' || translate(symbols, ' ', '') || '$' as pattern
    from patterns
    where symbols !~ '\d+'
)
select count(*) from messages cross join final where body ~ pattern ;
