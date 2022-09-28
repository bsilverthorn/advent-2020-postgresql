--
-- INPUT
--

create temp table cmds_input
(
    cmd text,
    value text,
    addr bigint
) ;
copy cmds_input from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive cmds as ( select row_number() over () as i, * from cmds_input ),
states as (
    select
        1 as cycle,
        'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' as mask,
        '{}'::jsonb as memory
    union
    select
        cycle + 1,
        case when cmd = 'MASK' then value else mask end,
        case
            when cmd = 'MEM' then jsonb_set(
                memory,
                array[addr::text],
                (
                    value::int::bit(36)
                    | translate(mask, 'X', '0')::bit(36)
                    & translate(mask, 'X', '1')::bit(36)
                )::bigint::text::jsonb
            )
            else memory
        end
    from states
    join cmds on i = cycle
)
select sum(value::bigint)
from jsonb_each_text((select memory from states order by cycle desc limit 1)) ;
