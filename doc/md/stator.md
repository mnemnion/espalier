# Stator


  Having gotten about as far as I can with mere string concatenation, it's 
time to put together a proper set of operations for transducing across a
Node. 


This isn't a great place to put theory, let's build the structure and 
flesh out from there.

```lua
local Stator = setmetatable({}, {__index = Stator})
```
```lua
function call(stator)
  return setmetatable({}, {__index = stator, __call = call })
end
```
```lua
return setmetatable(Stator, {__call = call})
```