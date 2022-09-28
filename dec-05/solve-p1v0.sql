--
-- INPUT
--

create temp table passes
(
    seat_name varchar
) ;
copy passes from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with seat_rows as (
    select
        n as rownum,
        string_agg(
            case when (n >> p) % 2 = 0 then 'F' else 'B' end, '' order by p desc
        ) as row_name
    from generate_series(0, 127) n
    cross join generate_series(0, 6) p
    group by n
),
seat_cols as (
    select
        n as colnum,
        string_agg(
            case when (n >> p) % 2 = 0 then 'L' else 'R' end, '' order by p desc
        ) as col_name
    from generate_series(0, 7) n
    cross join generate_series(0, 2) p
    group by n
),
seats as (
    select
        rownum * 8 + colnum as id,
        seat_name is not null as occupied
    from seat_rows
    cross join seat_cols
    left join passes on seat_name = row_name || col_name
)
select *
from seats
join seats before on before.id = seats.id - 1
join seats after on after.id = seats.id + 1
where
    before.occupied
    and after.occupied
    and not seats.occupied ;
