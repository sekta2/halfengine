local lm = love.mouse
local lt = love.touch
local los = love.system

--[[------------------------]]--

local cursor = {}

function cursor.for_pc()
    cursor.getPosition = lm.getPosition
    cursor.getX = lm.getX
    cursor.getY = lm.getY
end

function cursor.for_phone()
    cursor.getPosition = lt.getPosition
    cursor.getX = function() return select(1, lt.getPosition()) end
    cursor.getY = function() return select(2, lt.getPosition()) end
end

local os_actions = {
    ["Windows"] = cursor.for_pc,
    ["OS X"] = cursor.for_pc,
    ["Linux"] = cursor.for_pc,

    ["Android"] = cursor.for_phone,
    ["iOS"] = cursor.for_phone
}

function cursor.load()
    local os_type = love._os

    local fn = os_actions[os_type] or cursor.for_pc
    fn()
end

cursor.load()

return cursor