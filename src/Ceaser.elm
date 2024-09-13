module Ceaser exposing (..)

encode: Int -> Char -> Char
encode offset original = 
    -- A / 65
    -- ...
    -- Z / 90
    -- a / 97
    -- ...
    -- z / 122

    -- Taken from the excersise PDF:
    -- "Note that lower case letters remain lower case, and upper case letters remain upper case."
    original