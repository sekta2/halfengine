return function(sceneManager)
    local SceneClass = half.class.new("Scene", "Object", true)

    function SceneClass:Init()
        self:SetGOScene(half.class.create("GOScene", self))

        self:CustomInit()
    end

    --[[------------------------]]--

    half.util.set_get_function(SceneClass, "_goscene", "GOScene")

    function SceneClass:update(dt)
        local goscene = self:GetGOScene()

        goscene:Update(dt)
        self:Update(dt)
    end

    function SceneClass:draw()
        local goscene = self:GetGOScene()

        goscene:Draw()
        self:Draw()
    end

    function SceneClass:keypressed(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnKeyboardPressed", ...)

        self:KeyPressed(...)
    end

    function SceneClass:keyreleased(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnKeyboardReleased", ...)
    end

    function SceneClass:mousemoved(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnMouseMoved", ...)
    end

    function SceneClass:mousepressed(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnMousePressed", ...)
    end

    function SceneClass:mousereleased(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnMouseReleased", ...)
    end

    function SceneClass:wheelmoved(...)
        local goscene = self:GetGOScene()
        goscene:Event("OnMouseWheelMoved", ...)
    end

    --[[------------------------]]--

    function SceneClass:AddEntity(ent_class)
        return self:GetGOScene():Add(ent_class)
    end

    --[[------------------------]]--

    function SceneClass:CustomInit()
    end

    function SceneClass:Update(dt)
    end

    function SceneClass:Draw()
    end

    function SceneClass:KeyPressed(...)
    end
end