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

	local currentStyle, CurrentApi = ReactSpring.useSpring(function()
		return {
			scale = 0,
			config = { tension = 400, friction = 30 },
		}
	end)

	useEffect(function()
		prevPageRef.current = ctx.page
	end, { ctx.page })

	useEffect(function()
		CurrentApi.start({
			from = { scale = 0 },
			to = { scale = 1 },
		})
	end, { ctx.page })

	local PageComponent = getPageComponent(ctx.page)

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
	}, {

		Page = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
		}, {

			UIScale = e("UIScale", {
				Scale = currentStyle.scale,
			}),
			UIAspectRatioConstraint = e("UIAspectRatioConstraint", {
				AspectRatio = 2,
			}),
			Page = PageComponent and e(PageComponent),
		}),
	})
end
