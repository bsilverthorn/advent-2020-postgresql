--
-- INPUT
--

create temp table cmds_input
(
    cmd text,
    value text,
    addr bigint
)
;
copy cmds_input from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive cmds as ( select row_number() over () as i, * from cmds_input ),
mask_permutations as (
    select i, '' as mask, value as remaining from cmds where cmd = 'MASK'
    union
    select
        i,
        case
            when left(remaining, 1) = 'X' then mask || b
            when left(remaining, 1) = '0' then mask || '.'
            else mask || left(remaining, 1)
        end,
        substr(remaining, 2)
    from mask_permutations
    cross join (values ('0'), ('1')) possible(b)
),
cmds_with_masks as (
    select
        *,
        (
            select cp.i from cmds cp
            where cp.i < cmds.i and cp.cmd = 'MASK'
            order by cp.i desc
            limit 1
        ) as mask_i
    from cmds
),
memory as (
    select distinct on(addr)
        value::bigint,
        (
            addr::bigint::bit(36)
            | translate(mp.mask, '.', '0')::bit(36)
            & translate(mp.mask, '.', '1')::bit(36)
        )::bigint as addr
    from cmds_with_masks cwm
    join mask_permutations mp on mp.i = cwm.mask_i and remaining = ''
    where cmd = 'MEM'
    order by addr, cwm.i desc
)
select sum(value) from memory ;

-- select
--     
