local services = {}

--- Loads service
---@param name string
---@return table
function half.load_service(name)
    local serv = services[name]

    if serv == nil then
        local success, t = pcall(require, "engine.services." .. name)
        if not success then
            print([[!!! Error when loading the service "]] .. name .. [[": ]] .. t)
            services[name] = false

            return false
        end

        serv = t
        services[name] = t
    end

    return serv
end