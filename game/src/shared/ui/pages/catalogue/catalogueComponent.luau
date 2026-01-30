local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local Icons = require(ReplicatedStorage.Shared.ui.Icons)
local FiltersContext = require(ReplicatedStorage.Shared.ui.context.FiltersContext)
local windowLayout = require(ReplicatedStorage.Shared.ui.layout.windows.windowLayout)

local e = React.createElement

return function(props)
	return e(FiltersContext.Provider, nil, {
		children = e(windowLayout, {
			Title = "Catalogue",
			Icon = Icons.Catalogue,
			children = e("Frame", {
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(0, 255, 0),
				BackgroundTransparency = 0,
			}),
		}),
	})
end
