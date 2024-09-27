module Finances exposing (..)
import List exposing (sort)

-- In the provided Elm project, you will find a module Finances, where you need to implement 
-- two versions of function minimumGain with the following signature: 
--      `minimumGain: List Float -> Maybe Float`

-- This function receives a list of monthly gains and losses of a company.  Positive numbers 
-- represent gains and negative numbers represent losses.
-- The function must return the minimum monthly gain, if there are any gains.

-- That is, for input [ 315.75, 0, -90.55, -151.35, 0, 290.10, -722.25 ] the output 
-- must be Just 290.10, while for input [ 0, -90.55, -151.35, 0, -722.25 ] the output 
-- must be Nothing. 

-- You must implement two versions of the function: 
-- • minimumGainA, where you do not use recursion but only use predefined functions in 
-- the List library. 
-- • minimumGainB, where you do not use any of the predefined List functions but only 
-- use recursion. 

-- The provided Elm project contains also a module Tests with unit tests corresponding to the 
-- two examples above for both versions of the function.

minimumGainA: List Float -> Maybe Float
minimumGainA monthlyGainsAndLosses =
    let
        filteredGainsAndLosses = List.filter (\x -> x > 0) monthlyGainsAndLosses
        sortedGainsAndLosses = List.sort filteredGainsAndLosses
    in

    List.head sortedGainsAndLosses
    -- if List.length sortedGainsAndLosses > 0 then
    --     Debug.log (Debug.toString sortedGainsAndLosses)
    --     List.head sortedGainsAndLosses 
    --     -- We can just return List.head without any if else's, as the return type of list.head matches the return type of 
    -- else
    --     Nothing

myTestInFinancesA : Maybe Float
myTestInFinancesA =
    minimumGainA [ 315.75, 0, -90.55, -151.35, 0, 290.10, -722.25, 315.75 ]
    
sumOfAbsPlus1: List Float -> Float
sumOfAbsPlus1 listOfFloats =
    case listOfFloats of
        [] -> 1
        x :: xs -> abs(x) + sumOfAbsPlus1 xs

minimumGainBRecursion: Float -> List Float -> Float
minimumGainBRecursion currentLowestGain monthlyGainsAndLosses =
    case monthlyGainsAndLosses of
        [] -> currentLowestGain
        x :: xs ->
            if x > 0 && x < currentLowestGain then
                minimumGainBRecursion x xs
            else
                minimumGainBRecursion currentLowestGain xs

minimumGainB: List Float -> Maybe Float
minimumGainB monthlyGainsAndLosses =
    let
        -- In order for the recursive function to work
        -- We need a number that is gareunteed to be greater then all values in the input
        -- We can use the sum of the absolute values from the list + 1 for this
        -- The reason for the plus one is for when a list is provided with only 1 element
        sumOfGainsAndLosses = sumOfAbsPlus1 monthlyGainsAndLosses
        lowestGain = minimumGainBRecursion sumOfGainsAndLosses monthlyGainsAndLosses
    in

    -- Debug.log (Debug.toString (lowestGain))
    -- Debug.log (Debug.toString (sumOfGainsAndLosses))
    
    if lowestGain == sumOfGainsAndLosses then
        Nothing
    else
        Just lowestGain

myTestInFinancesB : Maybe Float
myTestInFinancesB =
    minimumGainB [ 315.75, 0, -90.55, -151.35, 0, 290.10, -722.25, 315.75 ]