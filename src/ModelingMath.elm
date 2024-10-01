module ModelingMath exposing (..)

-- Given the type Function, write function 
-- print: Function -> String 
-- eval: Float -> Function -> Float 
-- graph: Function -> Int -> Int -> Int -> Int -> String 

-- Function print gives a human readable infix representation of the Function. 
-- Function eval calculates the function values of the given input values. 
-- Function graph makes an graph of the function, within the ranges xmin-xmax and ymin-ymax. 
-- You may choose another return type if you prefer. 

-- Tip: it’s easier to rotate 90 degrees 
-- (so the y-axis is from left to right, and the x-axis is from top to bottom). And perhaps you 
-- need to enlarge the variable page_width of the template. 

-- You can use https://www.mathsisfun.com/calculus/derivative-plotter.html to create your own 
-- functions and to check your results. 

-- Examples: 
-- > f = Plus (Mult (Plus (Const 3) X) (Minus X (Poly X 5))) (Const 2) 
-- > print f 
-- "(((3 + x) * (x - (x ^ 5))) + 2)" 
 
-- > eval 2 f 
-- -148

type Function
    = Poly Function Int
    | Mult Function Function
    | Div Function Function
    | Plus Function Function
    | Minus Function Function
    | Const Int
    | X

f: Function
f = Plus (Mult (Plus (Const 3) X) (Minus X (Poly X 5))) (Const 2)

print: Function -> String 
print func =
    -- Note for class:
    -- Given the example input `f` the code bellow provides the expected output as defined in the FP_outline.pdf
    -- However, I feel like the brackets need to be part of the type Function
    -- If you look at antlr4 grammer for example, it seems evident how they should be part of type Function:
    -- D:\Users\luc\repos\aut\src\BooleanArithmetic\BooleanArithmetic.g4
    case func of
        Poly a b    -> "(" ++ print a ++ " ^ " ++ String.fromInt b ++ ")"
        Mult a b    -> "(" ++ print a ++ " * " ++ print b ++ ")"
        Div a b     -> "" ++ print a ++ " / " ++ print b ++ ")"
        Plus a b    -> "(" ++ print a ++ " + " ++ print b ++ ")"
        Minus a b   -> "(" ++ print a ++ " - " ++ print b ++ ")"
        Const a     -> String.fromInt a
        X           -> "x"

eval: Float -> Function -> Float 
eval valueForX func =
    case func of
        Poly a b    -> eval valueForX a ^ toFloat b -- We need to cast int to float, as elm seems to start crying when you do not pass 2 arguments of the same type to the power operator ^
        Mult a b    -> eval valueForX a * eval valueForX b
        Div a b     -> eval valueForX a / eval valueForX b
        Plus a b    -> eval valueForX a + eval valueForX b
        Minus a b   -> eval valueForX a - eval valueForX b
        Const a     -> toFloat a
        X           -> valueForX


-- g is the function g(x) = (x/5 - 1) ^ 4 – ((x/-2) + 2) ^ 2 + 6 
-- print with x-range: -10 to 20, and y-range: -10 to 10
-- > graph g -10 20 -10 10
-- ********************

g: Function
g = (Minus (Poly (Minus (Div X (Const 5)) (Const 1)) 4) (Plus (Poly (Plus (Div X (Const -2)) (Const 2)) 2) (Const 6)))

graphRow: Float -> Int -> Int -> String
graphRow valForX yMin yMax =
    if yMin >= yMax then
        -- Base case
        ""
    else
        -- TODO: fix the conditional for plotting either a - or a *
        if toFloat yMax - valForX <= toFloat yMin then
            "-" ++ graphRow valForX (yMin + 1) yMax
        else
            "*" ++ graphRow valForX (yMin + 1) yMax

graph: Function -> Int -> Int -> Int -> Int -> String 
graph func xMin xMax yMin yMax =
    if xMin >= xMax then
        ""
    else
        graphRow (eval (toFloat xMin) func) yMin yMax