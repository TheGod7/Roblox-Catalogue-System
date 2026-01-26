local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages["react-spring"])
local colorStyleConstant = require(ReplicatedStorage.Shared.ui.colorStyleConstant)
local PageContext = require(ReplicatedStorage.Shared.ui.context.PageContext)

local e = React.createElement

type Props = {
	id: string,
	icon: string,
}

return function(props: Props)
	local ctx = React.useContext(PageContext.Context)

	local isSelected = props.id == ctx.page

	local style = ReactSpring.useSpring({
		size = if isSelected then UDim2.fromScale(1.2, 1.2) else UDim2.fromScale(0.9, 0.9),
		config = {
			tension = 600,
			friction = 38,
		},
	})

	return e("ImageButton", {
		ImageTransparency = 1,
		BackgroundColor3 = colorStyleConstant.Secondary,
		Size = style.size,
		[React.Event.Activated] = function()
			if not isSelected then
				ctx.setPage(props.id)
			else
				ctx.setPage(nil)
			end
		end,
	}, {
		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 6),
		}),
		UIStroke = e("UIStroke", {
			Color = colorStyleConstant.Text,
			Thickness = 2,
			BorderStrokePosition = Enum.BorderStrokePosition.Inner,
		}),
		Icon = e("ImageLabel", {
			Image = props.icon,
			Size = UDim2.fromScale(0.6, 0.6),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
		}),
		UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
			AspectRatio = 1,
		}),
	})
end
