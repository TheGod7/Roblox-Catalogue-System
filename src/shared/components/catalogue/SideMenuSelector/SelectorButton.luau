local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type SelectorButtonProps = {
	Title: string,
	Active: boolean?,
	TextSize: number?,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	OnClick: (() -> ())?,
	UseFlex: boolean?,
	CustomSize: UDim2?,
}

return function(props: SelectorButtonProps)
	local hover, setHover = React.useState(false)
	local pressed, setPressed = React.useState(false)

	local transparency = 1
	if hover then
		transparency = 0.7
	end
	if pressed then
		transparency = 0.6
	end
	if props.Active then
		transparency = 0.8
	end

	local useFlex = if props.UseFlex == nil then true else props.UseFlex

	local buttonSize = if useFlex then UDim2.fromScale(0, 1) else (props.CustomSize or UDim2.fromScale(0, 1))

	local children = {}

	if useFlex then
		table.insert(
			children,
			e("UIFlexItem", {
				FlexMode = Enum.UIFlexMode.Fill,
			})
		)
	end

	if props.Active then
		table.insert(
			children,
			e("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.fromScale(1, 0.1),
				BackgroundTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.fromScale(0, 1),
			})
		)
	end

	return e("TextButton", {
		Text = props.Title or "Button",
		Size = buttonSize,
		AutoButtonColor = false,
		TextSize = props.TextSize or 14,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = transparency,
		AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
		Position = props.Position or UDim2.fromScale(0.5, 0.5),
		BorderSizePixel = 0,

		[React.Event.MouseEnter] = function()
			setHover(true)
		end,

		[React.Event.MouseLeave] = function()
			setHover(false)
			setPressed(false)
		end,

		[React.Event.MouseButton1Down] = function()
			setPressed(true)
		end,

		[React.Event.MouseButton1Up] = function()
			setPressed(false)
			if props.OnClick then
				props.OnClick()
			end
		end,
	}, children)
end
