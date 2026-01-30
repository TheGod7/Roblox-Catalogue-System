local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CatalogueApiTypes = require(ReplicatedStorage.Shared.catalogue.CatalogueApiTypes)
local CatalogueCategories = require(ReplicatedStorage.Shared.catalogue.CatalogueCategories)

export type SearchParams = CatalogueApiTypes.SearchParams

export type ApiResponse<T> = CatalogueApiTypes.ApiResponse<T>

local CatalogueApi = {}
CatalogueApi.__index = CatalogueApi

CatalogueApi.SortType = CatalogueApiTypes.SortType

local BASE_URL = "https://10d61219126c.ngrok-free.app"
local SEARCH_ENDPOINT = "/v1/search/items/details"

local function urlEncode(value)
	if value == nil then
		return ""
	end
	return tostring(value):gsub("([^%w%-_.~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
end

local function findCategoryIdByName(name: string): number?
	for _, category in ipairs(CatalogueCategories) do
		if string.lower(category.name) == string.lower(name) then
			return category.categoryId
		end
	end
	return nil
end

local function findSubcategoryIdByName(name: string): number?
	for _, category in ipairs(CatalogueCategories) do
		if category.subcategories then
			for _, sub in ipairs(category.subcategories) do
				if string.lower(sub.name) == string.lower(name) then
					return sub.subcategoryId
				end
			end
		end
	end
	return nil
end

local function normalizeParams(params: SearchParams): {}
	local out = {}

	for k, v in pairs(params) do
		if k == "Category" and type(v) == "string" then
			out.Category = findCategoryIdByName(v)
		elseif k == "Subcategory" and type(v) == "string" then
			out.Subcategory = findSubcategoryIdByName(v)
		else
			out[k] = v
		end
	end

	return out
end

local function buildQuery(params: {})
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

function CatalogueApi.configure(baseUrl: string)
	assert(type(baseUrl) == "string" and baseUrl ~= "", "baseUrl inválida")
	BASE_URL = baseUrl
end

function CatalogueApi.buildSearchUrl(params: SearchParams?)
	local p = normalizeParams(params or {})

	if p.SortType == nil then
		p.SortType = CatalogueApi.SortType.Relevance
	end

	if p.Limit == nil then
		p.Limit = 30
	end
	return BASE_URL .. SEARCH_ENDPOINT .. buildQuery(p)
end

function CatalogueApi.searchItems(params: SearchParams?): ApiResponse<any>
	assert(BASE_URL ~= "", "BASE_URL no configurada")
	local url = CatalogueApi.buildSearchUrl(params)
	return safeGet(url)
end

function CatalogueApi.fetchNextPage(paramsBase: SearchParams?, cursor: string)
	if not cursor or cursor == "" then
		return { success = false, errorMessage = "Cursor vacío" }
	end

	local params = paramsBase or {}
	params.Cursor = cursor

	return CatalogueApi.searchItems(params)
end

return CatalogueApi
