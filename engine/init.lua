local PATH = ... .. "."

--[[------------------------]]--

half = {
    _VERSION = "0.5rfs",

    game_conf = nil
}

---@return table or boolean
function half.get_config()
    local conf = half.game_conf

    if conf == nil then
        local success, t = pcall(require, "game.config")
        if not success or not t or type(t) ~= "table" then half.game_conf = false return false end

        conf = t
        half.game_conf = t
    end

    return conf
end

middleclass = require(PATH .. "thirdparty.middleclass")
vector = require(PATH .. "thirdparty.vector")

half.util = require(PATH .. "util")
half.class = require(PATH .. "class")
require(PATH .. "services")

function half.load()
    physics = half.load_service("physics")
end