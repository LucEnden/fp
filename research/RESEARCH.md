# Functional Programming Research

## Goal

The goal of this research is to determine how functional a predetirmined programming language is.

As described in the [canvas course](https://fhict.instructure.com/courses/13984/assignments/243524#submit):
> "The goal of this research assignment is to get a good impression of how FP looks like in a popular language of your choice: Python, C#, F#, Javascript, Java etc." ... "As part of this research, a prototype needs to be built of the Merge Sort Problem in the most functional way."

To achieve this goal, we will be answering the following questions:
1. What language will we be researching?
2. What does it mean for a programming language to be functional?
3. How functional is the language we are researching?

## 1. What language will we be researching?

We will be researching the programming language LUA. The reason for this choice is that LUA is a language we have limited knowledge of, and we are interested in learning more about it. This research will give us the opportunity to learn more about LUA and its functional programming capabilities.

To give a short introduction as to what lua is, we have taken the description from the [Lua 5.1 Refrence Manual](https://www.lua.org/manual/5.1/manual.html):
> "Lua is an extension programming language designed to support general procedural programming with data description facilities. It also offers good support for object-oriented programming, **functional programming**, and data-driven programming."

This description indicates that LUA is a language that supports functional programming, which we will be investigating further in the chapters below.

## 2. What does it mean for a programming language to be functional?

### Research Aproach

To answer the question at hand, we will use Perplexity to gather initial online sources. We’ll then compare definitions and characteristics from the set of online sources to identify a consensus on what defines a functional programming language.

### Sources used

Below are the sources we used to gather information on what defines a functional programming language:
1. [tutorialspoint.com](https://www.tutorialspoint.com/functional_programming/functional_programming_introduction.htm)
2. [geeksforgeeks.org](https://www.geeksforgeeks.org/functional-programming-paradigm/)
3. [wiki.haskell.org](https://wiki.haskell.org/Functional_programming)

### Definitions

The tutorialspoint.com source describes the difference between "pure functional languages" and "impure functional languages" as follows:
> "Pure Functional Languages − These types of functional languages support only the functional paradigms. For example − Haskell."
> 
> "Impure Functional Languages − These types of functional languages support the functional paradigms and imperative style programming. For example − LISP."

The geeksforgeeks.org source describes functional programming as follows:
> "Functional programming is a programming paradigm in which we try to bind everything in pure mathematical functions."

We can see that the geeksforgeeks article and the tutorialspoint article have a similar definition of functional programming: they both describe functional programming as a paradigm. Paradigm is defined in the [merriam-webster dictionary](https://www.merriam-webster.com/dictionary/paradigm) as:

> "a philosophical and theoretical framework of a scientific school or discipline within which theories, laws, and generalizations and the experiments performed in support of them are formulated"

This definition indicates that their exists a set of laws (or rules) which define what functional programming is. This is further supported by the fact that both the tutorialspoint and geeksforgeeks articles provide a list of characteristics that define functional programming aspects. These characteristics are:
- recursion
- functions are first-class citizens, which by extension;
    - should make the language support Currying
    - should make the language support higher-order functions
- immutable data/variables
- annonymous functions
- functions have no-side effects (i.e. pure functions)

This list of characteristics is also supported by the wiki.haskell.org source. It describes the same concepts troughout the article, and some more details specific to haskell (which is considered a pure functional programming language) but given the small time to do this research we will not go into these detail.

### Conclusion

From the sources we have gathered, we can conclude that a functional programming language is a language that supports the following characteristics:
1. recursion
2.  functions are first-class citizens, which by extension;
    1.  should make the language support Currying
    2.  should the language support higher-order functions
3.  immutable data/variables
4.  annonymous functions
5.  functions have no-side effects (i.e. pure functions)

## 3. How functional is the language we are researching?
 
To provide an answer to this question, we can simply look at the conclusion from research question 2 and see whether or not LUA supports these characteristics.

| Characteristic                      | Does LUA support this? |
|-------------------------------------|------------------------|
| recursion                           | Yes                    |
| functions are first-class citizens  | Yes                    |
| Currying                            | Yes                    |
| higher-order functions              | Yes                    |
| immutable data/variables            | No                     |
| annonymous functions                | Yes                    |
| functions have no-side effects      | No                     |

### Recursion Example

```lua
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end
```

### First-class functions Example

```lua
function add(x, y)
  return x + y
end

local a = add
print(a(1,2))
```

### Currying Example

```lua
function add(x, y)
  return x + y
end

local a = add

function addWithFunction(f, x, y)
  return f(x, y)
end

print(addWithFunction(a, 2, 3)) -- Outputs 5
```

### Immutable data/variables Example

All [variables in LUA are considered a table](https://www.lua.org/pil/2.5.html). All tables can be updated at any given time, which means that LUA does not support immutable data/variables.

```lua
local a = 1
print(a) -- Outputs 1

a = "Hello"
print(a) -- Outputs "Hello"

-- Even functions implementations can be changed at runtime
local function add(x, y)
  return x + y
end
print(add(1, 2)) -- Outputs 3

local function add(x, y)
  return x - y
end
print(add(2, 1)) -- Outputs 1
```

### Annonymous functions Example

```lua
local square = function(x) return x * x end
print(square(4))  -- Outputs 16
```

### Functions have no-side effects Example

In LUA, functions can have side effects. This is because LUA does not enforce the use of pure functions.

```lua
a = 0 -- A is a table
local function add(x)
  -- global a is changed, i.e. side effect
  a = a + x
end

add(1)
print(a) -- Outputs 1
```

### Conclusion

From the examples above, we can conclude that LUA supports most of the characteristics that define a functional programming language. However, LUA does not support immutable data/variables and functions have side effects. This means that LUA is not a pure functional programming language, but it does support functional programming paradigms.

We could also say that out of the 7 characteristics that define a functional programming language, LUA supports 5 of them.

## Merge Sort Assignment

As part of the research assignment, a prototype needs to be built of the Merge Sort Problem in the most functional way. [Use this link to checkout the implementation of the merge sort algorithm without having to setup lua locally!](https://onecompiler.com/lua/42ukqu4s2) 

We have implemented the merge sort algorithm in a functional way, using: recursion, higher-order functions, and immutability (by only creating new variables instead of changing existing ones).

```lua
-- Merge Sort in a functional programming style (immutable data)

-- Split a list into two halves without mutating the original list
local function split(list)
    local mid = math.floor(#list / 2)
    
    -- Copy elements for the left and right halves into new tables
    local left = {}
    local right = {}
    
    -- Creating new lists to maintain immutability
    for i = 1, mid do
        left[#left + 1] = list[i]
    end
    for i = mid + 1, #list do
        right[#right + 1] = list[i]
    end
    
    return left, right
end

-- Merge two sorted lists immutably
local function merge(left, right)
    -- Base cases: If one list is empty, return the other (no mutation)
    if #left == 0 then return right end
    if #right == 0 then return left end

    -- Compare the heads of the lists and construct a new list without mutation
    if left[1] <= right[1] then
        -- Return a new list with the first element of `left` and the rest being merged recursively
        return {left[1], table.unpack(merge({table.unpack(left, 2)}, right))}
    else
        -- Return a new list with the first element of `right` and the rest being merged recursively
        return {right[1], table.unpack(merge(left, {table.unpack(right, 2)}))}
    end
end

-- Merge Sort function (fully immutable)
local function mergeSort(list)
    -- Base case: A single element or empty list is already sorted
    if #list <= 1 then return list end
    
    -- Split the list into two halves immutably
    local left, right = split(list)
    
    -- Recursively sort both halves and merge them
    return merge(mergeSort(left), mergeSort(right))
end

-- Example usage (no mutations of original list)
local unsortedList = {38, 27, 43, 3, 9, 82, 10}
local sortedList = mergeSort(unsortedList)

-- Print the sorted list
for _, v in ipairs(sortedList) do
    print(v)
end
```

## Conclusion

This concludes our research on functional programming in LUA. We have determined what it means for a programming language to be functional, and we have investigated how functional LUA is. We have found that LUA supports most of the characteristics that define a functional programming language, but it does not support immutable data/variables and functions have side effects. This means that LUA is not a pure functional programming language, but it does support over 70% of the functional programming paradigms.

## Sources

["All values in Lua are first-class values."](https://www.lua.org/manual/5.1/manual.html#2.2)

