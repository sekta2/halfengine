local PATH = ... .. "."

--[[------------------------]]--

local middleclass = half.load_thirdparty("middleclass")

local sceneManager = {
    scenes = {},
    scene = "",
    scene_link = nil
}

sceneManager.base = require(PATH .. "base")(sceneManager, middleclass)

function sceneManager.load_scene(name)
    local scene = sceneManager.scenes[name]

    if scene == nil then
        local success, fn = pcall(require, "game.scenes." .. name)
        if not success then
            sceneManager.scenes[name] = false
            print([[{sceneManager} Error when loading a scene: "]] .. name .. [["]])
        
            return false
        end

        scene = sceneManager.base:new_scene(fn, name)
        sceneManager.scenes[name] = scene
    end

    return scene
end

function sceneManager.set_scene(name)
    local scene = sceneManager.load_scene(name)

    if scene then
        local current = sceneManager.scene_link

        if current then
            setmetatable(current, {__mode = "v"})
            collectgarbage("collect")
        end

        ---

        local instance = scene:new_instance()

        sceneManager.scene = name
        sceneManager.scene_link = instance
    end
end

--[[------------------------]]--

for i = 1, #LOVE_EVENTS do
    local ev = LOVE_EVENTS[i]

    sceneManager[ev] = function(...)
        local link = sceneManager.scene_link

        if link and link[ev] then
            local fn = link[ev]

            return fn(link, ...)
        end
    end
end

return sceneManager