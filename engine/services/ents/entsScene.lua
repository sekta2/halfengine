return function(middleclass, entities)
    local entScene = middleclass("EntitiesScene")

    entScene.list = {}
    entScene.list_uid = 0

    function entScene:Create()
        local new = self:allocate()

        return new
    end

    function entScene:Add(name)
        local ent = entities.make_entity(name, self)

        if ent then
            self.list_uid = self.list_uid + 1
            local uid = self.list_uid

            self.list[uid] = ent
            ent:SetUID(uid)

            return ent
        end
    end

    function entScene:Remove(uid)
        local ent = self.list[uid]

        if ent then
            ent:RemoveInternal()
            self.list[uid] = nil
        end
    end

    function entScene:update(dt)
        for k, v in pairs(self.list) do
            v:update(dt)
        end
    end

    function entScene:draw()
        for k, v in pairs(self.list) do
            v:draw()
        end
    end

    return entScene
end