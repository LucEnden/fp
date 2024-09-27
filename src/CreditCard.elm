module CreditCard exposing (..)
import Html exposing (Html)

------------------------------------------------------------------------------------------------------------------------------
-- Validating Credit Card Numbers
------------------------------------------------------------------------------------------------------------------------------

-- Use the template CreditCard_template.elm. Make sure that at least once you have 
-- applied each of the following features: 
-- • function recursion 
--          DONE: see `toDigits` (amongst others)
-- • list recursion
--          DONE: see `doubleSecondRecursion` (amongst others)
-- • lambda expression (aka. anonymous function) 
--          DONE: see `filterNonDigits` (amongst others)
-- • List.map 
--          DONE: see `toDigits` (amongst others)
-- • List.filter 
--          DONE: see `filterNonDigits`
-- • List.foldr or List.foldl
--          DONE: see `toDigitsRev` (amongst others)


-- ===================================
-- Ex. 0
-- ===================================
filterNonDigits: String -> String
filterNonDigits stringToFilter =
    String.fromList (List.filter (\character -> Char.isDigit character) (String.toList stringToFilter))

toDigits: String -> List Int
toDigits stringToConvert =
    let
        allIntX = filterNonDigits stringToConvert
    in

    -- To be completly honest, the only reason this `List.map` is here is because it is asked of me
    -- and I forgot to put it in my code, so I chose to refactor my `case ... of` into a map

    -- Regardless, this map does work!
    -- The `Maybe.withDefault 0` is their just to shut the interpeter up about type issues
    -- As `String.toInt` returns a `Maybe (Int)`, but given that I've used my `filterNonDigits`,
    -- I already know that the default value will never be returned
    List.map (\integer -> Maybe.withDefault 0 (String.toInt (String.fromChar integer))) (String.toList allIntX)

    -- OLD IMPLEMENTATION ->
    -- case String.uncons allIntX of
    --     Nothing -> []
    --     Just(head, tail) ->
    --         case String.toInt (String.fromChar head) of
    --             Nothing -> 
    --                 Debug.log "in toDigits: x contains a non digit character, ignoring and moving on"
    --                 toDigits tail
    --             Just(digit) -> 
    --                 digit :: toDigits tail

-- ===================================
-- Ex. 1
-- ===================================
toDigitsRev: String -> List Int
toDigitsRev stringToConvert = 
    let
        reversedX = String.fromList (List.foldl (\a b -> a :: b) [] (String.toList stringToConvert))
    in
    toDigits reversedX

-- ===================================
-- Ex. 2
-- ===================================
doubleSecondRecursion: Int -> List Int -> List Int
doubleSecondRecursion oneIndexBased listToRecurse =
    case listToRecurse of
        [] -> []
        head :: tail ->
            -- We mod by 2 as to check whether 
            if modBy 2 oneIndexBased == 0 then
                -- We double every second digit, i.e. multiply by 2
                head * 2 :: doubleSecondRecursion (oneIndexBased + 1) tail
            else
                head :: doubleSecondRecursion (oneIndexBased + 1) tail

doubleSecond: List Int -> List Int
doubleSecond listToRecurse = 
    -- We provide 1 as the index to `doubleSecondRecursion`,
    -- because starting at the 0th index would mean that modBy 2 0 = 0
    doubleSecondRecursion 1 listToRecurse

    -- let
    --     indexUsedToCheckIfWeAreAtAnySecondDigit = 1
    --     -- NOTE FOR IN CLASS: I hate this, I much prefer just plopping in a 1 in this case
    -- in
    -- doubleSecondRecursion indexUsedToCheckIfWeAreAtAnySecondDigit listToRecurse

-- ===================================
-- Ex. 3
-- ===================================
sumDigits: List Int -> Int
sumDigits listToSum = 
    let
        neutralElementOfAddition = 0
    in
    List.foldr (+) neutralElementOfAddition listToSum

-- ===================================
-- Ex. 4
-- ===================================

-- Taken from the FP_outline.pdf ->
--      In this exercise, you will implement a validation algorithm for credit cards. The algorithm 
--      follows these steps: 
--      • Double the value of every second digit beginning with the rightmost. 
--      • Add the digits of the doubled values and the undoubled digits from the original 
--      number. 
--      • Calculate the modulus of the sum divided by 10.
--      • If the result equals 0, then the number is valid

--      Here is an example of the results of each step on the number "4012888888881881". 
--      1. In order to start with the rightmost digit, we produce a reversed list of digits. Then, we 
--      double every second digit.  
--      Result: [1,16,8,2,8,16,8,16,8,16,8,16,2,2,0,8]. 
--      2. We sum all of the digits of the resulting list above. Note that we must again split the 
--      elements of the list into their digits (e.g. 16 becomes [1, 6]). 
--      Result: 90. 
--      • Finally, we calculate the modulus of 90 over 10. 
--      Result: 0.

isValid: String -> Bool
isValid x =
    let
        -- First step, just like in the example
        xReversedToDigits = toDigitsRev x
        -- Second step...
        everySecondDoubled = doubleSecond xReversedToDigits
        concatenatedDigits =  List.foldr (++) "" (List.map (\i -> String.fromInt i) everySecondDoubled)
        sumOfConcatenatedDigits = sumDigits (toDigits concatenatedDigits)
        -- Third step...
        modulusOfSum = modBy 90 sumOfConcatenatedDigits
    in

    -- Debug.log (Debug.toString (
    --     xReversedToDigits
    -- )) -- Expected: [1,8 ,8,1,8,8 ,8,8 ,8,8 ,8,8 ,2,1,0,4]
    -- Debug.log (Debug.toString (
    --     everySecondDoubled
    -- )) -- Expected: [1,16,8,2,8,16,8,16,8,16,8,16,2,2,0,8]
    -- Debug.log (Debug.toString (
    --     concatenatedDigits
    -- )) -- Expected: "116828168168168162208"
    -- Debug.log (Debug.toString (
    --     sumOfConcatenatedDigits
    -- )) -- Expected: 90
    -- Debug.log (Debug.toString (
    --     modulusOfSum
    -- )) -- Expected: 0

    modulusOfSum == 0

-- ===================================
-- Ex. 5
-- ===================================
    
numValid: List String -> Int
numValid creditCardNumbersToCheck = 
    List.foldr (\card validCount -> if isValid card then validCount + 1 else validCount) 0 creditCardNumbersToCheck


creditcards: List Int
creditcards = [ 4716347184862961,
                4532899082537349,
                4485429517622493,
                4320635998241421,
                4929778869082405,
                5256283618614517,
                5507514403575522,
                5191806267524120,
                5396452857080331,
                5567798501168013,
                6011798764103720,
                6011970953092861,
                6011486447384806,
                6011337752144550,
                6011442159205994,
                4916188093226163,
                4916699537435624,
                4024607115319476,
                4556945538735693,
                4532818294886666,
                5349308918130507,
                5156469512589415,
                5210896944802939,
                5442782486960998,
                5385907818416901,
                6011920409800508,
                6011978316213975,
                6011221666280064,
                6011285399268094,
                6011111757787451,
                4024007106747875,
                4916148692391990,
                4916918116659358,
                4024007109091313,
                4716815014741522,
                5370975221279675,
                5586822747605880,
                5446122675080587,
                5361718970369004,
                5543878863367027,
                6011996932510178,
                6011475323876084,
                6011358905586117,
                6011672107152563,
                6011660634944997,
                4532917110736356,
                4485548499291791,
                4532098581822262,
                4018626753711468,
                4454290525773941,
                5593710059099297,
                5275213041261476,
                5244162726358685,
                5583726743957726,
                5108718020905086,
                6011887079002610,
                6011119104045333,
                6011296087222376,
                6011183539053619,
                6011067418196187,
                4532462702719400,
                4420029044272063,
                4716494048062261,
                4916853817750471,
                4327554795485824,
                5138477489321723,
                5452898762612993,
                5246310677063212,
                5211257116158320,
                5230793016257272,
                6011265295282522,
                6011034443437754,
                6011582769987164,
                6011821695998586,
                6011420220198992,
                4716625186530516,
                4485290399115271,
                4556449305907296,
                4532036228186543,
                4916950537496300,
                5188481717181072,
                5535021441100707,
                5331217916806887,
                5212754109160056,
                5580039541241472,
                6011450326200252,
                6011141461689343,
                6011886911067144,
                6011835735645726,
                6011063209139742,
                379517444387209,
                377250784667541,
                347171902952673,
                379852678889749,
                345449316207827,
                349968440887576,
                347727987370269,
                370147776002793,
                374465794689268,
                340860752032008,
                349569393937707,
                379610201376008,
                346590844560212,
                376638943222680,
                378753384029375,
                348159548355291,
                345714137642682,
                347556554119626,
                370919740116903,
                375059255910682,
                373129538038460,
                346734548488728,
                370697814213115,
                377968192654740,
                379127496780069,
                375213257576161,
                379055805946370,
                345835454524671,
                377851536227201,
                345763240913232
              ]

-- I did not feel like getting the html stuff to work so I just made this
myTestInCreditCard =
    (numValid (List.map (\x -> String.fromInt x) creditcards))

-- collecting results for printing:
-- my_results =
--     [
--         "calculations:",
--         "-- end --"
--     ] 
-- create main method (Boiler-plate)
-- to_div my_value = 
--     Html.div [] [ my_value |> Html.text ]
-- main = Html.div 
--         []
--         (List.map to_div my_results)