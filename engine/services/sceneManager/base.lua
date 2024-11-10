return function(sceneManager, middleclass)
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
    end

    return BASE
end