local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SideMenuHeader = require(script.Parent.SideMenuHeader)
local SideMenuSelector = require(script.Parent.SideMenuSelector)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

return function()
	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
		SideMenuContainer = e("Frame", {
			Size = UDim2.fromScale(0.7, 1),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			BackgroundTransparency = 1,
		}, {
			UIPadding = e("UIPadding", {
				PaddingTop = UDim.new(0.1, 0),
			}),

			SideMenu = e("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = Color3.fromHex("#232527"),
				ClipsDescendants = true,
			}, {
				UIPadding = e("UIPadding", {
					PaddingTop = UDim.new(0.02, 0),
					PaddingBottom = UDim.new(0.02, 0),
					PaddingLeft = UDim.new(0.02, 0),
					PaddingRight = UDim.new(0.02, 0),
				}),

				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0.02, 0),
				}),

				BottomMask = e("Frame", {
					Size = UDim2.new(1, 4000, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0, 0.8),
					BackgroundColor3 = Color3.fromHex("#232527"),
					ZIndex = -1,
				}),

				Layout = e("Frame", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
				}, {
					UILayout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0.02, 0),
					}),
					Header = e(SideMenuHeader, {
						Title = "Catalogue",
					}),
					SideMenuSelector = e(SideMenuSelector, {}),
				}),
			}),
		}),
	})
end
