local PATH = ... .. "."

--[[------------------------]]--

local middleclass = half.load_thirdparty("middleclass")

local ui = {
    cache = {},
    list = {}
}

ui.scene = require(PATH .. "uiScene")(middleclass, ui)
ui.base = require(PATH .. "base")(middleclass)

function ui.load_element(name)
    if name == "init" or name == "base" then return end

    local element = ui.cache[name]

    if element == nil then
        local success, fn, base = pcall(require, PATH .. name)
        if not success then ui.cache[name] = false return false end

        local elm = middleclass(name, base and ui.load_element(base) or ui.base)
        fn(elm)

        element = elm
        ui.cache[name] = element
    end

    if element == nil then
        local success, fn = pcall(require, "game.elements." .. name)
        if not success then ui.cache[name] = false return false end
        
        local elm = middleclass(name, ui.base)

        fn(elm)

        element = elm
        ui.cache[name] = element
    end

    return element
end

function ui.make_element(name, uiScene)
    local element = ui.load_element(name)

    if element then
        element = element:allocate()
        if uiScene then element:SetScene(uiScene) end

        element:init()

        return element
    end
end

return ui