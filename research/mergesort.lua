-- Merge Sort in a functional programming style

-- Split a list into two halves
local function split(list)
    local mid = math.floor(#list / 2)
    local left = {}
    local right = {}
    for i = 1, mid do
        table.insert(left, list[i])
    end
    for i = mid + 1, #list do
        table.insert(right, list[i])
    end
    return left, right
end

-- Merge two sorted lists
local function merge(left, right)
    if #left == 0 then return right end
    if #right == 0 then return left end
    if left[1] <= right[1] then
        return {left[1], table.unpack(merge({table.unpack(left, 2)}, right))}
    else
        return {right[1], table.unpack(merge(left, {table.unpack(right, 2)}))}
    end
end

-- Merge Sort function
local function mergeSort(list)
    if #list <= 1 then return list end
    local left, right = split(list)
    return merge(mergeSort(left), mergeSort(right))
end

-- Example usage
local unsortedList = {38, 27, 43, 3, 9, 82, 10}
local sortedList = mergeSort(unsortedList)
for _, v in ipairs(sortedList) do
    print(v)
end