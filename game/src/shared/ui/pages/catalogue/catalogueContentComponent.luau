local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local colorStyleConstant = require(ReplicatedStorage.Shared.ui.colorStyleConstant)

local e = React.createElement

return function(props)
	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 0),
		}),

		LeftPane = e("Frame", {
			Size = UDim2.fromScale(0.3, 1),
			BackgroundTransparency = 1,
			LayoutOrder = 1,
		}, {

			Content = e("Frame", {
				Size = UDim2.fromScale(0.95, 0.95),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundTransparency = 0,
				BackgroundColor3 = colorStyleConstant.Primary,
			}, {
				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),
		}),

		RightPane = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
		}, {
			UIFlexItem = e("UIFlexItem", {
				FlexMode = Enum.UIFlexMode.Fill,
			}),

			Content = e("Frame", {
				Size = UDim2.fromScale(0.99, 0.95),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.493, 0.5),
				BackgroundTransparency = 1,
			}, {
				UIListLayout = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 5),
				}),

				CategorySelector = e("Frame", {
					Size = UDim2.fromScale(1, 0.07),
					BackgroundTransparency = 0,
					BackgroundColor3 = colorStyleConstant.Primary,
				}, {
					UICorner = e("UICorner", {
						CornerRadius = UDim.new(0, 8),
					}),

					UIPadding = e("UIPadding", {
						PaddingLeft = UDim.new(0.01, 0),
						PaddingRight = UDim.new(0.01, 0),
						PaddingTop = UDim.new(0.1, 0),
						PaddingBottom = UDim.new(0.1, 0),
					}),

					UIListLayout = e("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0.02, 0),
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),

					Header = e("Frame", {
						Size = UDim2.fromScale(0.2, 1),
						BackgroundColor3 = colorStyleConstant.Secondary,
						LayoutOrder = 1,
					}, {
						UICorner = e("UICorner", {
							CornerRadius = UDim.new(0, 8),
						}),

						TextLabel = e("TextLabel", {
							Size = UDim2.fromScale(1, 1),
							BackgroundTransparency = 1,
							Text = "Categories",
							TextColor3 = colorStyleConstant.white,
							TextScaled = true,
							Font = Enum.Font.Ubuntu,
						}, {
							UITextSizeConstraint = e("UITextSizeConstraint", {
								MaxTextSize = 30,
							}),
						}),
					}),

					ItemHolder = e("ScrollingFrame", {
						Size = UDim2.fromScale(1, 1),
						LayoutOrder = 2,
						AutomaticCanvasSize = Enum.AutomaticSize.X,
						CanvasSize = UDim2.fromScale(0, 0),
						ScrollingDirection = Enum.ScrollingDirection.X,
						BackgroundColor3 = colorStyleConstant.Secondary,
						BackgroundTransparency = 0,
						ScrollBarThickness = 0,
					}, {
						UIListLayout = e("UIListLayout", {
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
							HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
							VerticalAlignment = Enum.VerticalAlignment.Top,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 5),
						}),

						UIFlexItem = e("UIFlexItem", {
							FlexMode = Enum.UIFlexMode.Fill,
						}),

						UIPadding = e("UIPadding", {
							PaddingLeft = UDim.new(0.01, 0),
							PaddingRight = UDim.new(0.01, 0),
							PaddingTop = UDim.new(0.1, 0),
							PaddingBottom = UDim.new(0.1, 0),
						}),

						UICorner = e("UICorner", {
							CornerRadius = UDim.new(0, 8),
						}),

						Btn = e("ImageButton", {
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundColor3 = colorStyleConstant.Primary,
							Size = UDim2.fromScale(0, 1),
						}, {
							UICorner = e("UICorner", {
								CornerRadius = UDim.new(0, 8),
							}),

							UIListLayout = e("UIListLayout", {
								FillDirection = Enum.FillDirection.Horizontal,
								HorizontalAlignment = Enum.HorizontalAlignment.Left,
								HorizontalFlex = Enum.UIFlexAlignment.SpaceAround,
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, 5),
							}),

							UIPadding = e("UIPadding", {
								PaddingLeft = UDim.new(0.1, 0),
								PaddingRight = UDim.new(0.1, 0),
								PaddingTop = UDim.new(0.1, 0),
								PaddingBottom = UDim.new(0.1, 0),
							}),

							LeftSpace = e("Frame", {
								Size = UDim2.fromScale(0.05, 1),
								BackgroundTransparency = 1,
								LayoutOrder = 0,
							}),

							TextLabel = e("TextLabel", {
								LayoutOrder = 1,
								BackgroundTransparency = 1,
								Text = "Category",
								TextColor3 = colorStyleConstant.white,
								AutomaticSize = Enum.AutomaticSize.X,
								TextScaled = true,
								Size = UDim2.fromScale(0, 1),
								Font = Enum.Font.Ubuntu,
							}, {
								UITextSizeConstraint = e("UITextSizeConstraint", {
									MaxTextSize = 30,
								}),
							}),

							RightSpace = e("Frame", {
								Size = UDim2.fromScale(0.05, 1),
								BackgroundTransparency = 1,
								LayoutOrder = 2,
							}),
						}),
					}),
				}),
			}),
		}),
	})
end
