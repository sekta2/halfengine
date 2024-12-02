local conf = half.get_config()

if conf.phys == "windfield" then
    local wf = require("engine.thirdparty.windfield")

    local shapes = {
        ["Rectangle"] = wf.World.newRectangleCollider,
        ["Circle"] = wf.World.newCircleCollider,
        ["Polygon"] = wf.World.newPolygonCollider
    }
    
    function wf.newBody(world, shapetype, ...)
        local shapefn = shapes[shapetype]

        if shapetype ~= "Polygon" then
            return shapefn(world, 0, 0, ...)
        end
    
        return shapefn(world, ...)
    end

    return wf
end

local PATH = ... .. "."

local lp = love.physics

--[[------------------------]]--

local physics = {}

function physics.newWorld(gx, gy, sleep)
    local world = half.class.create("PhysWorld")

    return world
end

local shapes = {
    ["Rectangle"] = lp.newRectangleShape,
    ["Circle"] = lp.newCircleShape,
    ["Polygon"] = lp.newPolygonShape
}

function physics.newBody(world, shapetype, ...)
    local shapefn = shapes[shapetype]

    local args = {...}

    if type(args[1]) == "table" then
        args = args[1]
    end

    local x, y = args[1], args[2]

    local body = lp.newBody(world._box2d, x, y, "dynamic")
    local shape = shapefn(...)
    local fixture = lp.newFixture(body, shape, 1)

    local pbody = half.class.create("PhysBody", body, shape, fixture)

    return pbody
end

require(PATH .. "body")(physics)
require(PATH .. "world")(physics)

return physics