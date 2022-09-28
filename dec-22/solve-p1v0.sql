--
-- INPUT
--

create temp table decks
(
    player text,
    deck int[]
) ;
copy decks from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function recursive_combat(
    deck_a int[],
    deck_b int[],
    out winner text,
    out winning_deck int[]) as $$
declare
    top_a int ;
    top_b int ;
    recursed record ;
    earlier_decks text[] := '{}' ;
begin
    loop
        -- terminate early on a duplicate round
        if earlier_decks @> array[deck_a::text || deck_b::text] then
            winner := 'A' ;
            winning_deck := deck_a ;

            return ;
        end if ;

        earlier_decks := earlier_decks || (deck_a::text || deck_b::text) ;

        -- otherwise play as usual
        top_a := deck_a[1] ;
        top_b := deck_b[1] ;
        deck_a := deck_a[2:] ;
        deck_b := deck_b[2:] ;

        if array_length(deck_a, 1) >= top_a and array_length(deck_b, 1) >= top_b then
            recursed := recursive_combat(deck_a[:top_a], deck_b[:top_b]) ;
            winner := recursed.winner ;
        elsif top_a > top_b then
            winner = 'A' ;
        else
            winner = 'B' ;
        end if ;

        if winner = 'A' then
            deck_a = deck_a || top_a || top_b ;
            winning_deck := deck_a ;
        else
            deck_b = deck_b || top_b || top_a ;
            winning_deck := deck_b ;
        end if ;

        -- overall winner?
        if deck_a[1] is null or deck_b[1] is null then
            return ;
        end if;
    end loop ;
end ;
$$ language plpgsql ;

with outcome as (
    select
        win.*,
        (select sum(array_length(deck, 1)) from decks) as deck_size
    from recursive_combat(
        (select deck from decks where player = 'Player 1'),
        (select deck from decks where player = 'Player 2')
    ) win
),
winning_cards as (
    select unnest(winning_deck) as card, deck_size from outcome
),
numbered_cards as (
    select *, row_number() over () as position from winning_cards
)
select sum(card * (deck_size - position + 1)) from numbered_cards ;
