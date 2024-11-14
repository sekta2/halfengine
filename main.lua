if HALF_ERROR_OCCURED then
    crash_handler(HALF_ERROR)
    return
end

local lf = love.filesystem

local sceneManager = half.load_service("sceneManager")

local gameinfo = half.get_game_info()

-- Main

local flags = {
    ["+codeupdate"] = function()
        function internal_code_update()
            local info = lf.getInfo("main.lua")

            if info.modtime ~= icu_modtime then
                local success, err = pcall(lf.load, "main.lua")

                if success then
                    lf.load("main.lua")()
                    love.run()
                else
                    print(err)
                end

                icu_modtime = info.modtime
            end
        end
    end,

    ["+debug"] = function()
        HALF_DEBUG = true
    end
}

function love.load(...)
    local args = {...}
    local fargs = args[1]

    for i = 1, #fargs do
        local arg = fargs[i]
        local fn = flags[arg]

        if fn then fn() end
    end

    local main_scene = gameinfo.scene or "main"
    if not sceneManager.load_scene(main_scene) then crash_handler("No main scene") return end

    half.main_load()

    sceneManager.set_scene(main_scene)
end

function love.update(dt)
    sceneManager.update(dt)

    if internal_code_update then
        internal_code_update()
    end
end

function love.draw()
    sceneManager.draw()
end

-- Window

function love.directorydropped(...)
    sceneManager.directorydropped(...)
end

function love.displayrotated(...)
    sceneManager.displayrotated(...)
end

function love.filedropped(...)
    sceneManager.filedropped(...)
end

function love.focus(...)
    sceneManager.focus(...)
end

function love.mousefocus(...)
    sceneManager.mousefocus(...)
end

function love.resize(...)
    sceneManager.resize(...)
end

function love.visible(...)
    sceneManager.visible(...)
end

-- Keyboard

function love.keypressed(...)
    sceneManager.keypressed(...)
end

function love.keyreleased(...)
    sceneManager.keyreleased(...)
end

function love.textedited(...)
    sceneManager.textedited(...)
end

function love.textinput(...)
    sceneManager.textinput(...)
end

-- Mouse

function love.mousemoved(...)
    sceneManager.mousemoved(...)
end

function love.mousepressed(...)
    sceneManager.mousepressed(...)
end

function love.mousereleased(...)
    sceneManager.mousereleased(...)
end

function love.wheelmoved(...)
    sceneManager.wheelmoved(...)
end

-- Joystick + Gamepad

function love.gamepadaxis(...)
    sceneManager.gamepadaxis(...)
end

function love.gamepadpressed(...)
    sceneManager.gamepadpressed(...)
end

function love.gamepadreleased(...)
    sceneManager.gamepadreleased(...)
end

function love.joystickadded(...)
    sceneManager.joystickadded(...)
end

function love.joystickaxis(...)
    sceneManager.joystickaxis(...)
end

function love.joystickhat(...)
    sceneManager.joystickhat(...)
end

function love.joystickpressed(...)
    sceneManager.joystickpressed(...)
end

function love.joystickreleased(...)
    sceneManager.joystickreleased(...)
end

function love.joystickremoved(...)
    sceneManager.joystickremoved(...)
end

-- Touch

function love.touchmoved(...)
    sceneManager.touchmoved(...)
end

function love.touchpressed(...)
    sceneManager.touchpressed(...)
end

function love.touchreleased(...)
    sceneManager.touchreleased(...)
end