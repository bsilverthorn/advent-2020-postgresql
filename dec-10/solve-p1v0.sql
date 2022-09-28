--
-- INPUT
--

create temp table bag
(
    joltage int
) ;
copy bag from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function arrangements() returns table(j bigint, n bigint) as $$
declare
    adapter record ;
begin
    create temp table working as select 0::bigint as output, 1::bigint as number ;

    for adapter in select * from bag order by joltage loop
        insert into working
        select adapter.joltage, sum(number)
        from working
        where output >= adapter.joltage - 3 ;
    end loop ;

    return query select * from working ;
end ;
$$ language plpgsql ;

select * from arrangements() order by 1 desc limit 1 ;
