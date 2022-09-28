--
-- INPUT
--

create temp table tiles
(
    id bigint,
    top text,
    bottom text,
    leftb text,
    rightb text,
    block text[][]
) ;
copy tiles from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive rotated as (
    select id, top, bottom, leftb, rightb from tiles
    union -- 90 degrees
    select id, reverse(leftb) as top, reverse(rightb) as bottom, bottom as leftb, top as rightb
    from tiles
    union -- 180 degrees
    select id, reverse(bottom) as top, reverse(top) as bottom, reverse(rightb) as leftb, reverse(leftb) as rightb
    from tiles
    union -- 270 degrees
    select id, rightb as top, leftb as bottom, reverse(top) as leftb, reverse(bottom) as rightb
    from tiles
),
flipped as (
    select * from rotated
    union -- vertical
    select id, bottom as top, top as bottom, reverse(leftb) as leftb, reverse(rightb) as rightb
    from rotated
    union -- horizontal
    select id, reverse(top) as top, reverse(bottom) as bottom, rightb as leftb, leftb as rightb
    from rotated
),
dimensions as ( select round(sqrt(count(*))) as edge_size from tiles ),
placements as (
    select
        1 as nextrow,
        2 as nextcol,
        array[id] as placed,
        jsonb_build_object('1,1', bottom) as bottoms,
        jsonb_build_object('1,1', rightb) as rights
    from flipped
    union
    select
        case when nextcol = edge_size then nextrow + 1 else nextrow end,
        case when nextcol = edge_size then 1 else nextcol + 1 end,
        placed || id,
        jsonb_set(bottoms, array[nextrow || ',' || nextcol], to_jsonb(bottom)),
        jsonb_set(rights, array[nextrow || ',' || nextcol], to_jsonb(rightb))
    from placements p
    cross join dimensions
    inner join flipped on
        (nextrow = 1 or top = (bottoms #>> array[nextrow - 1 || ',' || nextcol]))
        and (nextcol = 1 or leftb = (rights #>> array[nextrow || ',' || nextcol - 1]))
        and not placed @> array[id]
)
select
    placed[1]
    * placed[edge_size]
    * placed[(edge_size - 1) * edge_size + 1]
    * placed[edge_size * edge_size]
from placements, dimensions
where array_length(placed, 1) = edge_size * edge_size ;
