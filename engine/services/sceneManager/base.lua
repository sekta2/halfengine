return function(sceneManager, middleclass)
    local ents = half.load_service("ents")
    local ui = half.load_service("ui")

    local BASE = middleclass("BaseScene")

    function BASE:new_scene(fn, name)
        local SCENE_OBJ = middleclass(name, self)

        fn(SCENE_OBJ)

        return SCENE_OBJ
    end

    function BASE:new_instance()
        local inst = self:allocate()
        inst:init()
        
        return inst
    end

    function BASE:init()
        self.ents_scene = ents.scene:Create()
        self.ui_scene = ui.scene:Create()

        self:Init()
    end

    function BASE:update(dt)
        self:BeforeUpdate(dt)
        
        self.ents_scene:update(dt)
        self.ui_scene:update(dt)

        self:AfterUpdate(dt)
    end

    function BASE:draw()
        self:BeforeDraw()

        self.ents_scene:draw()
        self.ui_scene:draw()

        self:AfterDraw()
    end

    function BASE:mousemoved(x, y, dx, dy, istouch)
        self.ui_scene:mousemoved(x, y, dx, dy, istouch)
    end

    function BASE:mousepressed(x, y, button, istouch, presses)
        self.ui_scene:mousepressed(x, y, button, istouch, presses)
    end

    --[[------------------------]]--

    function BASE:Init()
    end

    function BASE:BeforeUpdate(dt)
    end

    function BASE:AfterUpdate(dt)
    end

    function BASE:BeforeDraw()
    end

    function BASE:AfterDraw()
    end

    --[[------------------------]]--

    function BASE:AddEntity(name)
        return self.ents_scene:Add(name)
    end

    function BASE:AddElement(name)
        return self.ui_scene:Add(name)
    end

    return BASE
end