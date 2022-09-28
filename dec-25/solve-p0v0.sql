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

with recursive constants as (
    select
        7 as known_subject_number,
        1 as known_starting_candidate,
        20201227 as known_value_modulus
),
candidate_keys as (
    select
        pk.*,
        0 as loop_size,
        known_starting_candidate as candidate_key
    from public_keys pk
    cross join constants
    union
    select
        device,
        public_key,
        loop_size + 1,
        (candidate_key * known_subject_number) % known_value_modulus
    from candidate_keys
    cross join constants
    where candidate_key <> public_key
),
device_secrets as (
    select
        device,
        public_key,
        loop_size
    from candidate_keys ck
    where loop_size = (
        select max(loop_size) from candidate_keys cki where cki.device = ck.device
    )
),
encryption_keys as (
    select
        device,
        public_key,
        (select sum(loop_size) - 1 from device_secrets) as loop_iterations,
        loop_size as loop_iteration,
        public_key as encryption_key
    from device_secrets
    union
    select
        device,
        public_key,
        loop_iterations,
        loop_iteration + 1,
        (encryption_key * public_key) % known_value_modulus
    from encryption_keys
    cross join constants
    where
        loop_iteration < loop_iterations
        and device = 1
)
select * from encryption_keys ;
