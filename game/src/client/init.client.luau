local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReactRoot = require(ReplicatedStorage.Shared.ReactRoot)
local AppLayout = require(ReplicatedStorage.Shared.ui.layout.AppLayout)

local root = ReactRoot.new()
root:mount(AppLayout)
