local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local ImageButtonComponent = require(ReplicatedStorage.Shared.components.ImageButtonComponent)
local TextBoxComponent = require(ReplicatedStorage.Shared.components.TextBoxComponent)

local e = React.createElement

type HeaderProps = {
	Title: string?,
	OnExit: (() -> ())?,
	OnSearch: (() -> ())?,
	Visible: boolean?,
	ZIndex: number?,
}

return function(props: HeaderProps)
	local isSearching, setIsSearching = React.useState(false)

	local function toggleSearch()
		local nextState = not isSearching
		setIsSearching(nextState)
	end

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.07),
		BackgroundColor3 = Color3.fromRGB(37, 34, 35),
		Visible = props.Visible ~= false,
		ZIndex = props.ZIndex or 1,
	}, {
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0.06, 0),
			PaddingRight = UDim.new(0.06, 0),
			PaddingTop = UDim.new(0.15, 0),
			PaddingBottom = UDim.new(0.15, 0),
		}),

		ExitButton = e(ImageButtonComponent, {
			Size = UDim2.fromScale(0.18, 1),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			OnClicked = props.OnExit or function() end,
		}),

		TitleAndSeach = not isSearching and e("TextLabel", {
			Size = UDim2.fromScale(0.44, 0.6),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),

			Text = props.Title or "Catalogue",
			TextColor3 = Color3.fromRGB(235, 235, 235),
			TextTransparency = 0.05,

			Font = Enum.Font.Roboto,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,

			BackgroundTransparency = 1,
			TextScaled = true,
		}, {
			TextSizeConstraint = e("UITextSizeConstraint", {
				MinTextSize = 14,
				MaxTextSize = 25,
			}),
		}) or e(TextBoxComponent, {
			Size = UDim2.fromScale(0.6, 0.8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		}),

		SearchButton = e(ImageButtonComponent, {
			ImageURL = isSearching and "rbxassetid://10747384394" or "rbxassetid://100298447093768",
			Size = UDim2.fromScale(0.18, 1),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			OnClicked = toggleSearch,
		}),
	})
end
