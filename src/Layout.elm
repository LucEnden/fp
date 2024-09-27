
module Layout exposing (..)


layoutA: List Int -> String
-- Definition of 'layoutA'...
layoutA ints = 
    case ints of
        [] -> "/"
        x :: xs ->
            "/" ++ String.fromInt x ++ layoutA xs

layoutB: List Int -> String
layoutB = List.foldl accLeft initLeft

-- Definitions of 'accLeft' and 'initLeft'...
accLeft: Int -> String -> String
accLeft i a =
    -- Debug.log (Debug.toString (i))
    -- Debug.log (Debug.toString (a))
    -- a ++ String.fromInt i ++ a -- FOR CLASS: this does not work, logging a should reveal why 
    a ++ String.fromInt i ++ initLeft

initLeft: String
initLeft = "/"

layoutC: List Int -> String
layoutC = List.foldr accRight initRight

-- Definitions of 'accRight' and 'initRight'...
initRight: String
initRight = "/"

accRight: Int -> String -> String
accRight i a =
    initRight ++ String.fromInt i ++ a