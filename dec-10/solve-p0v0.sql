--
-- INPUT
--

create temp table bag
(
    joltage int
) ;
copy bag from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

with adapters as (
    select row_number() over (order by joltage) as i, * from bag
),
differences as (
    select higher.joltage - coalesce(lower.joltage, 0) as diff
    from adapters higher
    left join adapters lower on lower.i = higher.i - 1
)
select
    count(case when diff = 1 then true end) * (count(case when diff = 3 then true end) + 1)
from differences ;
