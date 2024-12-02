local PATH = ... .. "."

--[[------------------------]]--

local classlib = {
    list = {}
}

function classlib.add(name, tbl)
    classlib.list[name] = tbl
end

function classlib.new(name, base, add_to_list)
    if name ~= "Object" and base == nil then
        base = "Object"
    end

    local base_class = type(base) == "table" and base or classlib.get(base)

    local class = middleclass(name, base_class)

    if add_to_list then
        classlib.add(name, class)
    end

    return class
end

function classlib.create(name, ...)
    local class = classlib.get(name)
    if not class then return end

    return class:Create(...)
end

function classlib.get(name)
    return classlib.list[name]
end

require(PATH .. "object")(classlib)

return classlib