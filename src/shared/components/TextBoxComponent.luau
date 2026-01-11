local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement

type Props = {
	Size: UDim2?,
	Position: UDim2?,
	AnchorPoint: Vector2?,

	Text: string?,
	PlaceholderText: string?,

	OnTextChanged: ((string) -> ())?,
	OnFocused: (() -> ())?,
	OnFocusLost: ((boolean) -> ())?,

	BackgroundColor3: Color3?,
	TextColor3: Color3?,
	StrokeColor3: Color3?,
}

local function clampTextSize(containerHeight: number)
	return math.clamp(math.floor(containerHeight * 0.45), 14, 20)
end

return function(props: Props)
	local text, setText = React.useState(props.Text or "")

	local ref = React.useRef(nil :: TextBox?)
	local textSize, setTextSize = React.useState(16)

	React.useEffect(function()
		if ref.current then
			setTextSize(clampTextSize(ref.current.AbsoluteSize.Y))
		end
	end, {})

	return e("TextBox", {
		ref = ref,

		Size = props.Size or UDim2.fromScale(1, 0.1),
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,

		Text = text,
		PlaceholderText = props.PlaceholderText or "Search...",

		ClearTextOnFocus = false,
		TextWrapped = false,
		TextTruncate = Enum.TextTruncate.None,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,

		ClipsDescendants = true,

		TextSize = textSize,
		Font = Enum.Font.GothamMedium,

		BackgroundColor3 = props.BackgroundColor3 or Color3.fromRGB(35, 37, 38),
		TextColor3 = props.TextColor3 or Color3.fromRGB(255, 255, 255),
		PlaceholderColor3 = Color3.fromRGB(163, 163, 163),

		AutomaticSize = Enum.AutomaticSize.None,

		[React.Change.Text] = function(rbx)
			setText(rbx.Text)
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
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0.2, 0),
		}),

		UIPadding = e("UIPadding", {
			PaddingLeft = UDim.new(0.05, 0),
			PaddingRight = UDim.new(0.05, 0),
			PaddingTop = UDim.new(0.22, 0),
			PaddingBottom = UDim.new(0.22, 0),
		}),

		UIStroke = e("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			Color = props.StrokeColor3 or Color3.fromRGB(72, 73, 73),
		}),
	})
end
