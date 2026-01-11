local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

local DEFAULT_SIZE = UDim2.fromScale(0.7, 0.1)
local DEFAULT_POSITION = UDim2.fromScale(0.5, 0.5)
local DEFAULT_ASPECT_RATIO = 1
local DEFAULT_ANCHOR_POINT = Vector2.new(0.5, 0.5)

type ButtonProps = {
	Size: UDim2?,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	AspectRatio: number?,
	ImageURL: string,
	OnClicked: () -> (),
}

return function(props: ButtonProps)
	local size = props.Size or DEFAULT_SIZE
	local position = props.Position or DEFAULT_POSITION
	local anchorPoint = props.AnchorPoint or DEFAULT_ANCHOR_POINT
	local aspectRatio = props.AspectRatio or DEFAULT_ASPECT_RATIO

	return e("ImageButton", {
		Size = size,
		Position = position,
		AnchorPoint = anchorPoint,
		BackgroundTransparency = 0,
		Image = props.ImageURL,

		[React.Event.Activated] = props.OnClicked,
	}, {
		AspectRatio = e("UIAspectRatioConstraint", {
			AspectRatio = aspectRatio,
		}),
	})
end
