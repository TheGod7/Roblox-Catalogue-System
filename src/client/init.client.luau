local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReactRoot = require(ReplicatedStorage.Shared.ReactRoot)
local BackgroundComponent = require(ReplicatedStorage.Shared.components.BackgroundComponent)

local root = ReactRoot.new()

root:mount(BackgroundComponent)
