function set_function(meta, key, name)
    meta["Set" .. name] = function(self, val)
        self[key] = val
    end
end

function get_function(meta, key, name)
    meta["Get" .. name] = function(self)
        return self[key]
    end
end

function set_get_function(meta, key, name)
    set_function(meta, key, name)
    get_function(meta, key, name)
end