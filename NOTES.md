Imperitive programming wil be compared to functional programming
Its much like a cooking recipe, order matters!

In functional programming variables are immutable, meaning they cannot be changed once they are assigned a value.

---
List recursion

a list is defined as being empty or not empty

a non-empty list is considered to be made of the first element and the rest of the list

this is notated as x::xs
lets take a list [1,2,3,4]
1 is the first element and [2,3,4] is the rest of the list
we write this as 1::[2,3,4]
to write it even more complete, we write it as 1::2::3::4::[]

U can use ( ... ) replacing the ... with any binary operator you turn it into a function with 2 arguments.