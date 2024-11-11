local anim = {}

function anim.ease_in_sine(x) --      / 2
    return 1 - math.cos((x * math.pi) * 0.5)
end

function anim.ease_out_sine(x) -- / 2
    return math.sin((x * math.pi) * 0.5)
end

function anim.ease_inout_sine(x) --     / 2
    return -(math.cos(math.pi * x) - 1) * 0.5
end

return anim