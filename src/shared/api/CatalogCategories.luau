local CategoriesModule = {}

CategoriesModule.Categories = {
	{
		name = "All Items",
		categoryId = 1,
		subcategories = {},
	},
	{
		name = "Body",
		categoryId = 18,
		subcategories = {
			{ name = "Full Bodies", subcategoryId = 37 },
			{ name = "Hair", subcategoryId = 20 },
			{ name = "Heads", subcategoryId = 66 },
			{ name = "Classic Heads", subcategoryId = 15 },
			{ name = "Classic Faces", subcategoryId = 10 },
		},
	},
	{
		name = "Clothing",
		categoryId = 3,
		subcategories = {
			{ name = "T-Shirts", subcategoryId = 58 },
			{ name = "Shirts", subcategoryId = 59 },
			{ name = "Sweaters", subcategoryId = 62 },
			{ name = "Jackets", subcategoryId = 61 },
			{ name = "Pants", subcategoryId = 60 },
			{ name = "Shorts", subcategoryId = 63 },
			{ name = "Dresses & Skirts", subcategoryId = 65 },
			{ name = "Shoes", subcategoryId = 64 },
			{ name = "Classic Shirts", subcategoryId = 56 },
			{ name = "Classic T-Shirts", subcategoryId = 55 },
			{ name = "Classic Pants", subcategoryId = 57 },
		},
	},
	{
		name = "Accessories",
		categoryId = 11,
		subcategories = {
			{ name = "Head", subcategoryId = 54 },
			{ name = "Face", subcategoryId = 21 },
			{ name = "Neck", subcategoryId = 22 },
			{ name = "Shoulder", subcategoryId = 23 },
			{ name = "Front", subcategoryId = 24 },
			{ name = "Back", subcategoryId = 25 },
			{ name = "Waist", subcategoryId = 26 },
			{ name = "Gear", subcategoryId = 5 },
		},
	},
	{
		name = "Animations",
		categoryId = 12,
		subcategories = {
			{ name = "Bundles", subcategoryId = 38 },
			{ name = "Emotes", subcategoryId = 39 },
		},
	},
}

function CategoriesModule.GetCategoryByName(name)
	for _, cat in ipairs(CategoriesModule.Categories) do
		if cat.name == name then
			return cat
		end
	end
	return nil
end

function CategoriesModule.GetSubcategoryByName(categoryName, subcategoryName)
	local cat = CategoriesModule.GetCategoryByName(categoryName)
	if cat and cat.subcategories then
		for _, sub in ipairs(cat.subcategories) do
			if sub.name == subcategoryName then
				return sub
			end
		end
	end
	return nil
end

return CategoriesModule
