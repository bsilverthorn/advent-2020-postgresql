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

select count(distinct (groupnum, answered)) from groups ;
