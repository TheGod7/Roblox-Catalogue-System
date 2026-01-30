local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CatalogueApi = require(ReplicatedStorage.Shared.catalogue.CatalogueApiTypes)
local React = require(ReplicatedStorage.Packages.React)
local CatalogueCategories = require(ReplicatedStorage.Shared.catalogue.CatalogueCategories)

export type FilterContextType = {
	filters: CatalogueApi.SearchParams,

	selectCategory: (categoryId: string) -> (),
	selectSubcategory: (subcategoryId: string) -> (),
	selectKeyword: (keyword: string) -> (),
	setPriceRange: (min: number?, max: number?) -> (),

	clearFilters: () -> (),

	search: (cursor: string?) -> CatalogueApi.ApiResponse<any>,
}

local FilterContext = React.createContext(nil)

local e = React.createElement
local useState = React.useState

local function FilterProvider(props)
	local filters, setFilters = useState({
		Category = "All",
	} :: CatalogueApi.SearchParams)

	local function selectCategory(categoryId)
		setFilters(function(prev)
			for _, category in ipairs(CatalogueCategories) do
				if category.Id == categoryId or category.name == categoryId then
					local clone = table.clone(prev)

					local sub = nil
					if category.subcategories and #category.subcategories > 0 then
						sub = category.subcategories[1].name
					end

					clone.Category = category.name
					clone.Subcategory = sub

					return clone
				end
			end

			return prev
		end)
	end

	local function selectSubcategory(subcategoryId)
		setFilters(function(prev)
			for _, category in ipairs(CatalogueCategories) do
				if category.name == prev.Category then
					if category.subcategories then
						for _, sub in ipairs(category.subcategories) do
							if sub.name == subcategoryId or sub.Id == subcategoryId then
								if prev.Subcategory == sub.name then
									return prev
								end

								local clone = table.clone(prev)
								clone.Subcategory = sub.name
								return clone
							end
						end
					end
				end
			end

			return prev
		end)
	end

	return e(FilterContext.Provider, {
		value = {
			filters = filters,
			selectCategory = selectCategory,
			selectSubcategory = selectSubcategory,
		},
	}, props.children)
end

return {
	Context = FilterContext,
	Provider = FilterProvider,
}
