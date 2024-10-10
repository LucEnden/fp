module HigherOrderFunctions exposing (..)

-- Write the function 
repeatUntil: (a -> Bool) -> (a -> a) -> a -> a 
repeatUntil predicate f x =
    if predicate x then
        x
    else
        repeatUntil predicate f (f x)

-- which can be used in the following way: 
above100: Int -> Bool 
above100 x = 
    x > 100 
 
double: Int -> Int 
double x = 
    x * 2 

testA: Bool
testA = (repeatUntil above100 double 7) == 112

-- In this case, repeatUntil is repeatingly applying function double on initial value 7 (and 
-- its result, etc.) until the value is greater than 100 (i.e. the predicate function above100 
-- holds).  

-- above100 7 is False, so apply: double(7) = 14 
-- double(14) = 28 
-- double(28) = 56 
-- double(56) = 112, and now it stops because above100 112 is True 
-- So: repeatUntil p f init is continuously calculating f(f(f...f(f(f(init))))) until predicate p 
-- holds. 
-- • Check that  
-- repeatUntil above100 ((+) 1) 42
-- indeed returns 101.
testB: Bool
testB = (repeatUntil above100 ((+) 1) 42) == 101
-- • Change above100 into a new function such that it can stop above any given value.
above: number -> number -> Bool
above x y = 
    -- Debug.log (Debug.toString ( (x, y, x > y) ))
    y > x

testC: Bool
testC = (repeatUntil (above 10) ((+) 1) 8) == 11
-- • Calculate 3log 100 (for natural numbers only). Spoiler: answer=5 because 35=243 (and 34 = 81).
-- Make sure that the calculations can be done for other base numbers and target numbers as well. 
log: number -> number -> number
log base target =
    -- NOTE FOR CLASS:
    -- I had no idea how to use log... So I asked ChatGPT to help me explain what is expected of me in the assigment
    -- It was only trough its explanation that I saw how repeatUntil works:
    -- "... such that 3^n is less than or equal to 100." <- The part that gave it away
    -- I can use repeat until with a lambda predicate to repeatatly find numbers for N, starting at the neutral element of multiplication (1)
    
    repeatUntil (\x -> (base ^ x) >= target) (\n -> n + 1) 1
    -- FOR MY OWN SANITY:
    -- We start with an exponent of 1 and check, using the lambda predicate, whether base to the power of 1 is greater then or equal to our target of 100
    -- For a base of 3, that would be 3 ^ 1 = 3         (fun fact: typing 3 ^ 1 in python3 gives 2, its the BITWISE XOR)
    -- Given that 3 < 100, we apply a lambda function to the starting value of 1 (this case add 1) and go again
testD: Bool
testD = (log 3 100) == 5

-- • Examine if the Collatz sequence of a given number indeed ends at 1 (see 
-- https://en.wikipedia.org/wiki/Collatz_conjecture).
-- Now we don't choose the application function f being Int -> Int (because the 
-- final value is 'always' 1, too boring): 
-- repeatUntil ((==) 1) (\x-> if even x then x // 2 else 3 * x + 1 ) 19

-- but instead: List Int -> List Int, collecting the whole sequence. Example: 
-- > repeatUntil myPredicate myCollatz [19] 
-- [1,2,4,8,16,5,10,20,40,13,26,52,17,34,11,22,44,88,29,58,19]
-- repeatUntil myPredicate myCollatz [19]

allTests: List Bool
allTests = [ testA, testB, testC, testD ]