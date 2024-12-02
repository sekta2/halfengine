local lg = love.graphics

--[[------------------------]]--

local asset = {
    cache = {}
}

function asset.id(path, type)
    return type .. ":" .. path
end

function asset.load_sprite(path)
    local id = asset.id(path, "sprite")

    local sprite = asset.cache[id]

    if sprite == nil then
        local success, img = pcall(lg.newImage, "game/asset/sprite/" .. path)
        if not success then
            print([[!!! Error when loading an asset "]] .. path .. [[": ]] .. img)
            asset.cache[id] = false

            return false
        end

        sprite = img
        asset.cache[id] = img
    end

    return sprite
end

return asset