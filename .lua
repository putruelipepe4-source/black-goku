-- BQM Menu - Estilo Dibujo
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui", 10)

-- Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BQM_Menu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Frame principal con estilo dibujo
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 250, 240)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas estilo dibujo
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Borde irregular estilo sketch
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Título del menú
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(255, 220, 180)
Title.BackgroundTransparency = 0.1
Title.BorderSizePixel = 0
Title.Text = "✨ BQM ✨"
Title.TextColor3 = Color3.fromRGB(60, 60, 60)
Title.TextSize = 28
Title.Font = Enum.Font.FredokaOne
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Función para crear botones estilo dibujo
local function createButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0.85, 0, 0, 60)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(255, 240, 220)
    Button.BackgroundTransparency = 0.1
    Button.BorderSizePixel = 2
    Button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextSize = 22
    Button.Font = Enum.Font.FredokaOne
    Button.AutoButtonColor = true
    Button.Parent = MainFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(80, 80, 80)
    BtnStroke.Thickness = 1.5
    BtnStroke.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- Variables para las funciones
local fishingEnabled = false
local minigameEnabled = false
local autoClickerEnabled = false
local emojiFrame = nil

-- Función de Fishing
local function startFishing()
    fishingEnabled = not fishingEnabled
    if fishingEnabled then
        -- Código de fishing aquí
        task.spawn(function()
            while fishingEnabled do
                -- Lógica de fishing con los settings proporcionados
                task.wait(1)
            end
        end)
    end
end

-- Función de Auto Minigame
local function startMinigame()
    minigameEnabled = not minigameEnabled
    if minigameEnabled then
        task.spawn(function()
            local lastClick = 0
            local lastInGreen = false
            
            local function doClick(x, y)
                pcall(function()
                    VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
                    task.wait(0.03)
                    VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
                end)
            end
            
            local function getText()
                local ok, result = pcall(function()
                    for _, g in pairs(PlayerGui:GetDescendants()) do
                        if (g:IsA("TextLabel") or g:IsA("TextButton")) and g.Visible then
                            local t = string.lower(tostring(g.Text or ""))
                            if string.find(t, "hits left") or string.find(t, "tap when") or string.find(t, "green target") then
                                return g
                            end
                        end
                    end
                    return nil
                end)
                return ok and result or nil
            end
            
            local function getBar(textLabel)
                if not textLabel then return nil end
                local best, bestW = nil, 0
                local parents = {}
                if textLabel.Parent then
                    table.insert(parents, textLabel.Parent)
                    if textLabel.Parent.Parent then table.insert(parents, textLabel.Parent.Parent) end
                end
                for _, root in pairs(parents) do
                    for _, g in pairs(root:GetDescendants()) do
                        if (g:IsA("Frame") or g:IsA("ImageLabel")) and g.Visible then
                            local sz = g.AbsoluteSize
                            if sz.X > 180 and sz.Y >= 8 and sz.Y <= 40 and sz.X > bestW then
                                bestW = sz.X
                                best = g
                            end
                        end
                    end
                end
                return best
            end
            
            local function readBar(bar)
                if not bar then return nil end
                local barPos, barSize = bar.AbsolutePosition, bar.AbsoluteSize
                if barSize.X < 50 then return nil end
                local g1, g2, needle = nil, nil, nil
                local roots = {bar}
                if bar.Parent then table.insert(roots, bar.Parent) end
                for _, root in pairs(roots) do
                    for _, g in pairs(root:GetDescendants()) do
                        if g:IsA("GuiObject") and g.Visible then
                            local pos, sz, c = g.AbsolutePosition, g.AbsoluteSize, g.BackgroundColor3
                            local name = string.lower(g.Name)
                            local rel = ((pos.X + sz.X / 2) - barPos.X) / barSize.X
                            if rel >= -0.05 and rel <= 1.05 then
                                if c.G > 0.5 and c.G > c.R + 0.2 and c.G > c.B + 0.15 and sz.X > 20 and sz.Y >= 4 then
                                    g1 = math.clamp((pos.X - barPos.X) / barSize.X, 0, 1)
                                    g2 = math.clamp((pos.X + sz.X - barPos.X) / barSize.X, 0, 1)
                                end
                                local thin = sz.X <= 10 and sz.Y >= 6
                                local white = c.R > 0.85 and c.G > 0.85 and c.B > 0.85
                                local named = string.find(name, "needle") or string.find(name, "marker") or string.find(name, "cursor") or string.find(name, "pointer") or string.find(name, "tick")
                                if named or (thin and white) or (thin and sz.Y >= barSize.Y * 0.5) then
                                    needle = math.clamp(rel, 0, 1)
                                end
                            end
                        end
                    end
                end
                if g1 and g2 and needle then
                    return {
                        inGreen = (needle >= g1 and needle <= g2),
                        x = barPos.X + barSize.X / 2,
                        y = barPos.Y + barSize.Y / 2
                    }
                end
                return nil
            end
            
            while minigameEnabled do
                local textLbl = getText()
                if textLbl then
                    local info = readBar(getBar(textLbl))
                    if info then
                        if info.inGreen then
                            if not lastInGreen and tick() - lastClick > 0.15 then
                                lastClick = tick()
                                doClick(info.x, info.y)
                            end
                            lastInGreen = true
                        else
                            lastInGreen = false
                        end
                    else
                        lastInGreen = false
                    end
                else
                    lastInGreen = false
                end
                task.wait()
            end
        end)
    end
end

-- Función de Auto Clicker con emoji arrastrable
local function startAutoClicker()
    autoClickerEnabled = not autoClickerEnabled
    
    if autoClickerEnabled then
        -- Crear emoji arrastrable
        emojiFrame = Instance.new("Frame")
        emojiFrame.Name = "EmojiDrag"
        emojiFrame.Size = UDim2.new(0, 60, 0, 60)
        emojiFrame.Position = UDim2.new(0.5, -30, 0.5, -30)
        emojiFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        emojiFrame.BackgroundTransparency = 1
        emojiFrame.BorderSizePixel = 0
        emojiFrame.Parent = ScreenGui
        
        local EmojiLabel = Instance.new("TextLabel")
        EmojiLabel.Size = UDim2.new(1, 0, 1, 0)
        EmojiLabel.BackgroundTransparency = 1
        EmojiLabel.Text = "👆"
        EmojiLabel.TextSize = 50
        EmojiLabel.Font = Enum.Font.GothamBold
        EmojiLabel.Parent = emojiFrame
        
        -- Hacer arrastrable
        local dragging = false
        local dragInput, dragStart, startPos
        
        EmojiLabel.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = emojiFrame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        EmojiLabel.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                emojiFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        -- Auto click en la posición del emoji
        task.spawn(function()
            local lastAutoClick = 0
            local ClickDelay = 0.30
            
            local function doClick(x, y)
                pcall(function()
                    VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
                    task.wait(0.03)
                    VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
                end)
            end
            
            while autoClickerEnabled and emojiFrame do
                if tick() - lastAutoClick >= ClickDelay then
                    lastAutoClick = tick()
                    local pos = emojiFrame.AbsolutePosition
                    local size = emojiFrame.AbsoluteSize
                    doClick(pos.X + size.X / 2, pos.Y + size.Y / 2)
                end
                task.wait()
            end
        end)
    else
        if emojiFrame then
            emojiFrame:Destroy()
            emojiFrame = nil
        end
    end
end

-- Crear botones
local fishingBtn = createButton("🎣 Fishing", UDim2.new(0.075, 0, 0, 70), startFishing)
local minigameBtn = createButton("🎮 Auto Minigame", UDim2.new(0.075, 0, 0, 150), startMinigame)
local clickerBtn = createButton("👆 Auto Clicker", UDim2.new(0.075, 0, 0, 230), startAutoClicker)

-- Botón de cerrar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 150)
CloseBtn.BackgroundTransparency = 0.1
CloseBtn.BorderSizePixel = 2
CloseBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(50, 50, 50)
CloseBtn.TextSize = 24
CloseBtn.Font = Enum.Font.FredokaOne
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Toggle para abrir/cerrar con tecla
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("✨ BQM Menu cargado! Presiona RightShift para abrir/cerrar ✨")
