local CatalogFilters = {}

CatalogFilters.Categories = {
	All = {
		categoryId = 1,
		assetTypeIds = {
			11,
			2,
			12,
			17,
			18,
			19,
			8,
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			61,
			64,
			65,
			66,
			67,
			68,
			69,
			72,
		},
		bundleTypeIds = { 1, 2, 3, 4 },
	},

	Body = {
		categoryId = 18,
		subcategories = {
			FullBodies = {
				subcategoryId = 37,
				bundleTypeIds = { 1 },
			},
			Hair = {
				subcategoryId = 20,
				assetTypeIds = { 41 },
			},
			DynamicHeads = {
				subcategoryId = 66,
				bundleTypeIds = { 4 },
			},
			ClassicHeads = {
				subcategoryId = 15,
				assetTypeIds = { 17 },
			},
			ClassicFaces = {
				subcategoryId = 10,
				assetTypeIds = { 18 },
			},
		},
	},

	Clothing = {
		categoryId = 3,
		subcategories = {
			TShirts = { subcategoryId = 58, assetTypeIds = { 64 } },
			Shirts = { subcategoryId = 59, assetTypeIds = { 65 } },
			Sweaters = { subcategoryId = 62, assetTypeIds = { 68 } },
			Jackets = { subcategoryId = 61, assetTypeIds = { 67 } },
			Pants = { subcategoryId = 60, assetTypeIds = { 66 } },
			Shorts = { subcategoryId = 63, assetTypeIds = { 69 } },
			DressesSkirts = { subcategoryId = 65, assetTypeIds = { 72 } },
			Shoes = { subcategoryId = 64, bundleTypeIds = { 3 } },

			ClassicShirts = { subcategoryId = 56, assetTypeIds = { 11 } },
			ClassicTShirts = { subcategoryId = 55, assetTypeIds = { 2 } },
			ClassicPants = { subcategoryId = 57, assetTypeIds = { 12 } },
		},
	},

	Accessories = {
		categoryId = 11,
		subcategories = {
			Head = { subcategoryId = 54, assetTypeIds = { 8 } },
			Face = { subcategoryId = 21, assetTypeIds = { 42 } },
			Neck = { subcategoryId = 22, assetTypeIds = { 43 } },
			Shoulder = { subcategoryId = 23, assetTypeIds = { 44 } },
			Front = { subcategoryId = 24, assetTypeIds = { 45 } },
			Back = { subcategoryId = 25, assetTypeIds = { 46 } },
			Waist = { subcategoryId = 26, assetTypeIds = { 47 } },
			Gear = { subcategoryId = 5, assetTypeIds = { 19 } },
		},
	},

	Animations = {
		categoryId = 12,
		subcategories = {
			Bundles = { subcategoryId = 38, bundleTypeIds = { 2 } },
			Emotes = { subcategoryId = 39, assetTypeIds = { 61 } },
		},
	},
}

return CatalogFilters
