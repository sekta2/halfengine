# 🌎 Global > half.utilization

Some auxiliary functions

## 🛠️ Functions

### half.util.get_function
Creates a Meta-Method inside a Meta-Table to get the value of a variable from the Meta-Table.

| Argument | Type | Description |
| ------------- | ------------- | ------------- |
| meta | meta table | meta table in which to create a Meta-Method |
| key | string | variable name |
| name | string | (Get) + function name |

### Example
```lua
-- Create a GetName method function in the Player Meta-Table that will return the value of the name variable.
half.util.set_get_function(player, "name", "Name")
```

### half.util.set_function
Creates a Meta-Method within the Meta-Table to set the value of a variable within the Meta-Table.

| Argument | Type | Description |
| ------------- | ------------- | ------------- |
| meta | meta table | meta table in which to create a Meta-Method |
| key | string | variable name |
| name | string | (Set) + function name |

### Example
```lua
-- Will create a SetCooldown method function in the Player Meta-Table that will set the value of the cooldown variable
half.util.set_get_function(player, "cooldown", "Cooldown")
```

### half.util.set_get_function
Creates a Meta-Method inside the Meta-Table to set and get the value of a variable inside/from the Meta-Table.

Simply put, it creates both "Set" and "Get" methods in the Meta-Table at once.

| Argument | Type | Description |
| ------------- | ------------- | ------------- |
| meta | meta table | meta table in which to create the Meta-Methods |
| key | string | variable name |
| name | string | (Set) & (Get) + function name |

### Example
```lua
-- Will create a SetHealth and GetHealth method function in the Player Meta-Table, see functions above for applications
half.util.set_get_function(player, "health", "Health")
```