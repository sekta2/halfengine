# HalfEngine

## Desc
tbc

## Install
Download the repository and `HalfCrashHandler.exe` from the releases.

Create a folder with the content from the repository and `HalfCrashHandler.exe`,
create a game folder, and in it a `config.lua` file.

`config.lua` structure:
```lua
--- HE 0.1.0
return {
    id = "HT",
    name = "Half Test",

    version = "0.0.0",

    width = 800,
    height = 600,

    fullscreen = false,
    borderless = false,
    resizable = false,

    vsync = true,
    msaa = 8
}
```