-- Function to demonstrate currying in Lua
function curry(f)
    local function helper(arg1)
        return function(arg2)
            return f(arg1, arg2)
        end
    end
    return helper
end

-- Example usage
local function add(x, y)
    return x + y
end

local curried_add = curry(add)
local add_five = curried_add(5)
print(add_five(10))  -- Output: 15