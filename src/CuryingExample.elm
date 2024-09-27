module CuryingExample exposing (..)

f: Int -> Int -> Int
f x y = 2 * x + y

-- The -> is a binary operator, just like +, -, * etc...
-- The question is how does the language handle the fact that the array can have different meanings

-- google presedence and associativity for a given language

-- in the above example
-- f 3 returns
-- <function> : Int -> Int

-- We can now do:
-- g = f 3
-- <function> : Int -> Int
-- And now we can do
-- g 1
-- will result for for the function above in
-- 7

-- This allows for partial applications
-- Take list.map:
-- <function> : (a -> b) -> List a -> List b
-- This takes in a function (a -> b) that is appliad to any list provided second
-- What curying allows is to say:
-- f = List.map ((+) 5)
-- We can now call f later on 

-- FROM THE SLIDES
-- Currying: function that takes n arguments = function that takes 1 argument and returns a function that takes n-1 arguments
-- Partial application: apply a function and pass it a fewer number of parameters than it expects

-- Check slide 38 for a nice visualization of partial applications 