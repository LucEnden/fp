module FinancesTests exposing (..)

import Finances exposing (..)


dataA: List Float
dataA = [ 315.75, 0, -90.55, -151.35, 0, 290.10, -722.25 ]

dataB: List Float
dataB = [ 0, -90.55, -151.35, 0, -722.25 ]

testAversionA: Bool
testAversionA = (minimumGainA dataA == Just 290.10)

testAversionB: Bool
testAversionB = (minimumGainB dataA == Just 290.10)

testBversionA: Bool
testBversionA = (minimumGainA dataB == Nothing)

testBversionB: Bool
testBversionB = (minimumGainB dataB == Nothing)

allTests: List Bool
allTests =
    [
        testAversionA, testAversionB,
        testBversionA, testBversionB
    ]
