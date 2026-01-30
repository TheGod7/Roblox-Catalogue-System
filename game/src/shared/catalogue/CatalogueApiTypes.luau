export type SearchParams = {
	Category: number | string?,
	Subcategory: number | string?,
	Keyword: string?,
	MinPrice: number?,
	MaxPrice: number?,
	Limit: number?,
	Cursor: string?,
	SortType: number?,
}

export type ApiResponse<T> = {
	success: boolean,
	data: T?,
	errorMessage: string?,
	rawBody: string?,
}

export type SortType = {
	Relevance: number,
	Recent: number,
	PriceAsc: number,
	PriceDesc: number,
	Favorites: number,
}

return {
	SortType = {
		Relevance = 0,
		Recent = 1,
		PriceAsc = 2,
		PriceDesc = 3,
		Favorites = 4,
	},
}
