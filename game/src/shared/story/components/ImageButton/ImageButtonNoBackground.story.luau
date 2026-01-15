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

		UseBackground = false,

		Size = UDim2.fromOffset(36, 36),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	})

	root:render(app)

	return function()
		root:unmount()
	end
end
