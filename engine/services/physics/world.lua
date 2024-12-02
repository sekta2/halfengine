local lp = love.physics

return function(physics)
    local World = half.class.new("PhysWorld", "Object", true)

    function World:Init(gx, gy, sleep)
        self.classes = {}

        local world = lp.newWorld(gx, gy, sleep)

        world:setContactFilter(function(fixt1, fixt2)
            local cc1 = fixt1:getUserData()
            local cc2 = fixt2:getUserData()

            cc1 = cc1.GetCollisionClass and cc1:GetCollisionClass() or "default"
            cc2 = cc2.GetCollisionClass and cc2:GetCollisionClass() or "default"

            return self:IsClassCanCollide(cc1, cc2)
        end)

        self:SetBox2D(world)

        self:AddCollisionClass("default")
    end

    function World:OnDestroy()
        self:GetBox2D():destroy()
    end

    --[[------------------------]]--

    half.util.set_get_function(World, "_box2d", "Box2D")

    function World:addCollisionClass(name, data)
        data = data or {}

        data.ignore = data.ignore or {}

        self.classes[name] = data
    end

    function World:removeCollisionClass(name)
        self.classes[name] = nil
    end

    function World:IsClassCanCollide(name1, name2)
        local cl1, cl2 = self.classes[name1], self.classes[name2]

        return not (cl1.ignore[name2] or cl2.ignore[name1])
    end

    --[[------------------------]]--

    function World:update(dt)
        self._box2d:update(dt)
    end
end