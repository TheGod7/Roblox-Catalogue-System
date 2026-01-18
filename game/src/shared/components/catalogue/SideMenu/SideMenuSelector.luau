local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

local CatalogFilters = require(ReplicatedStorage.Shared.api.CatalogueCategories)
local SideMenuCategorySelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuCategorySelector)
local SideMenuSubCategoriesSelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuSubCategoriesSelector)

if not CatalogFilters or type(CatalogFilters) ~= "table" then
	CatalogFilters = { Categories = {} }
end

if not CatalogFilters.Categories then
	CatalogFilters.Categories = {}
end

local function getFirstCategory()
	return next(CatalogFilters.Categories)
end

export type Props = {
	SetFilters: ((update: (any) -> any) -> ())?,
	SetItems: (any) -> any,
}

return function(props: Props)
	local initialCategory = getFirstCategory()

	local selectedCategory, setSelectedCategory = React.useState(initialCategory)
	local subCategories, setSubCategories = React.useState({})
	local subCategorySelected, setSubCategorySelected = React.useState(nil)

	local function updateFilters(patch)
		if not props.SetFilters then
			return
		end

		props.SetItems({})

		props.SetFilters(function(prev)
			local newFilters = {}

			if type(prev) == "table" then
				for k, v in pairs(prev) do
					newFilters[k] = v
				end
			end

			for k, v in pairs(patch) do
				newFilters[k] = v
			end

			return newFilters
		end)
	end

	React.useEffect(function()
		if not selectedCategory then
			setSubCategories({})
			setSubCategorySelected(nil)
			props.SetItems({})
			return
		end

		local categoryData = CatalogFilters.Categories[selectedCategory]

		if categoryData and categoryData.subcategories then
			local subs = {}

			for subName, subData in pairs(categoryData.subcategories) do
				table.insert(subs, {
					Name = subName,
					Data = subData,
				})
			end

			table.sort(subs, function(a, b)
				return a.Data.subcategoryId < b.Data.subcategoryId
			end)

			setSubCategories(subs)

			if #subs > 0 then
				setSubCategorySelected(subs[1].Name)
				updateFilters({
					Category = selectedCategory,
					Subcategory = subs[1].Name,
				})
			else
				setSubCategorySelected(nil)
			end
		else
			setSubCategories({})
			setSubCategorySelected(nil)
			updateFilters({
				Category = selectedCategory,
				Subcategory = nil,
			})
		end
	end, { selectedCategory })

	local function setFilterSubCategory(newSubCategory)
		setSubCategorySelected(newSubCategory)

		updateFilters({
			Subcategory = newSubCategory,
		})
	end

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.1),
		BackgroundTransparency = 1,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0.02, 0),
		}),

		Stroke = e("UIStroke", {
			Color = Color3.fromRGB(0, 0, 0),
			Thickness = 1,
		}),

		CategorySelector = e(SideMenuCategorySelector, {
			Categories = CatalogFilters.Categories,
			SelectedCategory = selectedCategory,
			OnCategorySelected = setSelectedCategory,
		}),

		SubCategorySelector = e(SideMenuSubCategoriesSelector, {
			SubCategories = subCategories,
			SelectedSubCategory = subCategorySelected,
			OnSubCategorySelected = setFilterSubCategory,
		}),
	})
end
