local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SliderModule: any = require(ReplicatedStorage.Packages.SliderModule)

local plr: Player = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui") :: PlayerGui

local sliderGui = plrGui:WaitForChild("ScreenGui") :: ScreenGui
local slidingBase= sliderGui:WaitForChild("SlidingPart") :: Frame

local sliderMarker = slidingBase:WaitForChild("Slider") :: Frame
local sliderButton = sliderMarker:WaitForChild("Button") :: TextButton

local textFrame = slidingBase:WaitForChild("ValueFrame") :: Frame
local valueText = textFrame:WaitForChild("TextLabel") :: TextBox

local snapFactor = 0.1

local min = 0
local max = 50

local newSlider: SliderModule.slider = SliderModule.new(slidingBase, sliderMarker, sliderButton, 
{
    min = min,
    max = max,
    snapFactor = snapFactor
}, 
{
    TextBox = valueText,
    DefaultValue = 25,
})

newSlider:Activate()

newSlider.InteractionBegan.Event:Connect(function()
    print("Interaction began.")
end)

newSlider.InteractionEnded.Event:Connect(function(finalValue: number)
    print("Interaction ended, final value is " .. finalValue)
end)

newSlider.ValueChanged.Event:Connect(function(newValue: number)
    print("Value changed, new value is " .. newValue)
end)