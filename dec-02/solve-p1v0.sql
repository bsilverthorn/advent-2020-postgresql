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
        case when substring(passtext, lmin, 1) = letter then 1 else 0 end +
        case when substring(passtext, lmax, 1) = letter then 1 else 0 end
        as letter_count
    from passwords
)
select count(*) from letter_counts where letter_count = 1 ;
