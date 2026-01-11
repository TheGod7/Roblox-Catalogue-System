local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SideMenuComponent = require(script.Parent.SideMenuComponent)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

return function()
	return e("Frame", {

		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	}, {
		UIGradient = e("UIGradient", {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 22, 23)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(24, 22, 23)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 57, 65)),
			}),
			Rotation = 90,
		}),

		side = e(SideMenuComponent),
	})
end
