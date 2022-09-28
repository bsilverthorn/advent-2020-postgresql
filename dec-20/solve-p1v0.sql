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
copy tiles from :'tiles_inpath' delimiter ',' csv header ;

create temp table monster
(
    rd int,
    cd int
) ;
copy monster from :'monster_inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with recursive transformations as (
    select * from (
        values
        ( 1,  0,  0,  1, 'identity'),
        ( 1,  0,  0, -1, 'identity vertical'),
        (-1,  0,  0,  1, 'identity horizontal'),
        ( 0, -1,  1,  0, '90'),
        ( 0,  1,  1,  0, '90 vertical'),
        ( 0, -1, -1,  0, '90 horizontal'),
        (-1,  0,  0, -1, '180'),
        (-1,  0,  0,  1, '180 vertical'),
        ( 1,  0,  0, -1, '180 horizontal'),
        ( 0,  1, -1,  0, '270'),
        ( 0, -1, -1,  0, '270 vertical'),
        ( 0,  1,  1,  0, '270 horizontal')
    ) r(r11, r12, r21, r22, rname)
),
dimensions as (
    select
        (select sqrt(count(*))::int from tiles) as edge_size,
        (select max(rd) from monster) as monster_maxr,
        (select max(cd) from monster) as monster_maxc,
        (select count(*) from monster) as monster_pixels
),
coordinates as (
    select n, (n - 5) * 2 - 1 as c from generate_series(1, 10) numbers(n)
),
transformed as (
    select
        id,
        rname,
        (rn.c * r11 + cn.c * r12 + 1) / 2 + 5 as rn,
        (rn.c * r21 + cn.c * r22 + 1) / 2 + 5 as cn,
        block[rn.n][cn.n] as pixel
    from tiles
    cross join transformations
    cross join coordinates rn
    cross join coordinates cn
),
block_rows as (
    select id, rname, rn, array_agg(pixel order by cn) as pixels
    from transformed
    group by 1, 2, 3
),
blocks as (
    select id, rname, array_agg(pixels order by rn) as block
    from block_rows
    group by 1, 2
),
with_borders as (
    select
        blocks.*,
        string_agg(block[1][n], null order by n) as top,
        string_agg(block[10][n], null order by n) as bottom,
        string_agg(block[n][1], null order by n) as leftb,
        string_agg(block[n][10], null order by n) as rightb
    from blocks
    cross join generate_series(1, 10) numbers(n)
    group by 1, 2, 3
),
placements as (
    select
        1 as nextrow,
        2 as nextcol,
        array[id] as placed,
        array[block] as blocks,
        jsonb_build_object('1,1', bottom) as bottoms,
        jsonb_build_object('1,1', rightb) as rights
    from with_borders
    union
    select
        case when nextcol = edge_size then nextrow + 1 else nextrow end,
        case when nextcol = edge_size then 1 else nextcol + 1 end,
        placed || id,
        blocks || block,
        jsonb_set(bottoms, array[nextrow || ',' || nextcol], to_jsonb(bottom)),
        jsonb_set(rights, array[nextrow || ',' || nextcol], to_jsonb(rightb))
    from placements p
    cross join dimensions
    inner join with_borders on
        (nextrow = 1 or top = (bottoms #>> array[nextrow - 1 || ',' || nextcol]))
        and (nextcol = 1 or leftb = (rights #>> array[nextrow || ',' || nextcol - 1]))
        and not placed @> array[id]
),
image_rows as (
    select
        placed,
        tr,
        pr,
        array_agg(blocks[(tr - 1) * edge_size + tc][pr + 1][pc + 1] order by tc, pc) as image_row
    from placements
    cross join dimensions
    cross join generate_series(1, edge_size) tile_rows(tr)
    cross join generate_series(1, edge_size) tile_cols(tc)
    cross join generate_series(1, 8) pixel_rows(pr)
    cross join generate_series(1, 8) pixel_cols(pc)
    where
        array_length(placed, 1) = edge_size * edge_size
    group by 1, 2, 3
    order by 1, 2, 3
),
images as (
    select
        placed,
        array_agg(image_row order by tr) as image,
        sum((select count(*) from unnest(image_row) ir(p) where p = '#')) as roughness
    from image_rows
    group by 1
),
locations as (
    select
        sr,
        sc
    from dimensions
    cross join generate_series(1, edge_size * 8 - monster_maxr) scan_rows(sr)
    cross join generate_series(1, edge_size * 8 - monster_maxc) scan_cols(sc)
),
spottings as (
    select
        (
            select count(*) from (
                select count(*) as matched
                from locations
                cross join monster
                where image[sr + rd][sc + cd] = '#'
                group by sr, sc
                having count(*) = 15 -- i.e., monster_pixels
            ) as each_spotting
        ) as monsters,
        roughness
    from images
)
select *, roughness - monsters * 15 as solution from spottings ;
