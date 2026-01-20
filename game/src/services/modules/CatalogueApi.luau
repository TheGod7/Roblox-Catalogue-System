local HttpService = game:GetService("HttpService")

export type SearchParams = {
	Category: number? | string?,
	Subcategory: number? | string?,
	Keyword: string?,
	MinPrice: number?,
	MaxPrice: number?,
	Limit: number?,
	Cursor: string?,
	SortType: number?,
}

export type ItemRef = {
	itemType: string,
	id: number,
}

export type ApiResponse<T> = {
	success: boolean,
	data: T?,
	errorMessage: string?,
	rawBody: string?,
}

local CatalogueApi = {}
CatalogueApi.__index = CatalogueApi

CatalogueApi.SortType = {
	Relevance = 0,
	Recent = 1,
	PriceAsc = 2,
	PriceDesc = 3,
	Favorites = 4,
}

local BASE_URL = "https://10d61219126c.ngrok-free.app"
local ENDPOINTS = {
	SEARCH_ITEMS = "/v1/search/items/details",
	ITEMS_DETAILS = "/v1/catalog/items/details",
}

local function urlEncode(str)
	if str == nil then
		return ""
	end
	str = tostring(str)
	return str:gsub("([^%w%-_.~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

local function buildQuery(params: SearchParams)
	if not params then
		return ""
	end
	local parts = {}
	for k, v in pairs(params) do
		if v ~= nil and v ~= "" then
			table.insert(parts, string.format("%s=%s", urlEncode(k), urlEncode(v)))
		end
	end
	if #parts == 0 then
		return ""
	end
	return "?" .. table.concat(parts, "&")
end

local function safeGet(url: string): ApiResponse<any>
	local ok, res = pcall(function()
		return HttpService:GetAsync(url, true)
	end)
	if not ok then
		return { success = false, errorMessage = tostring(res) }
	end
	local ok2, decoded = pcall(function()
		return HttpService:JSONDecode(res)
	end)
	if not ok2 then
		return { success = true, data = res, rawBody = res }
	end
	return { success = true, data = decoded, rawBody = res }
end

local function safePost(url: string, bodyTable: {}): ApiResponse<any>
	local body = HttpService:JSONEncode(bodyTable)
	local ok, res = pcall(function()
		return HttpService:PostAsync(url, body, Enum.HttpContentType.ApplicationJson)
	end)
	if not ok then
		return { success = false, errorMessage = tostring(res) }
	end
	local ok2, decoded = pcall(function()
		return HttpService:JSONDecode(res)
	end)
	if not ok2 then
		return { success = true, data = res, rawBody = res }
	end
	return { success = true, data = decoded, rawBody = res }
end

function CatalogueApi.configure(baseUrl: string)
	assert(type(baseUrl) == "string" and baseUrl ~= "", "baseUrl debe ser una cadena no vacía")
	BASE_URL = baseUrl
end

function CatalogueApi.buildSearchUrl(params: SearchParams?)
	local p = params or {}
	if p.SortType == nil then
		p.SortType = CatalogueApi.SortType.PriceAsc
	end
	local query = buildQuery(p)
	return BASE_URL .. ENDPOINTS.SEARCH_ITEMS .. query
end

function CatalogueApi.searchItems(params: SearchParams?)
	assert(BASE_URL ~= "", "BASE_URL no configurada. Llama CatalogueApi.configure(baseUrl)")
	local url = CatalogueApi.buildSearchUrl(params)
	return safeGet(url)
end

function CatalogueApi.searchItemsAsc(params: SearchParams?)
	local p = params or {}
	p.SortType = CatalogueApi.SortType.PriceAsc
	return CatalogueApi.searchItems(p)
end

function CatalogueApi.searchItemsDesc(params: SearchParams?)
	local p = params or {}
	p.SortType = CatalogueApi.SortType.PriceDesc
	return CatalogueApi.searchItems(p)
end

function CatalogueApi.getItemsDetails(itemsRefs: { ItemRef })
	assert(BASE_URL ~= "", "BASE_URL no configurada. Llama CatalogueApi.configure(baseUrl)")
	assert(type(itemsRefs) == "table" and #itemsRefs > 0, "itemsRefs debe ser una tabla con al menos 1 item")
	local url = BASE_URL .. ENDPOINTS.ITEMS_DETAILS
	return safePost(url, { items = itemsRefs })
end

function CatalogueApi.fetchNextPage(paramsBase: SearchParams?, cursor: string)
	if not cursor or cursor == "" then
		return { success = false, errorMessage = "Cursor vacío" }
	end
	local params = {}
	if paramsBase then
		for k, v in pairs(paramsBase) do
			params[k] = v
		end
	end
	params.Cursor = cursor
	return CatalogueApi.searchItems(params)
end

return CatalogueApi
