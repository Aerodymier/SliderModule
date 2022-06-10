local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Slider = {}

local SliderFunctions = {}
SliderFunctions.__index = SliderFunctions

Slider.new = function(slidingBase: Frame, sliderMarker: Frame, sliderButton: TextButton | ImageButton, sliderConfigurations: table, extras: table)
	local self = setmetatable({}, SliderFunctions)
	assert(sliderConfigurations.min, "sliderConfigurations need a min variable.")
	assert(sliderConfigurations.max, "sliderConfigurations need a max variable.")
	assert(sliderConfigurations.snapFactor, "sliderConfigurations need a snapFactor variable.")
	assert(slidingBase.AnchorPoint == Vector2.new(0.5, 0.5), "Set the AnchorPoint of " .. slidingBase.Name .. " to (0.5, 0.5)")
	assert(sliderButton:IsDescendantOf(sliderMarker), "SliderButton needs to be a descendant of sliderMarker.")

	self.slidingBase = slidingBase :: Frame
	self.sliderMarker = sliderMarker :: Frame
	self.sliderButton = sliderButton :: TextButton | ImageButton
	self.min = sliderConfigurations.min :: number
	self.max = sliderConfigurations.max :: number
	self.snapFactor = sliderConfigurations.snapFactor :: number
	
	self.firstPartPos = UDim2.new(slidingBase.Position.X.Scale - slidingBase.Size.X.Scale/2, 0, slidingBase.Position.Y.Scale, 0) :: UDim2
	self.lastPartPos = UDim2.new(slidingBase.Position.X.Scale + slidingBase.Size.X.Scale/2, 0, slidingBase.Position.Y.Scale, 0) :: UDim2
	self.lineSize = slidingBase.Size.X.Scale :: number
	
	if extras then
		self.TargetTextBox = extras.TextBox ::TextBox
	end
	
	self.InteractionBegan = Instance.new("BindableEvent")
	self.InteractionEnded = Instance.new("BindableEvent")
	self.ValueChanged = Instance.new("BindableEvent")
	
	return self
end

local function decimalRound(num, places)
	local power = 10^places
	return math.round(num * power) / power
end

local function snap(self: table, posInLine: number)
	local val = math.clamp(math.floor(posInLine / self.snapFactor) * self.snapFactor, 0, 1)
	return val
end

local function getText(self: table, snapN: number)
	local ratio = 1 / self.snapFactor
	local step = (self.max-self.min)/ratio

	return decimalRound(step * (snapN/self.snapFactor), 1)
end

function SliderFunctions:Activate()
	local runServiceEvent
	local previousValue = 0
	
	self.sliderButton.MouseButton1Down:Connect(function()
		self.InteractionBegan:Fire()
		
		runServiceEvent = RunService.RenderStepped:Connect(function()
			if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				runServiceEvent:Disconnect()
				self.InteractionEnded:Fire(self.CurrentValue)
				return
			end
			local vpX = workspace.Camera.ViewportSize.X
			local mouseLoc: Vector2 = UIS:GetMouseLocation()

			local xScale = math.clamp((mouseLoc.X - (self.firstPartPos.X.Scale * vpX))/vpX, 0, self.lineSize)

			if xScale > 0 then
				if xScale < 1 then
					self.sliderMarker.Position = UDim2.new(snap(self, xScale/self.lineSize), 0, self.sliderMarker.Position.Y.Scale, 0)
					self.CurrentValue = getText(self, snap(self, xScale/self.lineSize))
					
					if self.TargetTextBox then
						self.TargetTextBox.Text = self.CurrentValue
					end
					
					if previousValue ~= self.CurrentValue then
						previousValue = self.CurrentValue
						self.ValueChanged:Fire(self.CurrentValue)
					end
				end
			else
				self.sliderMarker.Position = UDim2.new(0, 0, self.sliderMarker.Position.Y.Scale, 0)
				self.CurrentValue = getText(self, snap(self, xScale/self.lineSize))
				
				if self.TargetTextBox then
					self.TargetTextBox.Text = self.CurrentValue
				end
			end
		end)
	end)
end

return Slider