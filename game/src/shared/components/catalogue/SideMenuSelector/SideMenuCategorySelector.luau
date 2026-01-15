local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SelectorButton = require(script.Parent.SelectorButton)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type SideMenuSelectorProps = {
	Categories: { [string]: { categoryId: number } },
	SelectedCategory: string,
	OnCategorySelected: ((category: string) -> ())?,
}

return function(props: SideMenuSelectorProps)
	local children = {}

	local categoriesArray = {}
	for name, data in pairs(props.Categories) do
		table.insert(categoriesArray, { Name = name, Data = data })
	end

	table.sort(categoriesArray, function(a, b)
		return a.Data.categoryId < b.Data.categoryId
	end)

	children["UIListLayout"] = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
	})

	children["UICorner"] = e("UICorner", {
		CornerRadius = UDim.new(0, 8),
	})

	for index, cat in ipairs(categoriesArray) do
		children[#children + 1] = e(SelectorButton, {
			Title = cat.Name,
			Active = props.SelectedCategory == cat.Name,
			LayoutOrder = index,
			OnClick = function()
				if props.OnCategorySelected then
					props.OnCategorySelected(cat.Name)
				end
			end,
		})
	end

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.5),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		ClipsDescendants = true,
	}, {
		Corner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		BottomMask = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.fromScale(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			ZIndex = -2,
		}),

		BottomBorder = e("Frame", {
			Size = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.fromScale(0, 0.95),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		}),
		LayoutContainer = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, children),
	})
end
