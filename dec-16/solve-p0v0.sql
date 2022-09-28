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

with matched as (
    select
        ti.ticket,
        ti.position,
        ti.value,
        count(fi.name) as matches
    from tickets_input ti
    left join fields_input fi on ti.value between fi.lower and fi.upper
    group by 1, 2, 3
)
select sum(value) from matched where matches = 0 ;
