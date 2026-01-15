local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local SelectorButton = require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SelectorButton)

local e = React.createElement

return function(parent)
	local root = ReactRoblox.createRoot(parent)

	local app = e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
		AllButton = e(SelectorButton, {
			Title = "All",
			Active = true,
			Position = UDim2.fromScale(0.1, 0.2),
			AnchorPoint = Vector2.new(0, 0),
			OnClick = function()
				print("All clicked")
			end,
		}),

		FavoritesButton = e(SelectorButton, {
			Title = "Favorites",
			Active = false,
			Position = UDim2.fromScale(0.1, 0.4),
			AnchorPoint = Vector2.new(0, 0),
			OnClick = function()
				print("Favorites clicked")
			end,
		}),

		RecentButton = e(SelectorButton, {
			Title = "Recent",
			Active = false,
			Position = UDim2.fromScale(0.1, 0.6),
			AnchorPoint = Vector2.new(0, 0),
			OnClick = function()
				print("Recent clicked")
			end,
		}),
	})

	root:render(app)

	return function()
		root:unmount()
	end
end
