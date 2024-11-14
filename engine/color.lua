local lg = love.graphics

--[[------------------------]]--

local COLOR = {}
COLOR.__index = COLOR

function COLOR:Set(r, g, b, a)
    r = r or self.r
    g = g or self.g
    b = b or self.b
    b = b or self.a

    self.r = r
    self.g = g
    self.b = b
    self.a = a
end

function COLOR:Get()
    return self.r, self.g, self.b, self.a
end

local div = 1 / 255

function COLOR:Make()
    local r, g, b, a = self:Get()
    lg.setColor(r * div, g * div, b * div, a * div)
end

function COLOR:Lerp(frac, r, g, b, a)
    if type(r) == "table" then
        r, g, b, a = r:Get()
    end

    self.r = math.Lerp(frac, self.r, r)
    self.g = math.Lerp(frac, self.g, g)
    self.b = math.Lerp(frac, self.b, b)
    self.a = math.Lerp(frac, self.a, a)
end

function COLOR:Clone()
    return Color(self.r, self.g, self.b, self.a)
end

--[[------------------------]]--

function Color(r, g, b, a)
    local clr = {
        r = r,
        g = g,
        b = b,
        a = a or 255
    }

    setmetatable(clr, COLOR)

    return clr
end

color_white = Color(255, 255, 255, 255)
color_black = Color(0, 0, 0, 255)