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

-- byr (Birth Year) - four digits; at least 1920 and at most 2002.
-- iyr (Issue Year) - four digits; at least 2010 and at most 2020.
-- eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
-- hgt (Height) - a number followed by either cm or in:
-- If cm, the number must be at least 150 and at most 193.
-- If in, the number must be at least 59 and at most 76.
-- hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
-- ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
-- pid (Passport ID) - a nine-digit number, including leading zeroes.
-- cid (Country ID) - ignored, missing or not.

select count(*) from passports
where
    byr::int between 1920 and 2002
    and iyr::int between 2010 and 2020
    and eyr::int between 2020 and 2030
    and case
        when hgt ~ '^\d+cm$' then left(hgt, -2)::int between 150 and 193
        when hgt ~ '^\d+in$' then left(hgt, -2)::int between 59 and 76
    end
    and hcl ~ '^#[0-9a-f]{6}$'
    and ecl in ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth')
    and pid ~ '^\d{9}$' ;
