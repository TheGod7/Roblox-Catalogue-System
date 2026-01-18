local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SideMenuHeader = require(script.Parent.SideMenuHeader)
local SideMenuItemHolder = require(script.Parent.SideMenuItemHolder)
local SideMenuSelector = require(script.Parent.SideMenuSelector)
local React = require(ReplicatedStorage.Packages.React)
local CatalogueApi = require(ReplicatedStorage.Shared.api.CatalogueApi)

local e = React.createElement
local useEffect = React.useEffect

return function()
	local items, setItems = React.useState({})
	local loading, setLoading = React.useState(false)

	local cursor, setCursor = React.useState(nil)

	local filters, setFilters = React.useState({
		Category = nil :: string?,
		Subcategory = nil :: string?,
		Keyword = nil :: string?,
		MinPrice = nil :: number?,
		MaxPrice = nil :: number?,
		Limit = 30 :: number?,
		Cursor = nil :: string?,
	})

	useEffect(function()
		setLoading(true)

		local requestFilters = {}
		for k, v in pairs(filters) do
			requestFilters[k] = v
		end

		if requestFilters.Category == "All" then
			requestFilters.Subcategory = nil
		end

		local result = CatalogueApi.Search(requestFilters)

		if result and result.data then
			setItems(result.data)
		end

		if result and result.nextPageCursor then
			setCursor(result.nextPageCursor)
		else
			setCursor(nil)
		end

		setLoading(false)
	end, { filters })

	local function getNextPage()
		if loading then
			return
		end

		if not cursor then
			return
		end

		setLoading(true)

		local requestFilters = {}
		for k, v in pairs(filters) do
			requestFilters[k] = v
		end

		requestFilters.Cursor = cursor

		local result = CatalogueApi.Search(requestFilters)

		if result and result.data then
			setItems(function(prevItems)
				local merged = {}

				for i, item in ipairs(prevItems) do
					table.insert(merged, item)
				end

				for i, item in ipairs(result.data) do
					table.insert(merged, item)
				end

				return merged
			end)
		end

		if result and result.nextPageCursor then
			setCursor(result.nextPageCursor)
		else
			setCursor(nil)
		end

		setLoading(false)
	end

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
		SideMenuContainer = e("Frame", {
			Size = UDim2.fromScale(0.7, 1),
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			BackgroundTransparency = 1,
		}, {
			UIPadding = e("UIPadding", {
				PaddingTop = UDim.new(0.1, 0),
			}),

			SideMenu = e("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = Color3.fromHex("#232527"),
				ClipsDescendants = true,
			}, {
				UIPadding = e("UIPadding", {
					PaddingTop = UDim.new(0.02, 0),
					PaddingBottom = UDim.new(0.02, 0),
					PaddingLeft = UDim.new(0.02, 0),
					PaddingRight = UDim.new(0.02, 0),
				}),

				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0.02, 0),
				}),

				BottomMask = e("Frame", {
					Size = UDim2.new(1, 4000, 1, 0),
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0, 0.8),
					BackgroundColor3 = Color3.fromHex("#232527"),
					ZIndex = -1,
				}),

				Layout = e("Frame", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
				}, {
					UILayout = e("UIListLayout", {
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0.02, 0),
					}),
					Header = e(SideMenuHeader, {
						Title = "Catalogue",
						Filters = filters,
						SetFilters = setFilters,
						setItems = setItems,
					}),

					SideMenuSelector = e(SideMenuSelector, {
						Filters = filters,
						SetFilters = setFilters,
						SetItems = setItems,
					}),

					z = e(SideMenuItemHolder, {
						NextPage = getNextPage,
						Items = items,
						Loading = loading,
					}),
				}),
			}),
		}),
	})
end
