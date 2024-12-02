local lg = love.graphics

return function(gameObject)
    local GOScene = half.class.new("GOScene", "Object", true)

    function GOScene:Init(scene)
        self:SetScene(scene)

        self.list = {}
        self.uid = 0

        self:SetPhysics(physics.newWorld(0, 0, true))
    end

    --[[------------------------]]--

    half.util.set_get_function(GOScene, "_scene", "Scene")
    half.util.set_get_function(GOScene, "_phys", "Physics")

    function GOScene:Add(entclass)
        local entity = gameObject.create_entity(entclass, self)
        if not entity then return end

        self.uid = self.uid + 1
        local uid = self.uid

        entity:SetUID(uid)

        self.list[uid] = entity

        return entity
    end

    function GOScene:Remove(uid_or_ent)
        local ent
        local uid = uid_or_ent

        if type(uid_or_ent) == "table" then
            ent = uid_or_ent
            uid = uid_or_ent:GetUID()
        end

        ent = ent or self.list[uid]
        ent:Destroy()

        self.list[uid] = nil
    end

    function GOScene:AddCollisionClass(name, data)
        local phys = self:GetPhysics()

        if phys then
            phys:addCollisionClass(name, data)
        end
    end

    function GOScene:RemoveCollisionClass(name)
        local phys = self:GetPhysics()

        if phys then
            phys:removeCollisionClass(name)
        end
    end

    function GOScene:Event(evname, ...)
        for k, v in pairs(self.list) do
            local ev_fn = v[evname]
            if not ev_fn then goto skip end

            ev_fn(v, ...)

            ::skip::
        end
    end

    function GOScene:Update(dt)
        local phys = self:GetPhysics()

        if phys then
            phys:update(dt)
        end

        for k, v in pairs(self.list) do
            local ev_fn = v.Update
            if not ev_fn then goto skip end

            ev_fn(v, dt)

            ::skip::
        end
    end

    function GOScene:Draw()
        for k, v in pairs(self.list) do
            local ev_fn = v.Draw
            if not ev_fn then goto skip end

            lg.translate(v:GetPos())
            ev_fn(v)
            lg.origin()

            ::skip::
        end


        --[[
        local bodies = self._phys:getBodies()

        for _, body in pairs(bodies) do
            local fixtures = body:getFixtures()
            for _, fixture in ipairs(fixtures) do
                if fixture:getShape():type() == 'PolygonShape' then
                    love.graphics.polygon('line', body:getWorldPoints(fixture:getShape():getPoints()))
                elseif fixture:getShape():type() == 'EdgeShape' or fixture:getShape():type() == 'ChainShape' then
                    local points = {body:getWorldPoints(fixture:getShape():getPoints())}
                    for i = 1, #points, 2 do
                        if i < #points-2 then love.graphics.line(points[i], points[i+1], points[i+2], points[i+3]) end
                    end
                elseif fixture:getShape():type() == 'CircleShape' then
                    local body_x, body_y = body:getPosition()
                    local shape_x, shape_y = fixture:getShape():getPoint()
                    local r = fixture:getShape():getRadius()
                    love.graphics.circle('line', body_x + shape_x, body_y + shape_y, r, 360)
                end
            end
        end
        ]]
    end
end