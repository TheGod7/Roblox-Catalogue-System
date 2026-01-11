local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local CategoriesModule = require(ReplicatedStorage.Shared.api.CatalogCategories)
local SideMenuCategorySelector = require(ReplicatedStorage.Shared.components.SideMenu.Selector.SideMenuCategorySelector)

local e = React.createElement
local useState = React.useState
local useEffect = React.useEffect

return function()
	local selectedCategoryId, setSelectedCategoryId = useState(CategoriesModule.Categories[1].categoryId)

	local selectedSubcategoryId, setSelectedSubcategoryId = useState(nil)

	local subcategoryNames, setSubcategoryNames = useState({})

	useEffect(function()
		local category = CategoriesModule.GetCategoryByName(nil)

		for _, cat in ipairs(CategoriesModule.Categories) do
			if cat.categoryId == selectedCategoryId then
				category = cat
				break
			end
		end

		local subs = {}
		if category and category.subcategories then
			for _, sub in ipairs(category.subcategories) do
				table.insert(subs, sub.name)
			end
			if #category.subcategories > 0 then
				setSelectedSubcategoryId(category.subcategories[1].subcategoryId)
			else
				setSelectedSubcategoryId(nil)
			end
		else
			setSelectedSubcategoryId(nil)
		end

		setSubcategoryNames(subs)
	end, { selectedCategoryId })

	local categoryNames = {}

	for _, cat in ipairs(CategoriesModule.Categories) do
		table.insert(categoryNames, cat.name)
	end

	print("Selected Category ID:", selectedCategoryId)
	print("Selected sddsdSubcategory ID:", selectedSubcategoryId)
	print("Subcategories:", unpack(subcategoryNames))

	return e("Frame", { Size = UDim2.fromScale(1, 0.3) }, {
		CategoryList = e(SideMenuCategorySelector, {
			Categories = categoryNames,
			SelectedCategoryIndex = selectedCategoryId,
			OnCategorySelected = setSelectedCategoryId,
		}),
	})
end
