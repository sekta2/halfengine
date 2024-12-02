return function(physics)
    local Body = half.class.new("PhysBody", "Object", true)

    function Body:Init(body, shape, fixture)
        for k, v in pairs(body.__index) do 
            if k ~= '__gc' and k ~= '__eq' and k ~= '__index' and k ~= '__tostring' and k ~= 'destroy' and k ~= 'type' and k ~= 'typeOf' then
                self[k] = function(self, ...)
                    return v(body, ...)
                end
            end
        end

        body:setLinearDamping(1.5)
        body:setAngularDamping(1.5)

        self:SetBody(body)
        self:SetShape(shape)
        self:SetFixture(fixture)

        fixture:setUserData(self)

        self:SetCollisionClass("default")
    end

    function Body:OnDestroy()
        self._body:destroy()
    end

    --[[------------------------]]--

    half.util.set_get_function(Body, "_object", "Object")

    half.util.set_get_function(Body, "_body", "Body")
    half.util.set_get_function(Body, "_shape", "Shape")
    half.util.set_get_function(Body, "_fixture", "Fixture")

    half.util.set_get_function(Body, "_col_class", "CollisionClass")

    Body.destroy = Body.Destroy

    Body.setObject = Body.SetObject
    Body.getObject = Body.GetObject

    function Body:GetContactData(col_class)

    end
end