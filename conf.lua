require("engine")

HALF_ERROR_OCCURED = false

--[[------------------------]]--

local conf = half.get_config()

function love.conf(t)
    if not conf then HALF_ERROR_OCCURED = true return end

    t.identity = conf.id
    t.version = "11.5"

    t.window.title = conf.title

    local wp = conf.window

    if wp then
        t.window.icon = wp.icon or nil
        t.window.width = wp.width or 800
        t.window.height = wp.height or 600
        t.window.borderless = wp.borderless or false
        t.window.resizable = wp.resizable or false
        t.window.minwidth = wp.minwidth or 1
        t.window.minheight = wp.minheight or 1
        t.window.fullscreen = wp.fullscreen or false
        t.window.fullscreentype = wp.fullscreentype or "desktop"
        t.window.vsync = wp.vsync or 1
        t.window.msaa = wp.msaa or 0
        t.window.depth = wp.depth or nil
        t.window.stencil = wp.stencil or nil
        t.window.display = wp.display or 1
        t.window.highdpi = wp.highdpi or false
        t.window.usedpiscale = wp.usedpiscale or true
        t.window.x = wp.x or nil
        t.window.y = wp.y or nil
    end
end