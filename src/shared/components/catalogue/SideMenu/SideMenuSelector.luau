local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

local CatalogFilters = require(ReplicatedStorage.Shared.api.CatalogCategories)
local SideMenuCategorySelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuCategorySelector)
local SideMenuSubCategoriesSelector =
	require(ReplicatedStorage.Shared.components.catalogue.SideMenuSelector.SideMenuSubCategoriesSelector)

return function()
	local selectedCategory, setSelectedCategory = React.useState("All")
	local subCategories, setSubCategories = React.useState({})
	local subCategorySelected, setSubCategorySelected = React.useState("")

	React.useEffect(function()
		local categoryData = CatalogFilters.Categories[selectedCategory]

		if categoryData and categoryData.subcategories then
			local subs = {}
			for subName, subData in pairs(categoryData.subcategories) do
				table.insert(subs, { Name = subName, Data = subData })
			end

			setSubCategories(subs)
			if #subs > 0 then
				setSubCategorySelected(subs[1].Name)
			else
				setSubCategorySelected("")
			end
		else
			setSubCategories({})
			setSubCategorySelected("")
		end
	end, { selectedCategory })

	return e("Frame", {
		Size = UDim2.fromScale(1, 0.1),
		BackgroundTransparency = 1,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0.02, 0),
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
