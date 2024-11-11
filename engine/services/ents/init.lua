local PATH = ... .. "."

--[[------------------------]]--

local middleclass = half.load_thirdparty("middleclass")

local ents = {
    cache = {}
}

ents.scene = require(PATH .. "entsScene")(middleclass, ents)
--ents.base = require(PATH .. "base")(middleclass)

function ents.load_element(name)
    local element = ents.cache[name]

    if element == nil then
        local success, fn = pcall(require, "game.entities." .. name)
        if not success then ents.cache[name] = false return false end
        
        local elm = middleclass(name, ents.base)

        fn(elm)

        element = elm
        ui.cache[name] = element
    end

    return element
end

function ents.make_element(name, uiScene)
    local element = ents.load_element(name)

    if element then
        element = element:allocate()
        if uiScene then element:SetScene(uiScene) end

        element:init()

        return element
    end
end

return ents