return function(gameObject)
    local Entity = half.class.new("Entity", "Object", true)

    function Entity:OnDestroy()
        local phys = self:GetPhysicsBody()

        if phys then
            phys:destroy()
        end
    end

    --[[------------------------]]--

    Entity.x = 0
    Entity.y = 0

    half.util.set_get_function(Entity, "x", "X")
    half.util.set_get_function(Entity, "y", "Y")

    function Entity:SetPos(x, y)
        local phys = self:GetPhysicsBody()

        if phys then
            phys:setPosition(x, y)
        end

        self.x = x
        self.y = y
    end

    function Entity:GetPos()
        local phys = self:GetPhysicsBody()

        if phys then
            return phys:getPosition()
        end

        return self.x, self.y
    end

    function Entity:GetVector()
        local phys = self:GetPhysicsBody()

        if phys then
            local x, y = phys:getPosition()
            return vector(x, y)
        end

        return vector(self.x, self.y)
    end

    half.util.set_get_function(Entity, "_scene", "Scene")
    half.util.set_get_function(Entity, "_goscene", "GOScene")
    half.util.set_get_function(Entity, "_uid", "UID")
    half.util.set_get_function(Entity, "_phys", "PhysicsBody")

    function Entity:CreatePhysics(shapetype, type, ...)
        local world = self:GetGOScene():GetPhysics()

        local x, y = self:GetPos()

        local body = physics.newBody(world, shapetype, ...)
        body:setType(type or "dynamic")
        body:setPosition(x, y)

        body:setObject(self)

        self:SetPhysicsBody(body)

        return body
    end

    function Entity:Remove()
        local goscene = self:GetGOScene()
        goscene:Remove(self)
    end

    --[[------------------------]]--

    function Entity:OnMouseMoved(x, y, dx, dy, isTouch)
    end

    function Entity:OnMousePressed(x, y, button, isTouch, presses)
    end

    function Entity:OnMouseReleased(x, y, button, isTouch, presses)
    end

    function Entity:OnMouseWheelMoved(x, y)
    end

    function Entity:OnKeyboardPressed(key, scancode, isRepeat)
    end
    
    function Entity:OnKeyboardReleased(key, scancode)
    end
end