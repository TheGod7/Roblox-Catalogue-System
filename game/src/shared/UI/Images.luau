local Icons = {
	BackgroundRobloxAvatarImage = 92691541419335,
	Filter = 70378591086380,
	Search = 108634535754555,
	Close = 123238586224192,
}

local BASE_ASSET_URL = "rbxassetid://"

return {
	Icons = Icons,
	GetIconUrl = function(iconId)
		return BASE_ASSET_URL .. iconId
	end,
}
