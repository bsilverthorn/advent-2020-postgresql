--
-- INPUT
--

create temp table groups
(
    groupnum int,
    person int,
    answered char
) ;
copy groups from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with sizes as (
    select
        groupnum,
        count(distinct person) as size
    from groups
    group by groupnum
),
answers as (
    select
        groupnum,
        answered as question,
        count(*) as respondents
    from groups
    group by groupnum, question
)
select count(*) from answers natural join sizes where respondents = size ;
