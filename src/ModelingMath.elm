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
    = Poly Function Function
    | Mult Function Function
    | Div Function Function
    | Plus Function Function
    | Minus Function Function
    | Const Int
    | X

f: Function
f = Plus (Mult (Plus (Const 3) X) (Minus X (Poly X (Const 5)))) (Const 2)

print: Function -> String 
print func =
    -- Note for class:
    -- Given the example input `f` the code bellow provides the expected output as defined in the FP_outline.pdf
    -- However, I feel like the brackets need to be part of the type Function
    -- If you look at antlr4 grammer for example, it seems evident how they should be part of type Function:
    -- D:\Users\luc\repos\aut\src\BooleanArithmetic\BooleanArithmetic.g4
    case func of
        Poly a b    -> "(" ++ print a ++ " ^ " ++ print b ++ ")"
        Mult a b    -> "(" ++ print a ++ " * " ++ print b ++ ")"
        Div a b     -> "" ++ print a ++ " / " ++ print b ++ ")"
        Plus a b    -> "(" ++ print a ++ " + " ++ print b ++ ")"
        Minus a b   -> "(" ++ print a ++ " - " ++ print b ++ ")"
        Const a     -> String.fromInt a
        X           -> "x"

eval: Float -> Function -> Float 
eval valueForX func =
    case func of
        Poly a b    -> eval valueForX a ^ eval valueForX b
        Mult a b    -> eval valueForX a * eval valueForX b
        Div a b     -> eval valueForX a / eval valueForX b
        Plus a b    -> eval valueForX a + eval valueForX b
        Minus a b   -> eval valueForX a - eval valueForX b
        Const a     -> toFloat a
        X           -> valueForX


-- g is the function g(x) = (x/5 - 1) ^ 4 – ((x/-2) + 2) ^ 2 + 6 
-- print with x-range: -10 to 20, and y-range: -10 to 10
-- > graph g -10 20 -10 10

g: Function
g = (Minus (Poly (Minus (Div X (Const 5)) (Const 1)) (Const 4)) (Plus (Poly (Plus (Div X (Const -2)) (Const 2)) (Const 2)) (Const 6)))

graphRow: Float -> Int -> Int -> String
graphRow valForX yMin yMax =
    if yMin >= yMax then
        -- Base case
        ""
    else
        -- Notes for in class:
        -- I could not figure out the conditional for whether to print a - or *
        -- All I new was I needed to use the valForX somewhere in the conditional
        -- I tried several things (subtracting it from yMax and comparing that to yMin for example)
        -- But ended up asking ChatGPT what the conditional should be
        if toFloat yMin >= valForX then
            "-" ++ graphRow valForX (yMin + 1) yMax
        else
            "*" ++ graphRow valForX (yMin + 1) yMax

graph: Function -> Int -> Int -> Int -> Int -> String 
graph func xMin xMax yMin yMax =
    if xMin >= xMax then
        ""
    else
        graphRow (eval (toFloat xMin) func) yMin yMax ++ "\n" ++ graph func (xMin + 1) xMax yMin yMax

-- =================================================================
-- PART 2
-- =================================================================

-- Given the type Function, write functions
derivative: Function -> Function
-- simplify: Function -> Function 
-- Function derivative gives the derivative of a function (following all rules like chain-rule, etc.)
derivative func =
    -- NOTE FOR CLASS:
    -- Again (like with the higher order excersize `log` function), 
    -- I got no clue what the chain-rule is... So, once again, I asked ChatGPT
    -- https://chatgpt.com/share/670828fd-1270-800e-8814-4a76744f2654
    -- (and yes, i asked it to explain derivatives to me like I was 12)

    -- 1. Power rule:
    --     For f(x) = x^n, the derivative is f'(x) = n * x ^ (n-1).
    -- 2. Chain rule:
    --     For a composite function f(g(x)), the derivative is f'(g(x)) * g'(x).
    -- 3. Product rule:
    --     For two functions f(x) and g(x), the derivative is f'(x) * g(x) + f(x) * g'(x).
    -- 4. Quotient rule:
    --     For a ratio f(x) / g(x), the derivative is [f'(x) * g(x) - f(x) * g'(x)] / [g(x)]^2.
    -- 5. Constant rule:
    --     The derivative of a constant is 0.

    case func of
        Poly expresion power -> (Mult power (Poly (derivative expresion) (Minus power (Const 1)))) -- Power rule
        Const _ -> (Const 0)
        _ -> func

-- Function simplify prunes unnecessary branches like +0, *0, *1, ^1, ^0, /1. It also simplifies 
-- the multiplication, addition and subtraction of constants, like 3+6, 4^5, 9*5, -2--2. 
-- Examples: 
-- > print f 
-- "(((3+x)*(x-(x^5)))+2)" 
-- > print <| derivative f
-- print derivative f
-- "((((0+1)*(x-(x^5)))+((3+x)*(1-((5*(x^4))*1))))+0)"
-- > print <| simplify <| derivative f  
-- "((x-(x^5))+((3+x)*(1-(5*(x^4)))))"