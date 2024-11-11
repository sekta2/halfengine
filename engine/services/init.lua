local PATH = ... .. "."

--[[------------------------]]--

local services = {}
local thirdparty = {}

function half.load_service(name)
    local serv = services[name]

    if not serv then
        serv = require(PATH .. name)

        if type(serv) == "function" then
            serv = serv(half)
        end

        services[name] = serv
    end

    return serv
end

function half.load_thirdparty(name)
    local tp = thirdparty[name]

    if not tp then
        tp = require("engine.thirdparty." .. name)
        thirdparty[name] = tp
    end

    return tp
end