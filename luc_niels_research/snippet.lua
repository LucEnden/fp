function add(x, y)
  return x + y
end

local a = add
print(a(1,2))

-------------

local square = function(x) return x * x end
print(square(4))  -- Outputs 16

-------------

function addWithFunction(f, x, y)
  return f(x, y)
end

print(addWithFunction(a, 2, 3)) -- Outputs 5
