return function(CHECKBOX)

local lg = love.graphics
local draw = half.load_service("draw")
local asset = half.load_service("asset")

local bg = {
    off = Color(38, 13, 13),
    on = Color(13, 38, 13)
}

local front = {
    off = Color(56, 19, 19),
    on = Color(19, 56, 19)
}

local icon = {
    off = asset.load_sprite("checkbox/off.png", true),
    on = asset.load_sprite("checkbox/on.png", true)
}

local icon_clr = {
    off = Color(191, 64, 64),
    on = Color(64, 191, 64)
}

local icon_size = 32 * 0.5

--[[----------------------------]]--

CHECKBOX.text = "Button"

set_get_function(CHECKBOX, "text", "Text")
set_get_function(CHECKBOX, "value", "Value")

function CHECKBOX:init()
    self:BuildFont("default", 20)

    self.bg_clr = bg.off:Clone()
    self.front_clr = front.off:Clone()
    self.icon_clr = icon_clr.off:Clone()
end

local frac = 0.25

function CHECKBOX:update(dt)
    if self:GetValue() then
        self.bg_clr:Lerp(frac, bg.on)
        self.front_clr:Lerp(frac, front.on)
        self.icon_clr:Lerp(frac, icon_clr.on)

        return
    end

    self.bg_clr:Lerp(frac, bg.off)
    self.front_clr:Lerp(frac, front.off)
    self.icon_clr:Lerp(frac, icon_clr.off)
end

function CHECKBOX:draw(w, h)
    local x, y = 5, h * 0.5

    lg.setColor(1, 1, 1)
    draw.text(self:GetText(), self:GetFont(), 5 + 24 + 5, h * 0.5, 1, 2, true)

    draw.set_color(self.bg_clr)
    lg.rectangle("fill", x, y - (24 * 0.5), 24, 24, 6)

    draw.set_color(self.front_clr)
    lg.rectangle("fill", x + 2, y - (20 * 0.5), 20, 20, 6)

    draw.set_color(self.icon_clr)
    draw.sprite(self.value and icon.on or icon.off, x + 2, y - (20 * 0.5), 20, 20)
end

function CHECKBOX:OnPressed()
    self:SetValue(not self:GetValue())
end

--[[----------------------------]]--

end