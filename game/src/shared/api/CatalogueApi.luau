local HttpService = game:GetService("HttpService")

local CatalogueCategories = require(script.Parent.CatalogueCategories)

type Json = any
export type Filters = {
	Category: string?,
	Subcategory: string?,
	Keyword: string?,
	MinPrice: number?,
	MaxPrice: number?,
	Limit: number?,
	Cursor: string?,
}

local CatalogService = {}

local BASE_URL = "https://c8f6ca1ff7f2.ngrok-free.app/v1"

local ENDPOINTS = {
	Search = "/search/items/details",
	ItemDetails = "/catalog/items/details",
}

local CACHE_TTL = 30
local Cache: { [string]: { time: number, data: Json } } = {}

local ResolvedCategories = {}
for name, cat in pairs(CatalogueCategories.Categories) do
	ResolvedCategories[name] = {
		id = cat.categoryId,
		sub = cat.subcategories or {},
	}
end

local function buildQuery(params: { [string]: any }): string
	local parts = {}
	for key, value in pairs(params) do
		if value ~= nil then
			parts[#parts + 1] = key .. "=" .. HttpService:UrlEncode(tostring(value))
		end
	end
	return table.concat(parts, "&")
end

local function httpGet(url: string): Json?
	local cached = Cache[url]
	local now = os.clock()

	if cached and (now - cached.time) < CACHE_TTL then
		return cached.data
	end

	local ok, response = pcall(function()
		return HttpService:GetAsync(url)
	end)

	if not ok then
		return nil
	end

	local decodedOk, decoded = pcall(function()
		return HttpService:JSONDecode(response)
	end)

	if not decodedOk then
		return nil
	end

	Cache[url] = {
		time = now,
		data = decoded,
	}

	return decoded
end

function CatalogService.Search(filters: Filters): Json?
	assert(type(filters) == "table")

	if filters.MinPrice and filters.MaxPrice then
		assert(filters.MinPrice <= filters.MaxPrice)
	end

	local queryParams = {
		Keyword = filters.Keyword,
		MinPrice = filters.MinPrice,
		MaxPrice = filters.MaxPrice,
		Limit = filters.Limit or 30,
		cursor = filters.Cursor,
	}

	if filters.Category then
		local cat = ResolvedCategories[filters.Category]
		if not cat then
			error("Unknown category")
		end
		queryParams.Category = cat.id

		if filters.Subcategory then
			local sub = cat.sub[filters.Subcategory]
			if not sub then
				error("Unknown subcategory")
			end
			queryParams.Subcategory = sub.subcategoryId
		end
	end

	local query = buildQuery(queryParams)
	local url = BASE_URL .. ENDPOINTS.Search .. (query ~= "" and ("?" .. query) or "")

	return httpGet(url)
end

function CatalogService.GetNextPage(previousResponse: Json?, filters: Filters): Json?
	if not previousResponse or not previousResponse.nextPageCursor then
		return nil
	end

	local nextFilters = table.clone(filters)
	nextFilters.Cursor = previousResponse.nextPageCursor

	return CatalogService.Search(nextFilters)
end

function CatalogService.GetItemDetails(assetId: number): Json?
	assert(type(assetId) == "number")

	local query = buildQuery({
		itemType = "Asset",
		id = assetId,
	})

	local url = BASE_URL .. ENDPOINTS.ItemDetails .. (query ~= "" and ("?" .. query) or "")
	return httpGet(url)
end

return CatalogService
