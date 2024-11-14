require("engine")

--[[------------------------]]--

HALF_ERROR = ""
HALF_ERROR_OCCURED = false

HALF_DEBUG = false

function set_half_error(err)
    HALF_ERROR = err
    HALF_ERROR_OCCURED = true
end

function crash_handler(err)
    err = err or HALF_ERROR

    -- logs not working
    os.execute([[HalfCrashHandler.exe "]] .. "" .. [[" "]] .. err .. [["]])
    love.event.quit()
end

local function error_printer(msg, layer)
    print(debug.traceback("Error: " .. tostring(msg), 1 + (layer or 1)):gsub("\n[^\n]+$", ""))
end

function love.errorhandler(msg)
    error_printer(msg, 2)
    crash_handler(msg)
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