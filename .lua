
-- 🎄 TOM LUA | TOM LIVE ITEMS 🎄

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TomLuaMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainMenu"
frame.Size = UDim2.fromOffset(60, 60)
frame.Position = UDim2.new(0.5, -30, 0.5, -30)
frame.BackgroundColor3 = Color3.fromRGB(100, 0, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 190, 50)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- IMAGEN TOM Y JERRY
local image = Instance.new("ImageLabel")
image.Name = "TomJerryImage"
image.Size = UDim2.fromScale(1, 1)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://99858075849221"
image.ScaleType = Enum.ScaleType.Crop
image.Parent = frame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 8)
imageCorner.Parent = image

-- TOM LUA
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.4, 0)
title.BackgroundColor3 = Color3.fromRGB(100, 0, 20)
title.BackgroundTransparency = 0.15
title.Text = "TOM LUA"
title.TextColor3 = Color3.fromRGB(255, 220, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- TOM LIVE ITEMS
local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.new(0, 0, 0.7, 0)
subtitle.Size = UDim2.new(1, 0, 0.3, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "TOM LIVE ITEMS"
subtitle.TextColor3 = Color3.new(1, 1, 1)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.GothamBold
subtitle.Parent = frame
