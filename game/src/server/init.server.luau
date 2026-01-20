local ServerStorage = game:GetService("ServerStorage")
local CatalogueApi = require(ServerStorage.Services.modules.CatalogueApi)

CatalogueApi.configure("https://65b1770948e6.ngrok-free.app")

local function testSearchAsc()
	local res = CatalogueApi.searchItemsAsc({
		Category = 11,
		Subcategory = 5,
		MinPrice = 50,
		MaxPrice = 200,
		Limit = 10,
	})

	print("TEST ASC SUCCESS:", res.success)
	if res.data then
		for i, item in ipairs(res.data.data or {}) do
			print(i, item.name, item.price)
		end
	else
		warn(res.errorMessage)
	end
end

local function testSearchDesc()
	local res = CatalogueApi.searchItemsDesc({
		Category = 11,
		Subcategory = 5,
		MinPrice = 50,
		MaxPrice = 200,
		Limit = 10,
	})

	print("TEST DESC SUCCESS:", res.success)
	if res.data then
		for i, item in ipairs(res.data.data or {}) do
			print(i, item.name, item.price)
		end
	else
		warn(res.errorMessage)
	end
end

local function testPagination()
	local first = CatalogueApi.searchItemsAsc({
		Category = 11,
		Subcategory = 5,
		Limit = 10,
	})

	print("FIRST PAGE:", first.success)

	if first.data and first.data.nextPageCursor then
		local nextPage = CatalogueApi.fetchNextPage({
			Category = 11,
			Subcategory = 5,
			Limit = 10,
			SortType = CatalogueApi.SortType.PriceAsc,
		}, first.data.nextPageCursor)

		print("NEXT PAGE:", nextPage.success)
	end
end

local function testItemDetails()
	local search = CatalogueApi.searchItems({
		Category = 11,
		Limit = 10,
	})

	if not search.data or not search.data.data then
		warn("No items to test details")
		return
	end

	local refs = {}
	for _, item in ipairs(search.data.data) do
		table.insert(refs, {
			itemType = item.itemType,
			id = item.id,
		})
	end

	local details = CatalogueApi.getItemsDetails(refs)
	print("DETAILS SUCCESS:", details.success)
end

testSearchAsc()
testSearchDesc()
testPagination()
testItemDetails()
