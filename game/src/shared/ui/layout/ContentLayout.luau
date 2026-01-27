local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages["react-spring"])
local PageContext = require(ReplicatedStorage.Shared.ui.context.PageContext)
local pageNavList = require(ReplicatedStorage.Shared.ui.pages.pageNavList)

local e = React.createElement
local useEffect = React.useEffect
local useRef = React.useRef
local useContext = React.useContext

local function getPageComponent(pageId)
	if not pageId then
		return nil
	end

	for _, page in pageNavList do
		if page.id == pageId then
			return page.component
		end
	end

	return nil
end

return function()
	local ctx = useContext(PageContext.Context)

	local prevPageRef = useRef(nil)

	local currentPagecomponentRef = useRef(nil)
	local prevPageComponentRef = useRef(nil)

	local currentStyle, CurrentApi = ReactSpring.useSpring(function()
		return {
			scale = 0,
			config = { tension = 400, friction = 30 },
			default = true,
		}
	end)

	local PrevPageStyle, PrevPageApi = ReactSpring.useSpring(function()
		return {
			scale = 1,
			config = { tension = 500, duration = 0.2 },
			default = true,
		}
	end)

	local PageComponent = getPageComponent(ctx.page)
	local prevPageComponent = getPageComponent(prevPageRef.current)

	useEffect(function()
		prevPageRef.current = ctx.page
	end, { ctx.page })

	useEffect(function()
		currentPagecomponentRef.current.Visible = false
		prevPageComponentRef.current.Visible = false

		PrevPageApi.start({
			scale = 1,
			immediate = true,
		})

		CurrentApi.start({
			scale = 0,
			immediate = true,
		})

		if prevPageComponent then
			prevPageComponentRef.current.Visible = true
			PrevPageApi.start({
				from = { scale = 1 },
				to = { scale = 0 },
			}):andThen(function()
				prevPageComponentRef.current.Visible = false
				currentPagecomponentRef.current.Visible = true
				CurrentApi.start({
					from = { scale = 0 },
					to = { scale = 1 },
				})
			end)
		else
			currentPagecomponentRef.current.Visible = true
			CurrentApi.start({
				from = { scale = 0 },
				to = { scale = 1 },
			})
		end
	end, { ctx.page })

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
	}, {

		CurentPage = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ref = currentPagecomponentRef,
		}, {

			UIScale = e("UIScale", {
				Scale = currentStyle.scale,
			}),
			UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
				AspectRatio = 2,
			}),
			Page = PageComponent and e(PageComponent),
		}),

		PrevPage = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ref = prevPageComponentRef,
		}, {

			UIScale = e("UIScale", {
				Scale = PrevPageStyle.scale,
			}),
			UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
				AspectRatio = 2,
			}),
			Page = prevPageComponent and e(prevPageComponent),
		}),
	})
end
