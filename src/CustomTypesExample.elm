module CustomTypesExample exposing (..)

-- type Maybe a
--     = Just a
--     | Nothing
--     -- A custom type is either just something (whatever you like), or Nothing

-- type Either a
--     = Num Int 
--     | Letter Char
--     | Just a
--     | Nothing

-- f: Either -> Int
-- f e =
--     case e of
--         Num n ->        n * n
--         Letter c ->     Char.toCode c


type Either a b
    = Left a
    | RIght b

f: Either -> Int
f e =
    case e of
        Left n ->   n * n
        Right c ->  Char.toCode c