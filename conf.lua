require("engine")

--[[------------------------]]--

HALF_ERROR = ""
HALF_ERROR_OCCURED = false

function set_half_error(err)
    HALF_ERROR = err
    HALF_ERROR_OCCURED = true
end

local logs = ""
local old_print = print

function print(...)
    old_print(...)

    local t = {...}
    local str = ""

    for i = 1, t do
        if i == #t then
            str = str .. t[i]
        else
            str = str .. t[i] .. "\n"
        end
    end

    logs = logs .. str .. "\n"
end

function crash_handler(err)
    err = err or HALF_ERROR

    os.execute([[HalfCrashHandler.exe "]] .. logs .. [[" "]] .. err .. [["]])
    love.event.quit()
end

--[[------------------------]]--

local success, gamecfg = pcall(half.get_game_info)
if not success then set_half_error("No game config") return end

local function value_or_setting(val)
    --val = type(val) == "string" and settings.get(val) or val
    return val
end

local vos = value_or_setting

function love.conf(t)
    t.identity = gamecfg.id
    t.title = gamecfg.name

    t.window.width = vos(gamecfg.width)
    t.window.height = vos(gamecfg.height)

    t.window.fullscreen = vos(gamecfg.fullscreen)
    t.window.borderless = vos(gamecfg.borderless)
    t.window.resizable = vos(gamecfg.resizable)

    t.window.vsync = vos(gamecfg.vsync)
    t.window.msaa = vos(gamecfg.msaa)
end