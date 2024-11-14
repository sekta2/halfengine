local lg = love.graphics

--[[------------------------]]--

local bake = {
    cache = {}
}

function bake.make(func, w, h)
    local canv = lg.newCanvas(w, h)

    lg.setCanvas(canv)
    lg.clear()
    func(w, h)
    lg.setCanvas()

    return canv
end

function bake.make_cached(name, func, w, h)
    local canv = bake.cache[name]

    if not canv then
        canv = bake.make(func, w, h)
        bake.cache[name] = canv
    end

    return canv
end

return bake