local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local PageContext = require(ReplicatedStorage.Shared.ui.context.PageContext)

local e = React.createElement

return function(props)
	return e(PageContext.Provider, nil, {
		AppLayout = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, {
			UIPadding = e("UIPadding", {
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			}),

			UIListLayout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0.03, 0),
				ItemLineAlignment = Enum.ItemLineAlignment.Center,
				VerticalFlex = Enum.UIFlexAlignment.Fill,
			}),

			ContentLayout = e(require(ReplicatedStorage.Shared.ui.layout.ContentLayout)),
			Bottombar = e(require(ReplicatedStorage.Shared.ui.components.bottombar.bottombarcontainer)),
		}),
	})
end
