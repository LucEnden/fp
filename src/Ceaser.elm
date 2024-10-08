module Ceaser exposing (..)
import String exposing (fromChar)
import List exposing (range)

-- ==========================================
-- Week 1
-- ==========================================

-- ASCII characters that are important to the implementation of encode/decode:
-- A / 65
-- ...
-- Z / 90
-- a / 97
-- ...
-- z / 122

encode: Int -> Char -> Char
encode offset original = 

    let
        o = Char.toCode original
        i = modBy 26 offset
        -- FEEDBACK: 
        -- replace the constant '26' by a variable
        -- for example you could write a function that takes in the lower and upper bound of your alphabet 
        -- and calculate the alphabetical range from that
        -- as a bonus it makes it more descriptive/readable to use a variable then a constant

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

-- ==========================================
-- Week 2
-- ==========================================

normalize: String -> String
normalize s =
    -- removes spaces and all non-letters (like #, =, !, @)
    -- normalize "Hi! Hey!"
    -- "HiHey"
    -- normalize ""
    -- ""

    -- The base case for my implementation is hitting an empty string
    -- As long as the string is not empty, I recursivly loop trough its characters
    -- If the head character is alphabetical:
    --      We return the head and continue normalizing the tail
    -- else:
    --      We continue with just the tail
    --      Since we now know the current head should be eliminated from the final string

    case String.uncons s of
        Nothing -> 
            -- base case
            s
        Just (head, tail) -> 
            -- head is first character, tail is the rest
            if Char.isAlpha head then
                (fromChar head) ++ normalize tail
            else
                normalize tail

encrypt: Int -> String -> String
encrypt offset message =
    case String.uncons message of
        Nothing ->
            -- base case
            message
        Just (head, tail) ->
            -- head is first character, tail is the rest
            -- Debug.log (fromChar (encode offset head))
            fromChar (encode offset head) ++ encrypt offset tail
    
decrypt: Int -> String -> String
decrypt offset message =
    case String.uncons message of
        Nothing ->
            -- base case
            message
        Just (head, tail) ->
            -- head is first character, tail is the rest
            -- Debug.log (fromChar (decode offset head))
            fromChar (decode offset head) ++ decrypt offset tail

-- ==========================================
-- Week 3
-- ==========================================
-- isSubstring: String -> String -> Bool
-- isSubstring substring stringToCheck =
--     if String.length substring > String.length stringToCheck then
--         False
--     else
--         case String.uncons stringToCheck of
--             Nothing -> False
--             Just(head, tail) ->
--                 Debug.log (Debug.toString head)
--                 Debug.log tail
--                 False

isKeyValidCandidate: Int -> List String -> String -> List (Int, String)
isKeyValidCandidate key canaries encryptedText =
    let
        decryptedText = decrypt key encryptedText
    in

    -- Here we recurse over canaries
    case canaries of
        [] -> []
        canary :: eccessCanaries ->
            -- TODO: implement isSubstring and replace String.contains with isSubstring
            if String.contains canary decryptedText then
                (key, decryptedText) :: isKeyValidCandidate key eccessCanaries encryptedText
            else
                isKeyValidCandidate key eccessCanaries encryptedText

recurseOverKeys: List Int -> List String -> String -> List (Int, String)
recurseOverKeys keys canaries encryptedText =
    case keys of
        [] -> []
        key :: eccessKeys ->
            isKeyValidCandidate key canaries encryptedText ++ recurseOverKeys eccessKeys canaries encryptedText

candidates: List String -> String -> List (Int, String)
candidates canaries encryptedText =
    let
        keys = range 0 25
        -- its trivial to replace the values above to variables in order to support an alphabet larger then 26 characters
    in

    -- We recurse over keys using a seperate function, 
    -- other wise if we use `case keys of` in here we will never reach the base case
    -- where keys is empty, given that we keep redefining it on each recursive step
    recurseOverKeys keys canaries encryptedText