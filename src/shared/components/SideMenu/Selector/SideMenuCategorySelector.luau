local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextButton = require(script.Parent.TextButton)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type CategoryProps = {
	Categories: { string },
	SelectedCategoryIndex: number?,
	OnCategorySelected: (index: number) -> (),
}
return function(props: CategoryProps)
	local children = {}

	for index, category in ipairs(props.Categories) do
		children[tostring(index)] = e(TextButton, {
			Name = category,
			Selected = index == props.SelectedCategoryIndex,
			OnClick = function()
				props.OnCategorySelected(index)
			end,
		})
	end

	print("sdfsdfsds")
	return e("ScrollingFrame", {
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromOffset(0, 0),
		ScrollBarImageTransparency = 1,
		ClipsDescendants = true,

		BackgroundTransparency = 1,
		HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
	}, {
		Buttons = e("Frame", {
			Size = UDim2.fromScale(0, 1),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
		}, children),
	})
end
