module Folding exposing (..)

sum: List Int -> Int
sum x =
    case x of
        [] ->
            0
        n :: ns ->
            n + sum ns

putTogether: List Char -> String
putTogether x =
    case x of
        [] ->
            ""
        c :: cs ->
            String.fromChar c ++ putTogether cs


-- Folding is the act of recusrivly going to the end of a given list
-- and then based the direction (left or right) we provide a base case (and a list),

-- <function> : (a -> b -> b) -> b -> List a -> b
-- where the first argument "(a -> b -> b)" is ... a function that recieves a list element and something to do with 
-- the second argument "b" is both the base case and also dictates 

-- Excersize: define your own map and filter using both your own recursion as well as using foldr