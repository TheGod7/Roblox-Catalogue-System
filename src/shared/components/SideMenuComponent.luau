local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

return function()
	return e("Frame", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.fromScale(0.5, 1),
		BackgroundColor3 = Color3.fromRGB(35, 37, 38),
	}, {
		Header = e(require(ReplicatedStorage.Shared.components.SideMenu.SideMenuHeader)),
		Selector = e(require(ReplicatedStorage.Shared.components.SideMenu.SideMenuSelector)),
	})
end
