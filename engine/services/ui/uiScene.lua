return function(middleclass, ui)
    local lg = love.graphics

    local uiScene = middleclass("InterfaceScene")

    uiScene.list = {}
    uiScene.list_uid = 0

    uiScene.element_hovered = nil

    function uiScene:Create()
        local new = self:allocate()

        return new
    end

    function uiScene:Add(name)
        local element = ui.make_element(name, self)

        if element then
            self.list_uid = self.list_uid + 1
            local uid = self.list_uid

            self.list[uid] = element
            element:SetUID(uid)

            return element
        end
    end

    function uiScene:Remove(uid)
        
    end

    --[[----------------------------]]--

    function uiScene:update(dt)
        local list = self.list

        for i = #list, 1, -1 do
            local element = list[i]
            element:update(dt)
        end
    end

    function uiScene:draw()
        local list = self.list

        for i = #list, 1, -1 do
            local element = list[i]
            local x, y = element:GetPos()
            local w, h = element:GetSize()

            lg.translate(x, y)
                element:draw(w, h)
            lg.origin()
        end
    end

    function uiScene:mousemoved(x, y, w, h)
        local list = self.list
        
        self.element_hovered = nil
    
        for i = 1, #list do
            local element = list[i]
            local hovered = element:IsHoveredInternal()
    
            if hovered then

                self.element_hovered = element
                break
            end
        end
    end
    
    function uiScene:mousepressed(...)
        local hovered = self.element_hovered
    
        if hovered then
            hovered:OnPressed(...)
        end
    end

    return uiScene
end