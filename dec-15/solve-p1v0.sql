--
-- INPUT
--

create temp table starting_turns
(
    turn int,
    number int
) ;
copy starting_turns from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function play_memory_game(turns bigint) returns bigint as $$
declare
    t bigint ;
    speak bigint ;
    spoke_when bigint[] ;
    spoke_last_when bigint ;
begin
    for t, speak in select * from starting_turns loop
        spoke_last_when := spoke_when[speak] ;

        spoke_when[speak] := t ;
    end loop ;

    for t in t + 1..turns loop
        speak := coalesce(t - spoke_last_when - 1, 0) ;

        spoke_last_when := spoke_when[speak] ;

        spoke_when[speak] := t ;
    end loop ;

    return speak ;
end ;
$$ language plpgsql ;

select play_memory_game(:game_turns) ;
