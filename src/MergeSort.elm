module MergeSort exposing (..)

-- https://www.geeksforgeeks.org/merge-sort/:
-- Here’s a step-by-step explanation of how merge sort works:
--     Divide:     Divide the list or array recursively into two halves until it can no more be divided.
--     Conquer:    Each subarray is sorted individually using the merge sort algorithm.
--     Merge:      The sorted subarrays are merged back together in sorted order. 
--                 The process continues until all elements from both subarrays have been merged.

-- #region Test lists
testCaseA = 
    [1, 2, 3, 4]
testCaseB = 
    [15, 12, 16, 18]
testCaseC = 
    [500, 1631, 1234, 9876]
testCaseD = 
    [10, 16, 14, 12, 18, 20, 28, 26, 22, 24, 30]
testCaseE = 
    [1, 2, 3]
-- #endregion

msort_divide: List comparable -> List (List comparable)
msort_divide lst =
    case lst of
        [] -> []
        x :: xs ->
            -- To get from a list of comparables to a list of list of comparabel,
            -- We can simply add the append a list containing the first element,
            -- and recurse onwards until we hit the base case
            [ [x] ] ++ msort_divide xs


--#region msort_divide tests
msort_divide_TestCaseA_expected = 
    [ [1], [2], [3], [4] ]
msort_divide_TestCaseB_expected = 
    [ [15], [12], [16], [18] ]
msort_divide_TestCaseC_expected = 
    [ [500], [1631], [1234], [9876] ]
msort_divide_TestCaseD_expected = 
    [ [10], [16], [14], [12], [18], [20], [28], [26], [22], [24], [30]]
msort_divide_TestCaseE_expected = 
    [ [1], [2], [3]]

msort_divide_Tests =
    [
        msort_divide testCaseA == msort_divide_TestCaseA_expected,
        msort_divide testCaseB == msort_divide_TestCaseB_expected,
        msort_divide testCaseC == msort_divide_TestCaseC_expected,
        msort_divide testCaseD == msort_divide_TestCaseD_expected,
        msort_divide testCaseE == msort_divide_TestCaseE_expected
    ]
--#endregion

msort: List comparable -> List comparable
msort lst =
    let
        dividedLst = msort_divide lst
    in

    