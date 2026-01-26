local ReplicatedStorage = game:GetService("ReplicatedStorage")
local bottombarButton = require(script.Parent.bottombarButton)
local React = require(ReplicatedStorage.Packages.React)
local colorStyleConstant = require(ReplicatedStorage.Shared.ui.colorStyleConstant)
local pageNavList = require(ReplicatedStorage.Shared.ui.pages.pageNavList)

local e = React.createElement

return function()
	return e("Frame", {
		Size = UDim2.fromScale(0.4, 0.1),
		AutomaticSize = Enum.AutomaticSize.X,
		Position = UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = colorStyleConstant.Primary,
		SizeConstraint = Enum.SizeConstraint.RelativeXX,
		LayoutOrder = 1,
	}, {
		UISizeConstraint = e("UISizeConstraint", {
			MinSize = Vector2.new(0, 0),
			MaxSize = Vector2.new(415, 60),
		}),

		UIPadding = e("UIPadding", {
			PaddingTop = UDim.new(0, 5),
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 20),
			PaddingRight = UDim.new(0, 20),
		}),

		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		UIStroke = e("UIStroke", {
			Color = colorStyleConstant.Accent,
			Thickness = 2,
			BorderStrokePosition = Enum.BorderStrokePosition.Outer,
		}),

		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			ItemLineAlignment = Enum.ItemLineAlignment.Center,
			SortOrder = Enum.SortOrder.Name,
			Padding = UDim.new(0, 20),
		}),

		Buttons = e(
			React.Fragment,
			nil,
			(function()
				local children = {}

				for _, page in pairs(pageNavList) do
					children[page.order] = e(bottombarButton, {
						id = page.id,
						icon = page.icon,
					})
				end

				return children
			end)()
		),
	})
end
