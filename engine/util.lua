local util = {}

function util.set_function(meta, key, name)
    meta["Set" .. name] = function(self, val)
        self[key] = val
    end
end

function util.get_function(meta, key, name)
    meta["Get" .. name] = function(self)
        return self[key]
    end
end

function util.set_get_function(meta, key, name)
    util.set_function(meta, key, name)
    util.get_function(meta, key, name)
end

return util