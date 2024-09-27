
module LayoutTests exposing (..)


-- You do not need to modify anything in this module...

import Layout exposing (..)

testLAA: Bool
testLAA = (layoutA [1, 3, 5] == "/1/3/5/")

testLAB: Bool
testLAB = (layoutA [7] == "/7/")

testLBA: Bool
testLBA = (layoutB [1, 3, 5] == "/1/3/5/")

testLBB: Bool
testLBB = (layoutB [7] == "/7/")

testLCA: Bool
testLCA = (layoutC [1, 3, 5] == "/1/3/5/")

testLCB: Bool
testLCB = (layoutC [7] == "/7/")

allTests: List Bool
allTests = [testLAA, testLAB, testLBA, testLBB, testLCA, testLCB]
