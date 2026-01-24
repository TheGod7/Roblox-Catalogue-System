local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Icons = require(ReplicatedStorage.Shared.ui.Icons)

export type PageId = "CurrentlyWearing" | "Saved" | "AvatarLoader" | "Catalogue" | "SaveAs" | "ResetAvatar" | nil

export type PageNavItem = {
	id: PageId,
	icon: string,
	order: number,
	component: any,
}

local Pages: { PageNavItem } = {
	{
		id = "CurrentlyWearing",
		icon = Icons.CurrentlyWearing,
		order = 1,
		component = require(script.Parent.currentlyWearing.currentlyWearingComponent),
	},
	{
		id = "Saved",
		icon = Icons.Saved,
		order = 2,
		component = require(script.Parent.savedOutfits.savedOutfitsComponent),
	},
	{
		id = "AvatarLoader",
		icon = Icons.AvatarLoader,
		order = 3,
		component = require(script.Parent.avatarLoader.avatarLoaderComponent),
	},
	{
		id = "Catalogue",
		icon = Icons.Catalogue,
		order = 4,
		component = require(script.Parent.catalogue.catalogueComponent),
	},
	{
		id = "SaveAs",
		icon = Icons.SaveAs,
		order = 5,
		component = require(script.Parent.saveAs.saveAsComponent),
	},
	{
		id = "ResetAvatar",
		icon = Icons.ResetAvatar,
		order = 6,
		component = require(script.Parent.resetAvatar.resetAvatarComponent),
	},
}

table.sort(Pages, function(a, b)
	return a.order < b.order
end)

return Pages
