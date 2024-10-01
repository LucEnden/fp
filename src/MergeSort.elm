module MergeSort exposing (..)

-- https://www.geeksforgeeks.org/merge-sort/:
-- Here’s a step-by-step explanation of how merge sort works:
--     Divide:     Divide the list or array recursively into two halves until it can no more be divided.
--     Conquer:    Each subarray is sorted individually using the merge sort algorithm.
--     Merge:      The sorted subarrays are merged back together in sorted order. 
--                 The process continues until all elements from both subarrays have been merged.

merge: List comparable -> List comparable
merge n =
    []

msort: List comparable -> List comparable
msort lst =
    -- let
    --     middle = List.length lst // 2
    --     -- For [1],         middle = 1 // 2 = 0
    --     -- For [1,2],       middle = 2 // 2 = 1
    --     -- For [1,2,3],     middle = 3 // 2 = 1
    --     -- For [1,2,3,4],   middle = 4 // 2 = 2
    -- in

    if List.length lst > 1 then
        merge lst
    else
        -- A list of length 1 or 0 does not need to be sorted
        lst