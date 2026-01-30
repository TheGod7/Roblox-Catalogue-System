local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages["react-spring"])
local Icons = require(ReplicatedStorage.Shared.ui.Icons)
local colorStyleConstant = require(ReplicatedStorage.Shared.ui.colorStyleConstant)
local PageContext = require(ReplicatedStorage.Shared.ui.context.PageContext)

local e = React.createElement
local useState = React.useState
local useContext = React.useContext

export type Props = {
	Title: string,
	Icon: ImageLabel?,
	children: React.ReactElement,
}

return function(props)
	local ctx = useContext(PageContext.Context)
	local isHovering, setIsHovering = useState(false)
	local isClicked, setIsClicked = useState(false)

	local style = ReactSpring.useSpring({
		scale = if isClicked then 0.95 else if isHovering then 1.2 else 1,
		config = { duration = 0.1 },
	})

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = colorStyleConstant.Secondary,
	}, {

		UICorner = e("UICorner", {
			CornerRadius = UDim.new(0, 10),
		}),
		UIStroke = e("UIStroke", {
			Color = colorStyleConstant.Primary,
			Thickness = 4,
			BorderStrokePosition = Enum.BorderStrokePosition.Inner,
		}),
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Header = e("Frame", {
			Size = UDim2.fromScale(1, 0.08),
			BackgroundTransparency = 0,
			BackgroundColor3 = colorStyleConstant.Primary,
		}, {

			UICorner = e("UICorner", {
				CornerRadius = UDim.new(0, 10),
			}),

			UIListLayout = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,

				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			UIPadding = e("UIPadding", {
				PaddingTop = UDim.new(0, 5),
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			}),

			TitleHeader = e("Frame", {
				Size = UDim2.fromScale(0.3, 1),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
			}, {
				UIListLayout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,

					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,

					VerticalAlignment = Enum.VerticalAlignment.Center,
					VerticalFlex = Enum.UIFlexAlignment.Fill,

					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0.03, 0),
				}),

				Icon = e("ImageLabel", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Image = props.Icon,
				}, {
					UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
						AspectRatio = 1,
					}),
				}),

				Title = e("TextLabel", {
					Size = UDim2.fromScale(0, 1),
					BackgroundTransparency = 1,
					Text = props.Title,
					TextColor3 = colorStyleConstant.white,
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Ubuntu,
				}, {
					UIFlexItem = e("UIFlexItem", {
						FlexMode = Enum.UIFlexMode.Fill,
					}),
					UITextSizeConstraint = e("UITextSizeConstraint", {
						MaxTextSize = 35,
						MinTextSize = 1,
					}),
				}),
			}),

			Space = e("Frame", {
				Size = UDim2.fromScale(0.4, 1),
				BackgroundTransparency = 1,
				LayoutOrder = 2,
			}, {
				UIFlexItem = e("UIFlexItem", {
					FlexMode = Enum.UIFlexMode.Fill,
				}),
			}),

			-- TODO: Search functionality
			SearchFrame = e("Frame", {
				LayoutOrder = 3,
			}),

			Close = e("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				LayoutOrder = 5,
			}, {
				UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
					AspectRatio = 1,
				}),
				CloseButton = e("ImageButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Image = Icons.Close,
					LayoutOrder = 3,

					[React.Event.MouseEnter] = function()
						setIsHovering(true)
					end,

					[React.Event.MouseLeave] = function()
						setIsHovering(false)
						setIsClicked(false)
					end,

					[React.Event.MouseButton1Down] = function()
						setIsClicked(true)
					end,

					[React.Event.MouseButton1Up] = function()
						setIsClicked(false)
					end,

					[React.Event.Activated] = function()
						ctx.setPage(nil)
					end,
				}, {

					UIScale = e("UIScale", {
						Scale = style.scale,
					}),

					UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
						AspectRatio = 1,
					}),
				}),
			}),
		}),

		Content = e("Frame", {
			Size = UDim2.fromScale(1, 0.92),
			BackgroundTransparency = 1,
		}, {
			children = props.children,
		}),
	})
end
