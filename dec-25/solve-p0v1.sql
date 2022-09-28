--
-- INPUT
--

create temp table public_keys
(
    device int,
    public_key bigint
) ;
copy public_keys from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function compute_transformation(
    subject_number bigint,
    until_loops int,
    until_key bigint,
    out loops int,
    out keyval bigint) as $$
declare
    known_modulus bigint := 20201227 ;
    current_key bigint ;
begin
    keyval := 1 ;
    loops := 0 ;

    while loops is distinct from until_loops and keyval is distinct from until_key loop
        keyval := (keyval * subject_number) % known_modulus ;
        loops := loops + 1 ;
    end loop ;
end ;
$$ language plpgsql ;

with device_secrets as (
    select *
    from public_keys
    cross join compute_transformation(7, null, public_key) computed 
),
encryption_keys as (
    select *
    from device_secrets
    cross join compute_transformation(
        public_key,
        (select sum(loops)::int from device_secrets) - loops,
        null
    ) computed
)
select * from encryption_keys ;
