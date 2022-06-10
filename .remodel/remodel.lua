local game = remodel.readPlaceFile("E:/Roblox/Studio/slider.rbxl")

local ReplicatedStorage = game.ReplicatedStorage
local StarterGui = game.StarterGui

local function handleLoops(object, folderName)
    if object.ClassName == "Folder" then
        local dir = "../src/" .. folderName .. "/" .. object.Name
        remodel.createDirAll(dir)
        for _, v in pairs(object:GetChildren()) do
            handleLoops(v, dir)
        end
    else
        local dir = "../src/" .. folderName .. "/" .. object.Name

        if object.ClassName == "LocalScript" then
            remodel.writeFile(dir .. ".client.lua", remodel.getRawProperty(object, "Source"))
        elseif object.ClassName == "Script" then
            remodel.writeFile(dir .. ".server.lua", remodel.getRawProperty(object, "Source"))
        elseif object.ClassName == "ModuleScript" then
            remodel.writeFile(dir .. ".lua", remodel.getRawProperty(object, "Source"))
        else
            remodel.writeModelFile(object, dir .. ".rbxmx")
        end
    end
end

for _, object in ipairs(ReplicatedStorage:GetChildren()) do
    handleLoops(object, "shared")
end

for _, object in ipairs(StarterGui:GetChildren()) do
    handleLoops(object, "startergui")
end