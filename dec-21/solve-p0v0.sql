--
-- INPUT
--

create temp table foods
(
    ingredients text[],
    allergens text[]
) ;
copy foods from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

-- assemble the constraints

create temp table all_ingredients as 
select distinct unnest(ingredients) as ingredient from foods ;

create temp table all_allergens as
select distinct unnest(allergens) as allergen from foods ;

create temp table allergen_options as
select
    allergen,
    ingredient
from all_allergens
inner join all_ingredients on not exists (
    select from foods
    where allergens @> array[allergen] and not ingredients @> array[ingredient]
) ;

-- resolve the constraints

create temp table unsafe_ingredients
(
    allergen text,
    ingredient text
) ;

create or replace procedure reduce_allergen_options() as $$
begin
    loop
        insert into unsafe_ingredients
        select ao.*
        from allergen_options ao
        inner join (
            select allergen
            from allergen_options
            group by 1
            having count(*) = 1
        ) ro on ro.allergen = ao.allergen ;

        delete from allergen_options ao where exists (
            select from unsafe_ingredients ui where ui.ingredient = ao.ingredient
        ) ;

        if not found then
            exit ;
        end if ;
    end loop ;
end ;
$$ language plpgsql ;

call reduce_allergen_options() ;

-- print solutions to both parts

select count(*)
from foods f
inner join all_ingredients ai on array[ai.ingredient] <@ f.ingredients
where not exists (
    select from unsafe_ingredients ui where ui.ingredient = ai.ingredient
) ;

select string_agg(ingredient, ',' order by allergen) from unsafe_ingredients ;
