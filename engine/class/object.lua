return function(classlib)
    local Object = classlib.new("Object", _, true)

    function Object:CreateWithPreInit(prefn, ...)
        local obj = self:allocate()
        prefn(obj, ...)
        obj:Init(...)
    
        return obj
    end

    function Object:Create(...)
        local obj = self:allocate()
        obj:Init(...)
    
        return obj
    end
    
    function Object:Destroy()
        self:OnDestroy()
    
        setmetatable(self, {__mode = "v"})
        collectgarbage("collect")
    end
    
    --[[------------------------]]--
    
    function Object:Init()
    end
    
    function Object:OnDestroy()
    end
end