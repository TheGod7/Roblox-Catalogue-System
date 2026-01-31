local ReplicatedStorage = game:GetService("ReplicatedStorage")
local catalogueContentComponent = require(script.Parent.catalogueContentComponent)
local React = require(ReplicatedStorage.Packages.React)
local Icons = require(ReplicatedStorage.Shared.ui.Icons)
local FiltersContext = require(ReplicatedStorage.Shared.ui.context.FiltersContext)
local windowLayout = require(ReplicatedStorage.Shared.ui.layout.windows.windowLayout)

local e = React.createElement

return function(props)
	return e(FiltersContext.Provider, nil, {
		children = e(windowLayout, {
			Title = "Catalogue",
			Icon = Icons.Catalogue,
			children = e(catalogueContentComponent, nil),
		}),
	})
end
