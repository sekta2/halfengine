return function(BUTTON)

local lg = love.graphics
local draw = half.load_service("draw")

--[[----------------------------]]--

BUTTON.text = "Button"

set_get_function(BUTTON, "text", "Text")

function BUTTON:init()
    self:BuildFont("default", 20)
end

function BUTTON:draw(w, h)
    if not self:IsHovered() then
        lg.setColor(0.1, 0.1, 0.1)
        lg.rectangle("fill", 0, 0, w, h, 6)

        lg.setColor(0.14, 0.14, 0.14)
        lg.rectangle("fill", 2, 2, w - 4, h - 4, 6)

        lg.setColor(1, 1, 1)
        draw.text(self:GetText(), self:GetFont(), w * 0.5, h * 0.5, 2, 2, true)

        return
    end

    lg.setColor(0.85, 0.85, 0.85)
    lg.rectangle("fill", 0, 0, w, h, 6)
    
    lg.setColor(0.14, 0.14, 0.14)
    draw.text(self:GetText(), self:GetFont(), w * 0.5, h * 0.5, 2, 2, true)
end

--[[----------------------------]]--

end