--
-- INPUT
--

create temp table homework
(
    formula varchar
) ;
copy homework from :'inpath' delimiter ',' csv header ;

--
-- SOLVE
--

create or replace function eval_operators(
    until varchar,
    inout operators varchar[],
    inout operands bigint[]) as $$
begin
    while array_length(operators, 1) > 0 and operators[1] is distinct from until loop
        if operators[1] = '*' then
            operands[2] := operands[1] * operands[2] ;
        elsif operators[1] = '+' then
            operands[2] := operands[1] + operands[2] ;
        else
            raise exception 'unknown operator %', operators[1] ;
        end if ;

        operands := operands[2:] ;
        operators := operators[2:] ;
    end loop ;
end ;
$$ language plpgsql ;

create or replace function eval_formula(inout tokens varchar[], out value bigint) as $$
declare
    token varchar ;
    operators varchar[] ;
    operands bigint[] ;
    evaled record ;
begin
    while array_length(tokens, 1) > 0 loop
        token := tokens[1] ;
        tokens := tokens[2:] ;

        if token = '+' then
            operators := token || operators ;
        elsif token = '*' then
            evaled := eval_operators('*', operators, operands) ;
            operators := token || evaled.operators ;
            operands := evaled.operands ;
        elsif token = '(' then
            evaled := eval_formula(tokens) ;
            operands := evaled.value || operands ;
            tokens := evaled.tokens ;
        elsif token = ')' then
            exit ;
        else
            operands := token::bigint || operands ;
        end if ;
    end loop ;

    evaled := eval_operators(null, operators, operands) ;
    value := evaled.operands[1] ;
end ;
$$ language plpgsql ;

select sum((eval_formula(string_to_array(formula, ' '))).value) from homework ;
