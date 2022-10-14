// Steel's Addon Loader
// Fuck off -Steel.

HZNLib = {}

local AddonName = "HZNLib"
local AddonColor = Color(125, 164, 19)
local AddonSubFolder = "hznlib"

local function loadServerFile(str)
    if CLIENT then return end
    include(str)
end

local function loadClientFile(str)
    if SERVER then AddCSLuaFile(str) return end
    include(str)
end

local function loadSharedFile(str)
    if SERVER then AddCSLuaFile(str) end
    include(str)
end

function HZNLib:Log(str)
    MsgC(AddonColor, "[" .. AddonName .. "] ", Color(255, 255, 255), str, "\n")
end

local function load()
    local clientFiles = file.Find(AddonSubFolder .. "/cl/*.lua", "LUA")
    local sharedFiles = file.Find(AddonSubFolder .. "/sh/*.lua", "LUA")
    local serverFiles = file.Find(AddonSubFolder .. "/sv/*.lua", "LUA")

    for _, file in pairs(clientFiles) do
        loadClientFile(AddonSubFolder .. "/cl/" .. file)
        HZNLib:Log("Loaded client file: " .. file)
    end

    for _, file in pairs(sharedFiles) do
        loadSharedFile(AddonSubFolder .. "/sh/" .. file)
        HZNLib:Log("Loaded shared file: " .. file)
    end

    for _, file in pairs(serverFiles) do
        loadServerFile(AddonSubFolder .. "/sv/" .. file)
        HZNLib:Log("Loaded server file: " .. file)
    end

    HZNLib:Log("Loaded all files!")

    hook.Run("HZNLib:Loaded")

    if (SERVER) then
        HZNLib:InitializeDatabase()
    end
end
load()

