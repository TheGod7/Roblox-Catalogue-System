local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement
local useState = React.useState

export type ImageButtonProps = {
	Image: string,
	Size: UDim2?,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	Active: boolean?,
	OnClick: (() -> ())?,
	UseBackground: boolean?,
	CornerRadius: number?,

	BackgroundColor: Color3?,
	HoverBackgroundColor: Color3?,
	PressedBackgroundColor: Color3?,
	SelectedBackgroundColor: Color3?,
	DisabledBackgroundColor: Color3?,

	ImageColor: Color3?,
	HoverImageColor: Color3?,
	PressedImageColor: Color3?,
	SelectedImageColor: Color3?,
	DisabledImageColor: Color3?,

	UseStroke: boolean?,
	StrokeColor: Color3?,
	StrokeThickness: number?,

	UseAspectRatio: boolean?,
	AspectRatio: number?,
}

return function(props: ImageButtonProps)
	local isHover, setHover = useState(false)
	local isPressed, setPressed = useState(false)

	local enabled = props.Active ~= false
	local selected = props.Active == true

	local bgColor = (not enabled and (props.DisabledBackgroundColor or Color3.fromRGB(40, 40, 40)))
		or (isPressed and (props.PressedBackgroundColor or Color3.fromRGB(60, 60, 60)))
		or (isHover and (props.HoverBackgroundColor or Color3.fromRGB(55, 55, 55)))
		or (selected and (props.SelectedBackgroundColor or Color3.fromRGB(65, 65, 65)))
		or (props.BackgroundColor or Color3.fromRGB(50, 50, 50))

	local imgColor = (not enabled and (props.DisabledImageColor or Color3.fromRGB(120, 120, 120)))
		or (isPressed and (props.PressedImageColor or Color3.fromRGB(200, 200, 200)))
		or (isHover and (props.HoverImageColor or Color3.fromRGB(230, 230, 230)))
		or (selected and (props.SelectedImageColor or Color3.fromRGB(255, 255, 255)))
		or (props.ImageColor or Color3.fromRGB(255, 255, 255))

	return e("ImageButton", {
		AutoButtonColor = false,
		Active = enabled,
		Selectable = enabled,

		BackgroundTransparency = props.UseBackground and 0 or 1,
		BackgroundColor3 = bgColor,
		ImageTransparency = 1,

		Size = props.Size,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,

		[React.Event.MouseEnter] = function()
			if enabled then
				setHover(true)
			end
		end,

		[React.Event.MouseLeave] = function()
			setHover(false)
			setPressed(false)
		end,

		[React.Event.MouseButton1Down] = function()
			if enabled then
				setPressed(true)
			end
		end,

		[React.Event.MouseButton1Up] = function()
			if enabled then
				setPressed(false)
				if props.OnClick then
					props.OnClick()
				end
			end
		end,
	}, {
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 6),
			PaddingRight = UDim.new(0, 6),
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
		}),

		UICorner = props.UseBackground and props.CornerRadius and e("UICorner", {
			CornerRadius = UDim.new(0, props.CornerRadius),
		}) or nil,

		UIStroke = props.UseStroke and e("UIStroke", {
			Color = props.StrokeColor or Color3.fromRGB(90, 90, 90),
			Thickness = props.StrokeThickness or 1,
		}) or nil,

		AspectRatio = props.UseAspectRatio and e("UIAspectRatioConstraint", {
			AspectRatio = props.AspectRatio or 1,
		}) or nil,

		Image = e("ImageLabel", {
			Image = props.Image,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ImageColor3 = imgColor,
		}),
	})
end
