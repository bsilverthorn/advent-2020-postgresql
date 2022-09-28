--
-- INPUT
--

create temp table instructions
(
    pos int,
    ins varchar,
    arg int
) ;
copy instructions from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

-- * acc increases or decreases a single global value called the accumulator by
--   the value given in the argument. For example, acc +7 would increase the
--   accumulator by 7. The accumulator starts at 0. After an acc instruction, the
--   instruction immediately below it is executed next.
-- * jmp jumps to a new instruction relative to itself. The next instruction to
--   execute is found using the argument as an offset from the jmp instruction;
--   for example, jmp +2 would skip the next instruction, jmp +1 would continue
--   to the instruction immediately below it, and jmp -20 would cause the
--   instruction 20 lines above to be executed next.
-- * nop stands for No OPeration - it does nothing. The instruction immediately
--   below it is executed next.

with recursive states as (
    select
        0 as pc,
        0 as acc,
        array[]::integer[] as seen
    union
    select
        case when ins = 'jmp' then pc + arg else pc + 1 end,
        case when ins = 'acc' then acc + arg else acc end,
        seen || array[pc]
    from states
    join instructions on pos = pc
    where not pc = any(seen)
)
select acc from states ;
