local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SelectorButton = require(script.Parent.SelectorButton)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type SideMenuSelectorProps = {
	SubCategories: { { Name: string, Data: { subcategoryId: number } } },
	SelectedSubCategory: string,
	OnSubCategorySelected: ((category: string) -> ())?,
}

local MAX_VISIBLE = 5

return function(props: SideMenuSelectorProps)
	local children = {}

	local SubCategoriesArray = table.clone(props.SubCategories)

	table.sort(SubCategoriesArray, function(a, b)
		return a.Data.subcategoryId < b.Data.subcategoryId
	end)

	local total = #SubCategoriesArray

	local visibleCount = math.min(total, MAX_VISIBLE - 1)

	local buttonWidth = 1 / visibleCount

	children["UIListLayout"] = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
	})

	children["UIPadding"] = e("UIPadding", {
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	for index, cat in ipairs(SubCategoriesArray) do
		children[#children + 1] = e(SelectorButton, {
			Title = cat.Name,
			Active = props.SelectedSubCategory == cat.Name,
			LayoutOrder = index,

			UseFlex = false,

			CustomSize = UDim2.fromScale(buttonWidth, 1),

			OnClick = function()
				if props.OnSubCategorySelected then
					props.OnSubCategorySelected(cat.Name)
				end
			end,
		})
	end

	print("dsdf")

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.5),
		BackgroundColor3 = Color3.fromHex("#1F2123"),
		ClipsDescendants = true,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		LayoutContainer = e("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,

			ScrollingDirection = Enum.ScrollingDirection.X,

			AutomaticCanvasSize = Enum.AutomaticSize.None,

			CanvasSize = UDim2.fromScale(total / visibleCount, 0),

			ScrollBarThickness = 2,
		}, children),
	})
end
