local lk = love.keyboard
local lk_isd = lk.isScancodeDown

--[[------------------------]]--

local move = {}

function move.GetDirection(wkey, akey, skey, dkey)
    local dir = vector(0, 0)

    local any = lk_isd(wkey, akey, skey, dkey)

    if any then
        if lk_isd(wkey) then
            dir.y = -1
        elseif lk_isd(skey) then
            dir.y = 1
        end

        if lk_isd(akey) then
            dir.x = -1
        elseif lk_isd(dkey) then
            dir.x = 1
        end

        dir:normalizeInplace()
    end

    return dir
end

function move.GetDirectionWASD()
    return move.GetDirection("w", "a", "s", "d")
end

return move