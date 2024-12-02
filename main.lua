if HALF_ERROR_OCCURED then
    love.event.quit()
    
    return
end

--[[------------------------]]--

local cfg = half.get_config()
local sceneManager = half.load_service("sceneManager")

function love.load(...)
    half.load()

    local main_scn = cfg.scene
    if not main_scn then love.event.quit() return end

    local success = sceneManager.set_scene(main_scn)
    if not success then love.event.quit() return end
end

function love.update(dt)
    sceneManager.event("update", dt)
end

function love.draw()
    sceneManager.event("draw")
end

local events = {
    "keypressed",
    "keyreleased",

    "mousemoved",
    "mousepressed",
    "mousereleased",
    "wheelmoved"
}

for i = 1, #events do
    local ev = events[i]

    love[ev] = function(...)
        sceneManager.event(ev, ...)
    end
end