## FAQ

## Q: How to change game settings?
A: In the `game/config.lua` file there are settings of the game name, its abbreviation and window settings, also there you can change the name of the starting scene, and don't forget to rename the name of the scene script to `game/scenes`.

## Q: I want to create a player, where and how do I create him?
A: To create **Entities**/entities, create a script at the path `game/entities/`, call it `player.lua`, in it write this code:

```lua
local lg = love.graphics

-- Move - a small service that simplifies the work with the player control.
local move = half.load_service("move")

function ENT:Init()
    -- Create a physics object
    self:CreatePhysics("Circle", "dynamic", 15)
end

local speed = 150

function ENT:Update(dt)
    -- Get the direction and multiply it by the speed
    local dir = move.GetDirectionWASD() * speed

    -- Get the physical object and give it a linear velocity.
    local phys = self:GetPhysicsBody()
    phys:setLinearVelocity(dir.x, dir.y)
end

function ENT:Draw()
    -- Draw a circle
    lg.circle("fill", 0, 0, 0, 15)
end
```

Don't forget that you still need to create a player in the scene.

```lua
function SCENE:CustomInit()
    local player = self:AddEntity("player")
    player:SetPos(100, 100)
end
```