local Icons = {
	BackgroundRobloxAvatarImage = 92691541419335,
	Filter = 104216813561368,
	Search = 75999850037751,
	Close = 80041616701831,
}

local BASE_ASSET_URL = "http://www.roblox.com/asset/?id="

return {
	Icons = Icons,
	GetIconUrl = function(iconId)
		return BASE_ASSET_URL .. iconId
	end,
}
