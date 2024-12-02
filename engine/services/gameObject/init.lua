local PATH = ... .. "."

--[[------------------------]]--

local gameObject = {
    list = {}
}

function gameObject.load_entity(name)
    local entity = gameObject.list[name]

    if entity == nil then
        local _ent = half.class.new(name, "Entity", false)

        _G.ENT = _ent

        local success, err = pcall(require, "game.entities." .. name)
        if not success then
            print([[!!! Error when loading an entity "]] .. name .. [[": ]] .. err)
            _G.ENT = nil

            setmetatable(_ent, {__mode = "v"})
            collectgarbage("collect")

            gameObject.list[name] = false
            
            return false
        end

        _G.ENT = nil

        entity = _ent
        gameObject.list[name] = _ent
    end

    return entity
end

function gameObject.create_entity(name, goscene, scene, uid)
    local class = gameObject.load_entity(name)
    if not class then return false end

    local entity = class:CreateWithPreInit(function(self)
        if goscene then
            self:SetGOScene(goscene)
            self:SetScene(scene or goscene:GetScene())
        end

        if uid then
            self:SetUID(uid)
        end
    end)

    return entity
end

require(PATH .. "entity")(gameObject)
require(PATH .. "scene")(gameObject)

return gameObject