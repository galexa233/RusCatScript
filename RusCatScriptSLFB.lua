local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftNav = Instance.new("Frame")
local PagesContainer = Instance.new("Frame")
local TopBar = Instance.new("Frame")

-- Состояния
local lp = game.Players.LocalPlayer
local godMode, vipUnlock, noclip, autoFarm = false, false, false, false
local selectedBrainrot = "67"
local safeZonePos = Vector3.new(18.8, 12.26, -30.8)
local isMinimized = false

local brainrots = {
    "Chillin Chilli", "Crazylone Pizaione", "Swag Soda", "Spazio Polare",
    "Tic Tac Sahur", "Nuclearo Dinossauro", "Lna Spaventosa", "Stopppo Luminino",
    "Noo My Valentine", "Castino Fortini", "Los Stawberry Elephantitop",
    "Compactaroni Diskaloni", "67", "Strawberry elephant"
}

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RusCatScript"

-- ГЛАВНОЕ ОКНО
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.Position = UDim2.new(0.5, -200, 0.4, -100)
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- ВЕРХНЯЯ ПАНЕЛЬ
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "  RusCatScript"
Title.TextColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local function toggleMin()
    isMinimized = not isMinimized
    MainFrame:TweenSize(isMinimized and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 400, 0, 200), "Out", "Back", 0.3, true)
end

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Text = "✕"
CloseBtn.Position = UDim2.new(0.9, 0, 0, 0)
CloseBtn.Size = UDim2.new(0.1, 0, 1, 0)
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BackgroundTransparency = 1
CloseBtn.MouseButton1Click:Connect(toggleMin)

-- ЛЕВАЯ НАВИГАЦИЯ
LeftNav.Parent = MainFrame
LeftNav.Position = UDim2.new(0, 0, 0, 30)
LeftNav.Size = UDim2.new(0, 100, 1, -30)
LeftNav.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
Instance.new("UIListLayout", LeftNav)

-- КОНТЕЙНЕР СТРАНИЦ
PagesContainer.Parent = MainFrame
PagesContainer.Position = UDim2.new(0, 105, 0, 35)
PagesContainer.Size = UDim2.new(1, -110, 1, -40)
PagesContainer.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
    local pg = Instance.new("ScrollingFrame", PagesContainer)
    pg.Size = UDim2.new(1, 0, 1, 0)
    pg.BackgroundTransparency = 1
    pg.CanvasSize = UDim2.new(0, 0, 0, 0)
    pg.AutomaticCanvasSize = Enum.AutomaticSize.Y
    pg.ScrollBarThickness = 3
    pg.Visible = false
    Instance.new("UIListLayout", pg).Padding = UDim.new(0, 5)
    pages[name] = pg
    
    local btn = Instance.new("TextButton", LeftNav)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name:upper()
    btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    btn.TextColor3 = Color3.fromRGB(80, 80, 80)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        pg.Visible = true
    end)
    return pg
end

local mainPage = createPage("Main")
local farmPage = createPage("Farm")
local playerPage = createPage("Player")
local guiPage = createPage("GUI")
mainPage.Visible = true

local function addBtn(text, page, color, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(0.9, 0, 0, 32)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() callback(b) end)
end

--- ВКЛАДКА MAIN ---
addBtn("GodMode (Lava): OFF", mainPage, Color3.fromRGB(220, 80, 80), function(b)
    godMode = not godMode
    b.Text = godMode and "GOD: ON" or "GOD: OFF"
    b.BackgroundColor3 = godMode and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(220, 80, 80)
end)

addBtn("Unlock VIP: OFF", mainPage, Color3.fromRGB(140, 100, 200), function(b)
    vipUnlock = not vipUnlock
    b.Text = vipUnlock and "VIP: ON" or "VIP: OFF"
    b.BackgroundColor3 = vipUnlock and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(140, 100, 200)
end)

--- ВКЛАДКА FARM ---
local status = Instance.new("TextLabel", farmPage)
status.Size = UDim2.new(1, 0, 0, 25)
status.Text = "Target: " .. selectedBrainrot
status.TextColor3 = Color3.fromRGB(50, 50, 50)
status.BackgroundTransparency = 1

addBtn("START AUTO FARM", farmPage, Color3.fromRGB(80, 180, 80), function(b)
    autoFarm = not autoFarm
    b.Text = autoFarm and "STOP FARM" or "START FARM"
    b.BackgroundColor3 = autoFarm and Color3.fromRGB(200, 80, 80) or Color3.fromRGB(80, 180, 80)
end)

for _, name in pairs(brainrots) do
    addBtn(name, farmPage, Color3.fromRGB(200, 200, 200), function()
        selectedBrainrot = name
        status.Text = "Target: " .. name
    end)
end

--- ВКЛАДКА PLAYER (Player Settings) ---
addBtn("Speed (80)", playerPage, Color3.fromRGB(100, 100, 100), function() lp.Character.Humanoid.WalkSpeed = 80 end)
addBtn("Jump (120)", playerPage, Color3.fromRGB(100, 100, 100), function() lp.Character.Humanoid.JumpPower = 120 end)
addBtn("Noclip: OFF", playerPage, Color3.fromRGB(100, 100, 100), function(b)
    noclip = not noclip
    b.Text = noclip and "Noclip: ON" or "Noclip: OFF"
end)

--- ВКЛАДКА GUI (GUI Settings) ---
addBtn("Dark Theme", guiPage, Color3.fromRGB(40, 40, 40), function()
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    LeftNav.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

addBtn("White Theme", guiPage, Color3.fromRGB(240, 240, 240), function()
    MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LeftNav.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Title.TextColor3 = Color3.fromRGB(50, 50, 50)
    status.TextColor3 = Color3.fromRGB(50, 50, 50)
    -- Чтобы текст на белой кнопке был виден
    for _, b in pairs(guiPage:GetChildren()) do if b:IsA("TextButton") and b.Text == "White Theme" then b.TextColor3 = Color3.fromRGB(50, 50, 50) end end
end)

-- ЛОГИКА
task.spawn(function()
    while task.wait(0.1) do
        if autoFarm then
            pcall(function()
                local targetObj = workspace.GameFolder.Brainrots.Celestial:FindFirstChild(selectedBrainrot)
                if targetObj then
                    lp.Character.HumanoidRootPart.CFrame = targetObj.RootPart.CFrame
                    task.wait(0.3)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(4.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    lp.Character.HumanoidRootPart.CFrame = CFrame.new(safeZonePos)
                    task.wait(1)
                end
            end)
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if godMode then for _, v in pairs(workspace:GetDescendants()) do if v.Name == "Lava" then v:Destroy() end end end
    if vipUnlock then
        for _, d in pairs(workspace:GetDescendants()) do
            if d.Name == "VIPDoor" and d:IsA("BasePart") then d.CanCollide = false d.Transparency = 0.5 end
        end
    end
    if noclip and lp.Character then
        for _, p in pairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end
end)
