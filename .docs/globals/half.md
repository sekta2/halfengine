# 🌎 Global > half

Engine library

## 📚 Sub-libraries
- [half.util](half.class.md)
- [half.class](half.class.md)

## 🛠️ Functions

### half.get_config
Returns the game config

| Returns | Description |
| ------------------ | ------------- |
| table or boolean | config or false if load failed |

### half.load_service
Loads and returns the service

Services can be found in [README.md](../README.md).

| Argument | Type | Description |
| ------------- | ------------- | ------------- |
| service_name | string | service name |

| Returns | Description |
| ------------------ | ------------- |
| table or boolean | Service or false if an error occurred on upload |

### Example
```lua
-- Loads and returns a scene manager
local sceneManager = half.load_service("sceneManager")
```

### half.load

> [!WARNING]  
> This function is system specific, meaning that only the engine implies the use of this function.

Since 0.5rfs it loads physics in `main.lua`.