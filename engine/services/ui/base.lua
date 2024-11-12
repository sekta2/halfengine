return function(middleclass)

local lg = love.graphics
local lm = love.mouse

local draw = half.load_service("draw")

local BASE = middleclass("BaseElement")

BASE.x = 0
BASE.y = 0

BASE.w = 100
BASE.h = 25

BASE.scene = nil

function BASE:init()
end

function BASE:update()
end

function BASE:draw()
end

set_get_function(BASE, "scene", "Scene")
set_get_function(BASE, "_uid", "UID")

set_get_function(BASE, "x", "X")
set_get_function(BASE, "y", "Y")

function BASE:SetPos(x, y)
    self.x = x
    self.y = y
end

function BASE:GetPos()
    local x = self.x
    local y = self.y

    return x, y
end

set_get_function(BASE, "w", "Width")
set_get_function(BASE, "h", "Height")

function BASE:SetSize(w, h)
    self.w = w
    self.h = h
end

function BASE:GetSize()
    return self.w, self.h
end

function BASE:Center()
    local w, h = lg.getDimensions()
    local pw, ph = self:GetSize()

    self:SetPos((w * 0.5) - (pw * 0.5), (h * 0.5) - (ph * 0.5))
end

function BASE:IsHoveredInternal()
    local mx, my = lm.getPosition()

    local x, y = self:GetPos()
    local w, h = self:GetSize()

    return (mx >= x and my >= y) and (mx <= x + w and my <= y + h)
end

function BASE:IsHovered()
    local hover_obj = self:GetScene()
    hover_obj = hover_obj and hover_obj.element_hovered or nil

    return hover_obj == self
end

function BASE:GetIndex()
    local scene = self:GetScene()
    if not scene then return 1 end

    local elements = scene._elements
    local uid

    for i = 1, #elements do
        local element = elements[i]
        if element == self then
            uid = i
            break
        end
    end

    return uid
end

function BASE:MoveToFront()
    local scene = self:GetScene()
    if not scene then return end

    local elements = scene._elements
    local uid = self:GetIndex()

    for i = 1, #elements do
        local element = elements[i]
        if element == self then
            uid = i
            break
        end
    end

    if uid == 1 then return end

    table.remove(elements, uid)
    table.insert(elements, 1, self)
end

function BASE:MoveToBack()
    local scene = self:GetScene()
    if not scene then return end

    local elements = scene._elements
    local uid = self:GetIndex()

    for i = 1, #elements do
        local element = elements[i]
        if element == self then
            uid = i
            break
        end
    end

    if uid == #elements then return end

    table.remove(elements, uid)
    table.insert(elements, self)
end

--[[----------------------------]]--

set_get_function(BASE, "font", "Font")

function BASE:BuildFont(file_name, size, is_engine_font)
    self:SetFont(draw.font(file_name, size, is_engine_font))
end

--[[----------------------------]]--

function BASE:OnMouseMoved(x, y, dx, dy)
end

function BASE:OnPressed(x, y, button)
end

function BASE:OnReleased(x, y, button)
end

function BASE:OnWheelMoved(x, y)
end

return BASE

end