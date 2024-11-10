local PATH = ... .. "."

--[[------------------------]]--

half = {
    _VERSION = "0.2.0",

    gamecfg = nil
}

function half.get_version()
    return half._VERSION
end

function half.get_game_info()
    local gamecfg = half.gamecfg

    if not gamecfg then
        gamecfg = require("game.config")
        half.gamecfg = gamecfg
    end
    
    return gamecfg
end

require(PATH .. "enums")
require(PATH .. "services")