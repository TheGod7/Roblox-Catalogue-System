local HttpService = game:GetService("HttpService")

local CatalogCategories = require(script.Parent.CatalogueCategories)

local CatalogService = {}

local SEARCH_URL = "https://catalog.roblox.com/v1/search/items/details"
local ITEM_DETAILS_URL = "https://catalog.roblox.com/v1/catalog/items/details"

local function buildQuery(params)
	local query = {}

	for key, value in pairs(params) do
		if value ~= nil then
			table.insert(query, key .. "=" .. HttpService:UrlEncode(tostring(value)))
		end
	end

	return table.concat(query, "&")
end

local function get(url)
	local success, response = pcall(function()
		return HttpService:GetAsync(url)
	end)

	if not success then
		warn("[CatalogService] GET failed:", response)
		return nil
	end

	return HttpService:JSONDecode(response)
end

local function resolveCategory(categoryName)
	local category = CatalogCategories.Categories[categoryName]
	assert(category, "Unknown category: " .. tostring(categoryName))
	return category.categoryId
end

local function resolveSubcategory(categoryName, subcategoryName)
	local category = CatalogCategories.Categories[categoryName]
	assert(category, "Unknown category: " .. tostring(categoryName))
	assert(category.subcategories, "Category has no subcategories: " .. categoryName)

	local sub = category.subcategories[subcategoryName]
	assert(sub, "Unknown subcategory: " .. tostring(subcategoryName))

	return sub.subcategoryId, sub.assetTypeIds, sub.bundleTypeIds
end

function CatalogService.Search(filters)
	assert(type(filters) == "table", "filters table required")
	assert(filters.Category, "Category name is required")
	assert(filters.Subcategory, "Subcategory name is required")

	if filters.MinPrice and filters.MaxPrice then
		assert(filters.MinPrice <= filters.MaxPrice, "MinPrice must be <= MaxPrice")
	end

	local categoryId = resolveCategory(filters.Category)
	local subcategoryId = select(1, resolveSubcategory(filters.Category, filters.Subcategory))

	local query = buildQuery({
		Category = categoryId,
		Subcategory = subcategoryId,
		MinPrice = filters.MinPrice,
		MaxPrice = filters.MaxPrice,
		Keyword = filters.Keyword,
		Limit = filters.Limit or 30,
		cursor = filters.Cursor,
	})

	local response = get(SEARCH_URL .. "?" .. query)
	if not response or not response.data then
		return response
	end

	if filters.MinPrice or filters.MaxPrice then
		local min = filters.MinPrice or 0
		local max = filters.MaxPrice or math.huge

		local filtered = {}
		for _, item in ipairs(response.data) do
			if item.price and item.price >= min and item.price <= max then
				table.insert(filtered, item)
			end
		end

		response.data = filtered
	end

	return response
end

function CatalogService.GetNextPage(previousResponse, filters)
	if not previousResponse or not previousResponse.nextPageCursor then
		return nil
	end

	filters.Cursor = previousResponse.nextPageCursor
	return CatalogService.Search(filters)
end

function CatalogService.GetItemsById(assetIds)
	assert(type(assetIds) == "table", "assetIds must be a table")

	local body = { items = {} }

	for _, id in ipairs(assetIds) do
		table.insert(body.items, {
			itemType = "Asset",
			id = id,
		})
	end

	local success, response = pcall(function()
		return HttpService:PostAsync(
			ITEM_DETAILS_URL,
			HttpService:JSONEncode(body),
			Enum.HttpContentType.ApplicationJson
		)
	end)

	if not success then
		warn("[CatalogService] PostAsync failed:", response)
		return nil
	end

	return HttpService:JSONDecode(response)
end

return CatalogService
