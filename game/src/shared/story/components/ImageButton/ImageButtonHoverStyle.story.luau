local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local ImageButton = require(ReplicatedStorage.Shared.components.core.ImageButtonComponent)
local UiIconList = require(ReplicatedStorage.Shared.UI.Images)

local e = React.createElement

return function(parent)
	local root = ReactRoblox.createRoot(parent)

	local app = e(ImageButton, {
		Image = UiIconList.GetIconUrl(UiIconList.Icons.Search),

		UseBackground = true,
		CornerRadius = 8,

		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		BackgroundColor = Color3.fromRGB(35, 35, 35),
		HoverBackgroundColor = Color3.fromRGB(45, 45, 45),
		PressedBackgroundColor = Color3.fromRGB(55, 55, 55),

		ImageColor = Color3.fromRGB(255, 255, 255),
		HoverImageColor = Color3.fromRGB(220, 220, 220),
		PressedImageColor = Color3.fromRGB(180, 180, 180),
	})

	root:render(app)

	return function()
		root:unmount()
	end
end
