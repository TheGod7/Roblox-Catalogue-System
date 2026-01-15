local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local CatalogueApi = require(ReplicatedStorage.Shared.api.CatalogueApi)

local e = React.createElement

local CatalogFilters = require(ReplicatedStorage.Shared.api.CatalogueCategories)
local SideMenuCategorySelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuCategorySelector)
local SideMenuSubCategoriesSelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuSubCategoriesSelector)

local function getFirstCategory()
	for name in pairs(CatalogFilters.Categories) do
		return name
	end
	return nil
end

return function()
	local initialCategory = getFirstCategory()

	local selectedCategory, setSelectedCategory = React.useState(initialCategory)
	local subCategories, setSubCategories = React.useState({})
	local subCategorySelected, setSubCategorySelected = React.useState(nil)

	React.useEffect(function()
		if not selectedCategory then
			return
		end

		local categoryData = CatalogFilters.Categories[selectedCategory]

		if categoryData and categoryData.subcategories then
			local subs = {}
			for subName, subData in pairs(categoryData.subcategories) do
				table.insert(subs, { Name = subName, Data = subData })
			end

			table.sort(subs, function(a, b)
				return a.Data.subcategoryId < b.Data.subcategoryId
			end)

			setSubCategories(subs)

			if #subs > 0 then
				setSubCategorySelected(subs[1].Name)
			else
				setSubCategorySelected(nil)
			end
		else
			setSubCategories({})
			setSubCategorySelected(nil)
		end
	end, { selectedCategory })

	React.useEffect(function()
		if not selectedCategory or not subCategorySelected then
			return
		end

		local result = CatalogueApi.Search({
			Category = selectedCategory,
			Subcategory = subCategorySelected,
		})

		print(result)
	end, { selectedCategory, subCategorySelected })

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
			OnSubCategorySelected = setSubCategorySelected,
		}),
	})
end
