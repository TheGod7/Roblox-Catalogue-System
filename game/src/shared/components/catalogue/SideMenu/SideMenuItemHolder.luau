local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type ItemMenuHolder = {
	Items: { [string]: any },
}

return function(props: ItemMenuHolder)
	local children = {}

	-- for i, item in pairs(props.Items) do
	-- 	children[i] = e("Frame", {
	-- 		Size = UDim2.fromScale(1, 0.1),
	-- 		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	-- 	})
	-- end
	return e("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	}, {
		Flex = e("UIFlexItem", {
			FlexMode = Enum.UIFlexMode.Fill,
		}),
	})
end
