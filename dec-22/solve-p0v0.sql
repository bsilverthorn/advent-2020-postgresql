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

with recursive rounds as (
    select
        0 as round,
        (select deck from decks where player = 'Player 1') as deck_a,
        (select deck from decks where player = 'Player 2') as deck_b
    union
    select
        round + 1,
        deck_a[2:] || case
            when deck_a[1] > deck_b[1] then array[deck_a[1], deck_b[1]]
            else '{}'
        end,
        deck_b[2:] || case
            when deck_b[1] > deck_a[1] then array[deck_b[1], deck_a[1]]
            else '{}'
        end
    from rounds
    where deck_a[1] is not null and deck_b[1] is not null
),
winning_deck as (
    select
        deck_a || deck_b as deck,
        array_length(deck_a || deck_b, 1) as deck_size
    from rounds
    order by round
    desc limit 1
),
winning_cards as (
    select unnest(deck) as card, deck_size from winning_deck
),
numbered_cards as (
    select *, row_number() over () as position from winning_cards
)
select sum(card * (deck_size - position + 1)) from numbered_cards ;
