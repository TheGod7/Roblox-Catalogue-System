local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

export type PageContextType = {
	page: string,
	setPage: (string) -> (),
}

local PageContext = React.createContext(nil)

local e = React.createElement
local useState = React.useState

local function PageProvider(props)
	local page, setPage = useState(nil)

	return e(PageContext.Provider, {
		value = {
			page = page,
			setPage = setPage,
		},
	}, props.children)
end

return {
	Context = PageContext,
	Provider = PageProvider,
}
