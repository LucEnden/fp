module RecurrsionExample exposing (..)

-- see powerpoint for examples
factorial: Int -> Int
factorial n = 
    if n <= 1 then
        1
    else
        n * factorial (n - 1)

        