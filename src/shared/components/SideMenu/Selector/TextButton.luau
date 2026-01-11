local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type CategorySubcategoryBTNProps = {
	Name: string,
	Selected: boolean,
	OnClick: () -> (),
}

return function(props: CategorySubcategoryBTNProps)
	local children = {}

	if props.Selected then
		children["Border"] = e("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 2,
		})
	end

	return e("TextButton", {
		Text = props.Name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundColor3 = Color3.fromRGB(35, 37, 38),
		Font = Enum.Font.SourceSans,
		TextSize = 18,
		Size = UDim2.fromOffset(0, 0),
		AutomaticSize = Enum.AutomaticSize.XY,
		BorderSizePixel = 0,
		[React.Event.Activated] = props.OnClick,
	}, children)
end
