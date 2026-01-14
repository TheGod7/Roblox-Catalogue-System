local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ImageButtonComponent = require(script.Parent.ImageButtonComponent)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type TextInputProps = {
	Size: UDim2,
	Position: UDim2,
	AnchorPoint: Vector2,

	PlaceholderText: string,
	PlaceholderColor: Color3,

	Text: string?,

	TextPlaceholder: string?,
	TextPlaceholderColor: Color3?,

	TextColor: Color3,
	TextSize: number?,

	BackgroundColor: Color3,
	SelectedBackgroundColor: Color3,
	HoverBackgroundColor: Color3,
	PressedBackgroundColor: Color3,
	DisabledBackgroundColor: Color3,

	CornerRadius: number,

	Stroke: boolean?,
	StrokeColor: Color3?,
	StrokeThickness: number?,

	LeftIcon: string?,
	LeftIconColor: Color3?,
	LeftIsButton: boolean?,
	LeftOnPress: (() -> ())?,
	LeftImageColor: Color3?,
	LeftActive: boolean?,

	RightIcon: string?,
	RightIconColor: Color3?,
	RightIsButton: boolean?,
	RightOnPress: (() -> ())?,
	RightActive: boolean?,

	OnTextChanged: ((text: string) -> ())?,
	OnFocusLost: ((enterPressed: boolean) -> ())?,
	OnFocused: (() -> ())?,
}

return function(props: TextInputProps)
	local inside = {}
	local outside = {}

	-- INPUT CONTAINER
	outside["B"] = e("Frame", {
		BackgroundColor3 = props.BackgroundColor,
		Size = UDim2.fromScale(1, 1),
	}, inside)

	-- OUTER LAYOUT
	outside["UIListLayout"] = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Padding = UDim.new(0.02, 0),
	})

	-- INNER LAYOUT
	inside["UIListLayout"] = e("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Padding = UDim.new(0.04, 0),
	})

	-- PADDING
	inside["Padding"] = e("UIPadding", {
		PaddingTop = UDim.new(0.1, 0),
		PaddingBottom = UDim.new(0.1, 0),
		PaddingLeft = UDim.new(0.03, 0),
		PaddingRight = UDim.new(0.03, 0),
	})

	-- TEXTBOX
	inside["TextBox"] = e("TextBox", {
		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,

		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,

		Text = props.Text or "",
		ClearTextOnFocus = false,

		TextColor3 = props.TextColor,
		TextSize = props.TextSize or 12,

		PlaceholderText = props.TextPlaceholder or props.PlaceholderText,
		PlaceholderColor3 = props.TextPlaceholderColor or props.PlaceholderColor,

		ClipsDescendants = true,

		-- 🔹 INPUT EVENTS
		[React.Change.Text] = function(rbx)
			if props.OnTextChanged then
				props.OnTextChanged(rbx.Text)
			end
		end,

		[React.Event.Focused] = function()
			if props.OnFocused then
				props.OnFocused()
			end
		end,

		[React.Event.FocusLost] = function(_, enterPressed)
			if props.OnFocusLost then
				props.OnFocusLost(enterPressed)
			end
		end,
	}, {
		FlexItem = e("UIFlexItem", {
			FlexMode = Enum.UIFlexMode.Fill,
		}),
	})

	-- FLEX FILL
	inside["Flex"] = e("UIFlexItem", {
		FlexMode = Enum.UIFlexMode.Fill,
	})

	-- CORNER
	if props.CornerRadius then
		inside["Corner"] = e("UICorner", {
			CornerRadius = UDim.new(0, props.CornerRadius),
		})
	end

	-- STROKE
	if props.Stroke then
		inside["Stroke"] = e("UIStroke", {
			Color = props.StrokeColor or Color3.fromRGB(0, 0, 0),
			Thickness = props.StrokeThickness or 1,
		})
	end

	-- LEFT BUTTON
	if props.LeftIcon and props.LeftIsButton then
		outside["Left"] = e(ImageButtonComponent, {
			Image = props.LeftIcon,
			Size = UDim2.fromScale(1, 1),

			UseAspectRatio = true,
			UseBackground = true,

			Active = props.LeftActive,
			BackgroundColor = props.BackgroundColor,
			HoverBackgroundColor = props.HoverBackgroundColor,
			PressedBackgroundColor = props.PressedBackgroundColor,
			SelectedBackgroundColor = props.SelectedBackgroundColor,
			DisabledBackgroundColor = props.DisabledBackgroundColor,

			CornerRadius = props.CornerRadius,

			UseStroke = props.Stroke,
			StrokeColor = props.StrokeColor or Color3.fromRGB(0, 0, 0),
			StrokeThickness = props.StrokeThickness or 1,

			OnClick = props.LeftOnPress,
		})
	end

	-- RIGHT BUTTON
	if props.RightIcon and props.RightIsButton then
		outside["Right"] = e(ImageButtonComponent, {
			Image = props.RightIcon,
			Size = UDim2.fromScale(1, 1),

			UseAspectRatio = true,
			UseBackground = true,

			Active = props.RightActive,
			BackgroundColor = props.BackgroundColor,
			HoverBackgroundColor = props.HoverBackgroundColor,
			PressedBackgroundColor = props.PressedBackgroundColor,
			SelectedBackgroundColor = props.SelectedBackgroundColor,
			DisabledBackgroundColor = props.DisabledBackgroundColor,

			CornerRadius = props.CornerRadius,

			UseStroke = props.Stroke,
			StrokeColor = props.StrokeColor or Color3.fromRGB(0, 0, 0),
			StrokeThickness = props.StrokeThickness or 1,

			OnClick = props.RightOnPress,
		})
	end

	-- LEFT ICON (STATIC)
	if props.LeftIcon and not props.LeftIsButton then
		inside["LeftIcon"] = e("ImageLabel", {
			Image = props.LeftIcon,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageColor3 = props.LeftIconColor or Color3.new(1, 1, 1),
		}, {
			Aspect = e("UIAspectRatioConstraint", {
				AspectRatio = 1,
			}),
		})
	end

	-- RIGHT ICON (STATIC)
	if props.RightIcon and not props.RightIsButton then
		inside["RightIcon"] = e("ImageLabel", {
			Image = props.RightIcon,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageColor3 = props.RightIconColor or Color3.new(1, 1, 1),
		}, {
			Aspect = e("UIAspectRatioConstraint", {
				AspectRatio = 1,
			}),
		})
	end

	return e("Frame", {
		Size = props.Size,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		BackgroundTransparency = 1,
	}, outside)
end
