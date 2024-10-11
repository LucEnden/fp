module MergeSort exposing (..)

-- https://www.geeksforgeeks.org/merge-sort/:
-- Here’s a step-by-step explanation of how merge sort works:
--     Divide:     Divide the list or array recursively into two halves until it can no more be divided.
--     Conquer:    Each subarray is sorted individually using the merge sort algorithm.
--     Merge:      The sorted subarrays are merged back together in sorted order. 
--                 The process continues until all elements from both subarrays have been merged.

-- merge: List comparable -> List comparable
-- merge n =
--     []

-- msort: List comparable -> List comparable
-- msort lst =
--     -- let
--     --     middle = List.length lst // 2
--     --     -- For [1],         middle = 1 // 2 = 0
--     --     -- For [1,2],       middle = 2 // 2 = 1
--     --     -- For [1,2,3],     middle = 3 // 2 = 1
--     --     -- For [1,2,3,4],   middle = 4 // 2 = 2
--     -- in

--     if List.length lst > 1 then
--         merge lst
--     else
--         -- A list of length 1 or 0 does not need to be sorted
--         lst

-- Recursive merge sort implementation that sorts a list of comparable items
mergeSort : List comparable -> List comparable
mergeSort list =
    case list of
        [] -> [] -- An empty list is already sorted
        [x] -> [x] -- A single element list is already sorted
        _ ->
            -- Otherwise, split the list into two halves and recursively sort both halves
            let
                (left, right) = split list
            in
            -- Merge the two sorted halves into one sorted list
            merge (mergeSort left) (mergeSort right)


-- Recursive function to split a list into two halves
split : List comparable -> (List comparable, List comparable)
split list =
    -- Helper function to split the list by accumulating elements in two parts
    let
        -- Recursive helper function that splits based on even and odd positions
        splitHelper : List comparable -> List comparable -> List comparable -> (List comparable, List comparable)
        splitHelper remaining leftAcc rightAcc =
            case remaining of
                [] -> (leftAcc, rightAcc)-- Base case: no more elements, return the accumulated left and right lists
                [x] -> (x :: leftAcc, rightAcc)-- If there's one element left, add it to the left list and return the result
                x :: y :: xs ->
                    -- Recursively add the first element to the left list and the second to the right
                    splitHelper xs (x :: leftAcc) (y :: rightAcc)
    in
    -- Start the recursive split process with two empty lists as accumulators
    splitHelper list [] []


-- Recursive function to merge two sorted lists into a single sorted list
merge : List comparable -> List comparable -> List comparable
merge left right =
    case (left, right) of
        ([], _) ->
            -- If the left list is empty, return the right list
            right

        (_, []) ->
            -- If the right list is empty, return the left list
            left

        (x :: xs, y :: ys) ->
            -- Compare the heads of both lists and build the merged list recursively
            if x <= y then
                -- If the left head is smaller, add it to the result and recurse
                x :: merge xs right
            else
                -- If the right head is smaller, add it to the result and recurse
                y :: merge left ys

testCaseA: Bool
testCaseA = mergeSort [ 7, 1, 4, 5, 2, 3, 8, 6 ] == [ 1, 2, 3, 4, 5, 6, 7, 8 ]

testCaseB: Bool
testCaseB = mergeSort [ 1, 4, 7, 3, 5, 2, 8, 6 ] == [ 1, 2, 3, 4, 5, 6, 7, 8 ]

-- Run the test case
tests: List Bool
tests = [ testCaseA, testCaseB ]
