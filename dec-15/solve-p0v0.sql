--
-- INPUT
--

create temp table starting_turns
(
    turn int,
    number int
)
;
copy starting_turns from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive turns as (
    select
        turn,
        (
            select jsonb_object_agg(number, turn)
            from starting_turns its
            where its.turn < it.turn
        ) as timestamps,
        number as spoken
    from starting_turns it
    where turn = (select max(turn) from starting_turns)
    union
    select
        turn + 1,
        jsonb_set(timestamps, array[spoken::text], turn::text::jsonb),
        coalesce(turn - (timestamps #> array[spoken::text])::int, 0)
    from turns
    where turn < 2020
)
select spoken from turns order by turn desc limit 1 ;
