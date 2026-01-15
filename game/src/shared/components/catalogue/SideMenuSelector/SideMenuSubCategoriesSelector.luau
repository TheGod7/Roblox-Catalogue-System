local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SelectorButton = require(script.Parent.SelectorButton)
local SelectorbuttonImage = require(script.Parent.SelectorbuttonImage)
local React = require(ReplicatedStorage.Packages.React)
local UiIconList = require(ReplicatedStorage.Shared.UI.Images)

local e = React.createElement

export type SideMenuSelectorProps = {
	SubCategories: { { Name: string, Data: { subcategoryId: number } } },
	SelectedSubCategory: string,
	OnSubCategorySelected: ((category: string) -> ())?,
	FilterPressed: boolean?,
	FilterActive: boolean?,
	OnFilterClick: (() -> ())?,
}

local MAX_VISIBLE = 5
local MAX_PAGES = 1.4

return function(props: SideMenuSelectorProps)
	local scrollRef = React.useRef(nil)

	local SubCategoriesArray = table.clone(props.SubCategories)

	table.sort(SubCategoriesArray, function(a, b)
		return a.Data.subcategoryId < b.Data.subcategoryId
	end)

	local total = #SubCategoriesArray
	local visibleCount = math.min(total, MAX_VISIBLE)
	local buttonWidth = if total > 0 then 1 / visibleCount else 1

	local pages = total / MAX_VISIBLE
	local canvasPages = math.min(pages, MAX_PAGES)

	local children = {}

	if total > 0 then
		children["UIListLayout"] = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		children["UIFlex"] = e("UIFlexItem", {
			FlexMode = Enum.UIFlexMode.Fill,
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
	end

	React.useEffect(function()
		if total > 0 then
			local scrollingFrame = scrollRef.current
			if scrollingFrame then
				scrollingFrame.CanvasPosition = Vector2.new(0, 0)
			end
		end
	end, { props.SubCategories })

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.5),
		BackgroundColor3 = Color3.fromHex("#1F2123"),
		ClipsDescendants = true,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		TopMask = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			ZIndex = -2,
		}),

		BottomBorder = e("Frame", {
			Size = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.fromScale(0, 0.98),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		}),

		Container = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, {
			UIListLayout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			FilterButton = e(SelectorbuttonImage, {
				Image = UiIconList.GetIconUrl(UiIconList.Icons.Filter),
				Active = props.FilterActive,
				Pressed = props.FilterPressed,
				UseFlex = false,
				CustomSize = total > 0 and UDim2.fromScale(0.1, 1) or UDim2.fromScale(1, 1),
				OnClick = function()
					if props.OnFilterClick then
						props.OnFilterClick()
					end
				end,
			}),

			SubCategories = total > 0 and e("ScrollingFrame", {
				ref = scrollRef,
				Size = UDim2.fromScale(1, 0.9),
				BackgroundTransparency = 1,
				ScrollingDirection = Enum.ScrollingDirection.X,
				AutomaticCanvasSize = Enum.AutomaticSize.None,
				CanvasSize = UDim2.fromScale(canvasPages, 0),
				ScrollBarThickness = 2,
			}, children) or nil,
		}),
	})
end
