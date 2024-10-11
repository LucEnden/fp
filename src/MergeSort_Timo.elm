module MergeSort_Timo exposing (..)


merge: List comparable -> List comparable -> List comparable
merge left right = 
    case (left, right) of
        (x :: xs, y :: ys) ->
            if x <= y then
                x :: merge xs right
            else
                y :: merge left ys
        ([], _ :: _) -> right
        (_ :: _, []) -> left
        (_, _) -> []


halve: List a -> (List a, List a)
halve list =
    case list of
        x :: y :: zs ->
            let
                (xs, ys) = halve zs
            in
                (x :: xs, y :: ys)
        _ -> (list, [])


msort: List comparable -> List comparable
msort list = 
    let
        (left, right) = halve list
    in
        if List.length list > 1 then
            merge (msort left) (msort right)
        else
            list


msortTestA: Bool
msortTestA = msort [8, 12, 5, 6, 1, 7, 21] == [1, 5, 6, 7, 8, 12, 21]


msortTestB: Bool
msortTestB = msort ['c', 'z', 'g', 'h', 'b', 'a'] == ['a', 'b', 'c', 'g', 'h', 'z']


msortTestC: Bool
msortTestC = msort ["cinnamon", "appointment", "salmon", "god", "happy", "bowling", "apple"] == ["apple", "appointment", "bowling", "cinnamon", "god", "happy", "salmon"]


msortTestD: Bool
msortTestD = msort [8.9, 12.3, 5.4, 6.9, 1.0, 7.8, 21.2] == [1.0, 5.4, 6.9, 7.8, 8.9, 12.3, 21.2]


msortTestE: Bool
msortTestE = msort [(8, 3, 4), (2, 7, 9), (1, 4, 8)] == [(1, 4, 8), (2, 7, 9), (8, 3, 4)]


msortTestF: Bool
msortTestF = msort [] == []


msortTestG: Bool
msortTestG = msort [-1] == [-1]


msortTestH: Bool
msortTestH = msort [1, 2, 3, 3, 3, 4, 4, 5, 6] == [1, 2, 3, 3, 3, 4, 4, 5, 6]


testAll: List Bool
testAll = [msortTestA, msortTestB, msortTestC, msortTestD, msortTestE, msortTestF, msortTestG, msortTestH]