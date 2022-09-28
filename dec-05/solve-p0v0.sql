--
-- INPUT
--

create temp table passes
(
    seat varchar
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
        ) as row_part
    from generate_series(0, 127) n
    cross join generate_series(0, 6) p
    group by n
),
seat_cols as (
    select
        n as colnum,
        string_agg(
            case when (n >> p) % 2 = 0 then 'L' else 'R' end, '' order by p desc
        ) as col_part
    from generate_series(0, 7) n
    cross join generate_series(0, 2) p
    group by n
),
seats as (
    select
        rownum * 8 + colnum as id,
        rownum,
        colnum,
        row_part || col_part as seat
    from seat_rows, seat_cols
)
select max(id) from seats join passes on passes.seat = seats.seat ;
