module Pythagoras exposing (..)

sqr: Int -> Int
sqr n =
    n * n

isTriple: Int -> Int -> Int -> Bool
isTriple a b c =
    -- Debug.log (Debug.toString (sqr a))
    -- Debug.log (Debug.toString (sqr b))
    -- Debug.log (Debug.toString (sqr c))

    if a < 0 || b < 0 || c < 0 then
        False
    else
        (sqr a) + (sqr b) == (sqr c)

leg1 : Int -> Int -> Int
leg1 x y =
    (sqr x) - (sqr y)
leg2 : Int -> Int -> Int
leg2 x y =
    2 * x * y
hyp  : Int -> Int -> Int
hyp x y =
    (sqr x) + (sqr y)

pythTriple : (Int, Int) -> (Int, Int, Int)
pythTriple (x, y) =
    (leg1 x y, leg2 x y, hyp x y)

isTripleTuple: (Int, Int, Int) -> Bool
isTripleTuple (x, y, z) =
    isTriple x y z

pythTriplesMap: List (Int, Int) -> List (Int, Int, Int)
pythTriplesMap pairs =
    List.map (\x -> pythTriple x) pairs

pythTriplesRec: List (Int, Int) -> List (Int, Int, Int)
pythTriplesRec pairs =
    case pairs of
        [] ->
            []
        x :: xs ->
            -- Debug.log (Debug.toString (pythTriple x))
            pythTriple x :: pythTriplesRec xs

arePythTriplesFilter: List (Int, Int, Int) -> List (Int, Int, Int) 
arePythTriplesFilter triples =
    List.filter (\x -> isTripleTuple x) triples

arePythTriplesRec: List (Int, Int, Int) -> List (Int, Int, Int)
arePythTriplesRec triples = 
    case triples of
        [] ->
            []
        x :: xs ->
            -- Debug.log (Debug.toString (pythTriple x))
            if isTripleTuple x then
                x :: arePythTriplesRec xs
            else
                arePythTriplesRec xs