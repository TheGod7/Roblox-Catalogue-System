local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local Component = require(ReplicatedStorage.Shared.components.catalogue.SideMenu.SideMenuComponent)

local e = React.createElement

return function(parent)
	local root = ReactRoblox.createRoot(parent)
	local app = e(Component)

	root:render(app)

	return function()
		root:unmount()
	end
end
