local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local InputWithIcons = require(ReplicatedStorage.Shared.components.core.TextInputComponent)
local UiIconList = require(ReplicatedStorage.Shared.UI.Images)

local e = React.createElement

return function(parent)
	local root = ReactRoblox.createRoot(parent)

	local app = e(InputWithIcons, {
		Size = UDim2.fromScale(0.3, 0.08),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),

		PlaceholderText = "Search...",
		PlaceholderColor = Color3.fromRGB(150, 150, 150),

		TextColor = Color3.fromRGB(255, 255, 255),

		BackgroundColor = Color3.fromRGB(35, 35, 35),

		CornerRadius = 10,

		Stroke = true,
		StrokeThickness = 2,

		LeftIcon = UiIconList.GetIconUrl(UiIconList.Icons.Search),
		LeftIsButton = false,
	})

	root:render(app)

	return function()
		root:unmount()
	end
end
