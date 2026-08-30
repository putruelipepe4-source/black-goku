-- =============================================================================
-- SCRIPT PREMIUM OPTIMIZADO PARA JNKIE (LUAU) - COMPLETO
-- =============================================================================

-- [+] OPTIMIZACIÓN DE SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- --- CONFIGURACIÓN DE ESTADOS (VARIABLES MÓDULOS) ---
local Modulos = {
    -- General
    Spin = false,
    AutoHeal = false,
    EspSafeZone = false,
    AutoSkipATM = false,
    WalkSpeedValue = 16,
    TpItemsMansion = false,
    -- Combat
    SilentAim = false,
    AiAim = false,
    -- Config
    JoinServerID = "",
    InfoATM = false,
    ShowPing = true,
    FixShowFPS = true
}

-- --- [+] SISTEMA DE FPS Y PING (OPTIMIZADO) ---
local fps = 0
local ping = 0

-- FPS Loop alternativo / Fix
RunService.RenderStepped:Connect(function(deltaTime)
    if Modulos.FixShowFPS then
        fps = math.floor(1 / deltaTime)
    end
end)

-- Ping Loop cada segundo (Ahorro de CPU)
task.spawn(function()
    while task.wait(1) do
        if Modulos.ShowPing then
            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        end
    end
end)

-- --- CREACIÓN DE INTERFAZ GRÁFICA (GUI) ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JnkiePanelPremium"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- [+] BOTÓN CON IMAGEN FLOTANTE
local BotonFlotante = Instance.new("ImageButton")
BotonFlotante.Size = UDim2.new(0, 55, 0, 55)
BotonFlotante.Position = UDim2.new(0, 20, 0, 20)
BotonFlotante.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BotonFlotante.Image = "rbxassetid://6031097229"
local CornerBoton = Instance.new("UICorner", BotonFlotante)
CornerBoton.CornerRadius = UDim.new(0, 12)
BotonFlotante.Parent = ScreenGui

-- Hacer el botón flotante arrastrable (Drag)
local dragging, dragInput, dragStart, startPos
BotonFlotante.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = BotonFlotante.Position
    end
end)
BotonFlotante.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        BotonFlotante.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- VENTANA PRINCIPAL (PANEL)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 320)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Visible = false
local CornerMain = Instance.new("UICorner", MainFrame)
CornerMain.CornerRadius = UDim.new(0, 8)
MainFrame.Parent = ScreenGui

-- Alternar visibilidad con el botón flotante
BotonFlotante.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- PANEL LATERAL (MENÚ DE 4 BOTONES)
local LeftMenu = Instance.new("Frame")
LeftMenu.Size = UDim2.new(0, 140, 1, 0)
LeftMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
LeftMenu.Parent = MainFrame
local CornerLeft = Instance.new("UICorner", LeftMenu)
CornerLeft.CornerRadius = UDim.new(0, 8)

local Layout = Instance.new("UIListLayout")
Layout.Parent = LeftMenu
Layout.Padding = UDim.new(0, 6)

-- CONTENEDOR DERECHO (OPCIONES DINÁMICAS)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -150, 1, -40)
ContentFrame.Position = UDim2.new(0, 145, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentFrame
ContentLayout.Padding = UDim.new(0, 8)

-- TOP STATS (FPS & PING)
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1, -150, 0, 25)
StatsLabel.Position = UDim2.new(0, 145, 0, 5)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatsLabel.TextSize = 12
StatsLabel.Font = Enum.Font.SourceSansBold
StatsLabel.Text = "FPS: 0 | PING: 0 ms"
StatsLabel.Parent = MainFrame

-- Hilo de actualización de Texto Stats
task.spawn(function()
    while task.wait(0.2) do
        StatsLabel.Text = "FPS: " .. fps .. " | PING: " .. ping .. " ms"
    end
end)

-- --- FUNCIONES DEL MENÚ (CAMBIO DE PESTAÑAS) ---
local function LimpiarContenido()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function CrearSwitch(texto, estadoInicial, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 30)
    Frame.BackgroundTransparency = 1
    
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(0.7, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = "[ + ] " .. texto
    Text.TextColor3 = Color3.fromRGB(230, 230, 230)
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Font = Enum.Font.SourceSans
    Text.TextSize = 14
    Text.Parent = Frame
    
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.25, 0, 0, 22)
    Btn.Position = UDim2.new(0.7, 0, 0, 4)
    Btn.BackgroundColor3 = estadoInicial and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(192, 41, 43)
    Btn.Text = estadoInicial and "ON" or "OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local CornerBtn = Instance.new("UICorner", Btn)
    CornerBtn.CornerRadius = UDim.new(0, 4)
    Btn.Parent = Frame
    
    local activo = estadoInicial
    Btn.MouseButton1Click:Connect(function()
        activo = not activo
        Btn.Text = activo and "ON" or "OFF"
        Btn.BackgroundColor3 = activo and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(192, 41, 43)
        callback(activo)
    end)
    
    Frame.Parent = ContentFrame
end

-- PESTAÑA: GENERAL
local function CargarGeneral()
    LimpiarContenido()
    
    CrearSwitch("SPIN (USAR CON ANTI AIM)", Modulos.Spin, function(v) Modulos.Spin = v end)
    CrearSwitch("AUTO HEAL (AUTO BLOOD BAG)", Modulos.AutoHeal, function(v) Modulos.AutoHeal = v end)
    CrearSwitch("ESP VER SI ESTA EN SAFE ZONE", Modulos.EspSafeZone, function(v) Modulos.EspSafeZone = v end)
    CrearSwitch("AUTO SKIP MINIJUEGO DE ATM/FISHING", Modulos.AutoSkipATM, function(v) Modulos.AutoSkipATM = v end)
    CrearSwitch("WALKSPEED (VELOCIDAD)", false, function(v) 
        if v then LocalPlayer.Character.Humanoid.WalkSpeed = 50 else LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
    end)
    CrearSwitch("TP ITEMS (MANSION BETA)", Modulos.TpItemsMansion, function(v) Modulos.TpItemsMansion = v end)
end

-- PESTAÑA: COMBAT
local function CargarCombat()
    LimpiarContenido()
    
    CrearSwitch("Improved Silent Aim accuracy", Modulos.SilentAim, function(v) Modulos.SilentAim = v end)
    CrearSwitch("AI AIM (REVISA MOVIMIENTOS)", Modulos.AiAim, function(v) Modulos.AiAim = v end)
end

-- PESTAÑA: CONFIG
local function CargarConfig()
    LimpiarContenido()
    
    -- TextBox para Join Server ID
    local BoxFrame = Instance.new("Frame")
    BoxFrame.Size = UDim2.new(1, -10, 0, 35)
    BoxFrame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "[ + ] Join Server ID:"
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.
