// This file is for loading files. We can also add a datastorage system here to save files.

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

// Loads the folder and adds the lua files to the client
function HZNLib:LoadFolder(folderName)
    local clientFiles = file.Find(folderName .. "/cl/*.lua", "LUA")
    local sharedFiles = file.Find(folderName .. "/sh/*.lua", "LUA")
    local serverFiles = file.Find(folderName .. "/sv/*.lua", "LUA")
    local vguiFiles = file.Find(folderName .. "/cl/vgui/*.lua", "LUA")

    for _, file in pairs(clientFiles) do
        loadClientFile(folderName .. "/cl/" .. file)
        HZNLib:Log("Loaded client file: " .. file)
    end

    for _, file in pairs(vguiFiles) do
        loadClientFile(folderName .. "/cl/vgui/" .. file)
        HZNLib:Log("Loaded client file: " .. file)
    end

    for _, file in pairs(sharedFiles) do
        loadSharedFile(folderName .. "/sh/" .. file)
        HZNLib:Log("Loaded shared file: " .. file)
    end

    for _, file in pairs(serverFiles) do
        loadServerFile(folderName .. "/sv/" .. file)
        HZNLib:Log("Loaded server file: " .. file)
    end
end