local lg = love.graphics

--[[------------------------]]--

local asset = {
    list = {},
    not_found = lg.newImage("engine/assets/sprites/notfound.png")
}

function asset.get_notfound()
    return asset.not_found
end

function asset.load_sprite(path, is_engine)
    local real_path = (is_engine and "engine" or "game") .. "/assets/sprites/" .. path

    local sprite = asset.list[real_path]
    
    if not sprite then
        local success, res = pcall(lg.newImage, real_path)
        if not success then asset.list[real_path] = asset.not_found return asset.not_found end

        sprite = res
        asset.list[real_path] = res
    end

    return sprite
end

return asset