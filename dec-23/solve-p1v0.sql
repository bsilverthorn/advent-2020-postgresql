--
-- INPUT
--

create temp table starting_cups
(
    cups int[]
) ;
copy starting_cups from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function simulate_crab_game(
    starting_cups int[],
    total_cups int,
    moves int) returns bigint as $$
declare
    move int := 0 ;
    nextcup int[] ;
    removed int[] ;
    current int ;
    dc int ;
    i int ;
begin
    -- prepare the linked list
    for i in cardinality(starting_cups) + 1..total_cups loop
        starting_cups[i] = i ;
    end loop ;

    current := starting_cups[1] ;

    for i in 1..total_cups - 1 loop
        nextcup[starting_cups[i]] := starting_cups[i + 1] ;
    end loop ;

    nextcup[starting_cups[total_cups]] := current ;

    -- make the moves
    for i in 1..moves loop
        removed[1] = nextcup[current] ;
        removed[2] = nextcup[removed[1]] ;
        removed[3] = nextcup[removed[2]] ;

        dc := current - 1 ;

        loop
            if dc = 0 then
                dc := total_cups ;
            end if ;

            if dc = removed[1] or dc = removed[2] or dc = removed[3] then
                dc := dc - 1 ;
            else
                exit ;
            end if ;
        end loop ;

        nextcup[current] := nextcup[removed[3]] ;
        current := nextcup[current] ;

        nextcup[removed[3]] = nextcup[dc] ;
        nextcup[dc] := removed[1] ;
    end loop ;

    return nextcup[1]::bigint * nextcup[nextcup[1]]::bigint ;
end ;
$$ language plpgsql ;

select simulate_crab_game(cups, :total_cups, :moves) from starting_cups ;
