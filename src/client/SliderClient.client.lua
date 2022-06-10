local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local SliderModule: any = require(ReplicatedStorage.SliderModule)

local plr: Player = Players.LocalPlayer
local plrGui: PlayerGui = plr:WaitForChild("PlayerGui")

local sliderGui: ScreenGui = plrGui:WaitForChild("ScreenGui")
local slidingBase: Frame = sliderGui:WaitForChild("SlidingPart")

local sliderMarker: Frame = slidingBase:WaitForChild("Slider")
local sliderButton: TextButton = sliderMarker:WaitForChild("Button")

local textFrame: Frame = slidingBase:WaitForChild("ValueFrame")
local valueText: TextLabel = textFrame:WaitForChild("TextLabel")

local snapFactor = 0.05

local min = 0
local max = 50

local newSlider = SliderModule.new(slidingBase, sliderMarker, sliderButton, 
{
    min = min,
    max = max,
    snapFactor = snapFactor
}, 
{
    TextBox = valueText
})

newSlider:Activate()