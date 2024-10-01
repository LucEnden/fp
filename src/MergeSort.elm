module MergeSort exposing (..)

-- https://www.geeksforgeeks.org/merge-sort/:
-- Here’s a step-by-step explanation of how merge sort works:
--     Divide:     Divide the list or array recursively into two halves until it can no more be divided.
--     Conquer:    Each subarray is sorted individually using the merge sort algorithm.
--     Merge:      The sorted subarrays are merged back together in sorted order. 
--                 The process continues until all elements from both subarrays have been merged.

msort_conquere: (List comparable, List comparable) -> List comparable
msort_conquere dividedList =

    if List.length (Tuple.first dividedList) == 1
        -- Once the first element of the divided list has only 1 element, 
        -- we can no longer split it up, hence reaching the base case
        Debug.log (Debug.toString (dividedList))
        []
    else
        msort_conquere (Tuple.first dividedList, Tuple.second dividedList)
    

msort: List comparable -> List comparable
msort lst =
    let
        middle = List.length lst // 2
        -- For [1],         middle = 1 // 2 = 0
        -- For [1,2],       middle = 2 // 2 = 1
        -- For [1,2,3],     middle = 3 // 2 = 1
        -- For [1,2,3,4],   middle = 4 // 2 = 2
    in

    if List.length lst <= 1 then
        lst
    else
        []