module Ceaser exposing (..)

-- ASCII characters that are important to the implementations of encode/decode:
-- A / 65
-- ...
-- Z / 90
-- a / 97
-- ...
-- z / 122

-- Taken from the excersise PDF:
-- "Note that lower case letters remain lower case, and upper case letters remain upper case."

encode: Int -> Char -> Char
encode offset original = 

    let
        o = Char.toCode original
        i = modBy 26 offset

        (min, max) =
            if o >= 65 && o <= 90 then
                (65, 90)
            else
                (97, 122)
    in

    -- with the input 5 'x' we expect the output to be 99
    -- Debug.log (Debug.toString o) -- o = 120
    -- Debug.log (Debug.toString i) -- i = 5 mod 26 = 5
    -- Debug.log (Debug.toString min) -- min is 97
    -- Debug.log (Debug.toString max) -- max is 122
    -- Debug.log (Debug.toString (o + i)) -- o + i = 125
    -- Debug.log (Debug.toString (o + i - max + min)) -- 125 - 90 + 65 = 100
    -- we end with a - 1 to make the range inclusive
    -- we only need to map to range (i.e. subtract max and add min - 1) o + i > max
    if (o + i) > max then
        Char.fromCode (o + i - max + min - 1)
    else
        Char.fromCode (o + i)

decode: Int -> Char -> Char
decode offset original =
    if offset < 0 then
        encode offset original
    else
        encode (0 - offset) original