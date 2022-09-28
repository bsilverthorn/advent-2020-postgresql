--
-- INPUT
--

create temp table passports
(
    ecl varchar,
    pid varchar,
    eyr varchar,
    hcl varchar,
    byr varchar,
    iyr varchar,
    cid varchar,
    hgt varchar
) ;
copy passports from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

select count(*) from passports
where
    ecl is not null
    and pid is not null
    and eyr is not null
    and hcl is not null
    and byr is not null
    and iyr is not null
    and hgt is not null ;
