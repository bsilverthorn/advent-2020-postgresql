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

create or replace function eval_formula(inout tokens varchar[], out value bigint) as $$
declare
    token varchar ;
    operator varchar ;
    operand bigint ;
    evaled record ;
begin
    while array_length(tokens, 1) > 0 loop
        token := tokens[1] ;
        tokens := tokens[2:] ;

        if token = '+' then
            operator := token ;
        elsif token = '*' then
            operator := token ;
        else
            if token = ')' then
                exit ;
            elsif token = '(' then
                evaled := eval_formula(tokens) ;
                tokens := evaled.tokens ;
                operand := evaled.value ;
            else
                operand := token::bigint ;
            end if ;

            if operator = '+' then
                value := value + operand ;
                operator := null ;
            elsif operator = '*' then
                value := value * operand ;
                operator := null ;
            else
                value := operand ;
            end if ;
        end if ;
    end loop ;
end ;
$$ language plpgsql ;

select sum((eval_formula(string_to_array(formula, ' '))).value) from homework ;
