--
-- INPUT
--

create temp table passwords
(
    lmin int,
    lmax int,
    letter text,
    passtext text
) ;
copy passwords from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with letter_counts as (
    select
        *,
        (
            select count(*)
            from unnest(string_to_array(passtext, null)) letters(passc)
            where passc = letter
        ) as letter_count
    from passwords
)
select count(*) from letter_counts where letter_count between lmin and lmax ;
