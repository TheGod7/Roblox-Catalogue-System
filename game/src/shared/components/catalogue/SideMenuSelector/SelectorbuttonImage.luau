local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type SelectorButtonProps = {
	Image: string,
	Active: boolean?,
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
				Size = UDim2.fromScale(1, 0.08),
				BackgroundTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				Position = UDim2.fromScale(0, 1),
				BorderSizePixel = 0,
			})
		)
	end

	table.insert(
		children,
		e("ImageLabel", {
			Image = props.Image,
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.8, 0.8),
			ScaleType = Enum.ScaleType.Fit,
		}, {
			Aspect = e("UIAspectRatioConstraint", {
				AspectRatio = 1,
			}),
		})
	)

	return e("ImageButton", {
		Size = buttonSize,
		AutoButtonColor = false,
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
