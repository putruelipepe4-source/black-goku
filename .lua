
-- 🎄 TOM LUA - TOM LIVE ITEMS 🎄
-- LocalScript en StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TomLuaMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 10
gui.Parent = player:WaitForChild("PlayerGui")

-- MENU PRINCIPAL
local frame = Instance.new("Frame")
frame.Name = "MainMenu"
frame.Size = UDim2.fromScale(0.92, 0.90)
frame.Position = UDim2.fromScale(0.04, 0.05)
frame.BackgroundColor3 = Color3.fromRGB(75, 0, 20)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = frame

-- IMAGEN ORIGINAL
local image = Instance.new("ImageLabel")
image.Name = "TomJerryBackground"
image.Size = UDim2.fromScale(1, 1)
image.Position = UDim2.fromScale(0, 0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://99858075849221"
image.ScaleType = Enum.ScaleType.Crop
image.ZIndex = 1
image.Parent = frame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 18)
imageCorner.Parent = image

-- TEXTOS EN POSICIONES ALEATORIAS
local textos = {
    "TOM LUA",
    "TOM LIVE ITEMS",
    "TOM LUA",
    "TOM LIVE ITEMS",
    "TOM LUA",
    "TOM LIVE ITEMS",
    "TOM LUA",
    "TOM LIVE ITEMS",
    "TOM LUA"
}

math.randomseed(os.clock() * 100000)

for i, texto in ipairs(textos) do

    local label = Instance.new("TextLabel")
    label.Name = "TomLuaText" .. i
    label.Size = UDim2.fromScale(0.48, 0.07)

    local x = math.random(5, 47) / 100
    local y = math.random(5, 90) / 100

    label.Position = UDim2.fromScale(x, y)
    label.BackgroundColor3 = Color3.fromRGB(90, 0, 20)
    label.BackgroundTransparency = 0.2
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(255, 220, 150)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Rotation = math.random(-12, 12)
    label.ZIndex = 3
    label.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 190, 50)
    stroke.Thickness = 1.5
    stroke.Parent = label

    local labelCorner = Instance.new("UICorner")
    labelCorner.CornerRadius = UDim.new(0, 8)
    labelCorner.Parent = label
end

print("TOM LUA - TOM LIVE ITEMS cargado!")
