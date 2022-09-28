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

create or replace aggregate mul(bigint) ( sfunc = int8mul, stype = bigint );

create temp table solved ( name varchar, position int ) ;

create temp table positions as with field_ticket_matches as (
    select
        fi.name,
        ti.ticket,
        ti.position,
        bool_or(ti.value between fi.lower and fi.upper) compatible
    from fields_input fi
    inner join tickets_input ti on
        exists (select true from fields_input where value between lower and upper)
    group by 1, 2, 3
),
valid_positions as (
    select
        name,
        position
    from field_ticket_matches
    group by 1, 2
    having bool_and(compatible)
)
select * from valid_positions ;

create or replace procedure solve_constraints() as $$
begin
    while exists (select true from positions) loop
        insert into solved
        select
            name,
            (array_agg(position))[1]
        from positions
        group by name
        having count(*) = 1 ;

        delete from positions where position in ( select position from solved ) ;
    end loop ;
end ;
$$ language plpgsql ;

call solve_constraints() ;

select * from solved order by 2 ;

select mul(ti.value::bigint)
from solved sc
inner join tickets_input ti on ti.position = sc.position
where
    ti.whose = 'your'
    and sc.name like 'departure%' ;
