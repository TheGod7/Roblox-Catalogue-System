local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local ReactRoot = {}
ReactRoot.__index = ReactRoot

export type ReactRoot = {
	_screenGui: ScreenGui,
	_root: ReactRoblox.RootType,
	mount: (element: any) -> nil,
	Destroy: (self: ReactRoot) -> nil,
}

function ReactRoot.new(): ReactRoot
	local self = setmetatable({} :: ReactRoot, ReactRoot)
	self:_init()
	return self
end

function ReactRoot.mount(self: ReactRoot, element)
	local app = React.createElement(element)
	self._root:render(app)
end

function ReactRoot._init(self: ReactRoot)
	local player = Players.LocalPlayer
	assert(player, "ReactRoot must be created on the client")

	local playerGui = player:WaitForChild("PlayerGui")

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ReactRoot"
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	screenGui.ClipToDeviceSafeArea = false
	screenGui.Parent = playerGui

	self._screenGui = screenGui
	self._root = ReactRoblox.createRoot(screenGui)
end

function ReactRoot.Destroy(self: ReactRoot)
	if self._root then
		self._root:unmount()
	end

	if self._screenGui then
		self._screenGui:Destroy()
	end
end

return ReactRoot
