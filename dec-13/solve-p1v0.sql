--
-- INPUT
--

create temp table notes
(
    i bigint,
    arrival int,
    bus bigint
) ;
copy notes from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function lowest_staggered_departure() returns bigint as $$
declare
    rec record ;
    t bigint default -1 ;
    step bigint default 1 ;
    done bool default false ;
begin
    create temp table buses as select * from notes where bus is not null ;

    while not done loop
        done := true ;
        t := t + step ;

        for rec in select * from buses
        loop
            if (t + rec.i) % rec.bus = 0 then
                step := step * rec.bus ;

                delete from buses where i = rec.i ;
            else
                done := false ;
            end if ;
        end loop ;
    end loop ;

    return t ;
end ;
$$ language plpgsql ;

select lowest_staggered_departure() ;
