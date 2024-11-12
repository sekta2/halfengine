local lg = love.graphics

--[[------------------------]]--

local draw = {
    flist = {}
}

local div = 1 / 800
local div2 = 1 / 600

function draw.screen_scale(w)
    return (w * div) * lg.getWidth()
end

function draw.screen_scaleh(h)
    return (h * div2) * lg.getHeight()
end

function draw.create_font(name, file_name, size, is_engine_font)
    if file_name == "default" and is_engine_font == nil then is_engine_font = true end
    is_engine_font = is_engine_font ~= nil and is_engine_font or false

    local path = "game/fonts/"

    if is_engine_font then
        path = "engine/fonts/"
    end

    path = path .. file_name .. ".ttf"
    
    local font = lg.newFont(path, size)
    draw.flist[name] = font
    
    return font
end

function draw.get_font(name)
    return draw.flist[name]
end

function draw.font(file_name, size, is_engine_font)
    local name = file_name .. size
    local font = draw.flist[name]

    if not font then
        font = draw.create_font(name, file_name, size, is_engine_font)
    end
    
    return font
end

local align_to_type = {
    [1] = "left",
    [2] = "center",
    [3] = "right"
}

function draw.text(text, font, x, y, alignx, aligny, need_floored)
    font = type(font) == "string" and draw.get_font(font) or font
    font = font or lg.getFont()

    local w_align = align_to_type[alignx]

    local tw, th = font:getWidth(text), font:getHeight(text)
    local tx, ty = x, y
    
    tx = alignx == 2 and tx - tw * 0.5 or alignx == 3 and tx - tw
    ty = aligny == 2 and ty - th * 0.5 or aligny == 3 and ty - th

    if need_floored then
        tx = math.floor(tx)
        ty = math.floor(ty)
    end

    lg.setFont(font)
    lg.printf(text, tx, ty, tw, w_align)
end

return draw