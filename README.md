# Elm
...
https://fhict.instructure.com/courses/13984


## Installation (windows)
> `npm install -g elm`

## Elm Doc Preview
> `elm-doc-preview -p 8080`

## Basic types
Int, Bool, Float, Char, String
Collections: List, Tuple, Record,
Custom types

## Example function
```elm
add : Int -> Int -> Int     # function signature
add x y = x + y             # function body
add 1 2                     # function call
```

```elm
area : Float -> Float -> (Float, Float)
area width height = (width * height, width + height)
```

## Repl
You can run the Elm REPL by running `elm repl` in the terminal.
This allows you to run Elm code interactively.

Lets say you want to run the `add` function interactively. You can create an Elm file with the following content:
```elm
module add exposing (..)
add : Int -> Int -> Int
add x y = x + y
```

Then you can run the following commands in the Elm REPL:
```elm
> import Add exposing (..)
> add 1 2
3 : Int
```