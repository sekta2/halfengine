local PATH = ... .. "."

--[[------------------------]]--

local gameObject = half.load_service("gameObject")

local sceneManager = {
    list = {},

    link = nil,
    scene = nil
}

--- Loads scene class
---@param name string
---@return table or boolean
function sceneManager.load_scene(name)
    local scene = sceneManager.list[name]

    if scene == nil then
        local _scn = half.class.new(name, "Scene", false)

        _G.SCENE = _scn

        local success, err = pcall(require, "game.scenes." .. name)
        if not success then
            print([[!!! Error when loading a scene "]] .. name .. [[": ]] .. err)

            _G.SCENE = nil

            setmetatable(_scn, {__mode = "v"})
            collectgarbage("collect")

            sceneManager.list[name] = false
            
            return false
        end

        _G.SCENE = nil

        scene = _scn
        sceneManager.list[name] = _scn
    end

    return scene
end

--- Set scene
---@param name string
---@return boolean
function sceneManager.set_scene(name)
    local scene = sceneManager.load_scene(name)
    if not scene then return false end

    local link = sceneManager.link
    if link then
        sceneManager.link = nil
        link:Destroy()
    end

    local object_scene = scene:Create()

    sceneManager.scene = name
    sceneManager.link = object_scene

    return true
end

--- Run event on scene
---@param evname string
function sceneManager.event(evname, ...)
    local link = sceneManager.link
    if not link then return end

    local fn = link[evname]
    if not fn then return end

    fn(link, ...)
end

require(PATH .. "scene")(sceneManager)

return sceneManager