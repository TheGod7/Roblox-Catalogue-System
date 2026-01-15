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

		Active = true,
		Position = UDim2.fromScale(0.5, 0.5),

		BackgroundColor = Color3.fromRGB(35, 35, 35),
		SelectedBackgroundColor = Color3.fromRGB(70, 70, 70),

		ImageColor = Color3.fromRGB(200, 200, 200),
		SelectedImageColor = Color3.fromRGB(255, 255, 255),
	})

	root:render(app)

	return function()
		root:unmount()
	end
end
