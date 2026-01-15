local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local ImageButtonComponent = require(ReplicatedStorage.Shared.components.core.ImageButtonComponent)
local UiIconList = require(ReplicatedStorage.Shared.UI.Images)
local TextInputComponent = require(ReplicatedStorage.Shared.components.core.TextInputComponent)

local e = React.createElement
local useState = React.useState

export type HeaderProps = {
	Title: string,

	OnBack: (() -> ())?,

	OnSearchChange: ((text: string) -> ())?,
	OnSearchSubmit: ((text: string) -> ())?,
}

return function(props: HeaderProps)
	local searchText, setSearchText = useState("")
	local showClearButton = searchText ~= ""

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.07),
		BackgroundTransparency = 1,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.Name,
			Padding = UDim.new(0.02, 0),
		}),

		A_BackButton = e(ImageButtonComponent, {
			Image = UiIconList.GetIconUrl(UiIconList.Icons.Close),
			Size = UDim2.fromScale(1, 1),

			UseBackground = true,
			UseAspectRatio = true,
			AspectRatio = 1,

			OnClick = props.OnBack,

			BackgroundColor = Color3.fromRGB(35, 35, 35),
			HoverBackgroundColor = Color3.fromRGB(45, 45, 45),
			PressedBackgroundColor = Color3.fromRGB(25, 25, 25),
			SelectedBackgroundColor = Color3.fromRGB(55, 55, 55),
			DisabledBackgroundColor = Color3.fromRGB(28, 28, 28),

			CornerRadius = 8,

			UseStroke = true,
			StrokeThickness = 1,

			StrokeColor = Color3.fromRGB(0, 0, 0),
		}),

		B_SearchBarContainer = e("Frame", {
			Size = UDim2.fromScale(0.5, 1),
			BackgroundTransparency = 1,
		}, {
			SearchBar = e(TextInputComponent, {
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0, 0),
				AnchorPoint = Vector2.new(0, 0),

				Text = searchText,

				PlaceholderText = "Search...",
				PlaceholderColor = Color3.fromRGB(150, 150, 150),

				TextColor = Color3.fromRGB(255, 255, 255),
				TextSize = 14,

				BackgroundColor = Color3.fromRGB(35, 35, 35),
				CornerRadius = 5,

				Stroke = true,
				StrokeThickness = 1,

				LeftIcon = UiIconList.GetIconUrl(UiIconList.Icons.Search),
				LeftIconColor = Color3.fromRGB(150, 150, 150),
				LeftIsButton = false,

				RightIcon = showClearButton and UiIconList.GetIconUrl(UiIconList.Icons.Close) or nil,
				RightIconColor = Color3.fromRGB(255, 255, 255),
				RightIsButton = showClearButton,

				RightOnPress = function()
					setSearchText("")
					if props.OnSearchChange then
						props.OnSearchChange("")
					end
				end,
				OnTextChanged = function(text)
					setSearchText(text)
					if props.OnSearchChange then
						props.OnSearchChange(text)
					end
				end,

				OnFocusLost = function(enterPressed)
					if enterPressed and props.OnSearchSubmit then
						props.OnSearchSubmit(searchText)
					end
				end,
			}),
		}),

		C_HeaderText = e("TextLabel", {
			Text = props.Title or "",
			Size = UDim2.fromScale(0, 1),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		}, {
			UICorner = e("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),

			UIStroke = e("UIStroke", {
				Color = Color3.fromRGB(0, 0, 0),
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			}),

			Flex = e("UIFlexItem", {
				FlexMode = Enum.UIFlexMode.Fill,
			}),
		}),
	})
end
