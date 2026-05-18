-- Очистка старых версий GUI и объектов
if game.CoreGui:FindFirstChild("AntTurboHorizontalGui") then
    game.CoreGui.AntTurboHorizontalGui:Destroy()
end
if workspace:FindFirstChild("SafeHouseFolder") then
    workspace.SafeHouseFolder:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

-- Вкладки (Pages)
local PageMain = Instance.new("Frame")
local PageFarm = Instance.new("Frame")
local PageInfo = Instance.new("Frame")

-- Элементы управления (Вкладка MAIN)
local SafeBaseBtn = Instance.new("TextButton")
local TeleportSugarBtn = Instance.new("TextButton")
local JustResetBtn = Instance.new("TextButton")

-- Элементы управления (Вкладка FARM)
local KillWoomyBtn = Instance.new("TextButton")

-- Нижний Таскбар (DownTaskbar)
local DownTaskbar = Instance.new("Frame")
local TabMainBtn = Instance.new("TextButton")
local TabFarmBtn = Instance.new("TextButton")
local TabInfoBtn = Instance.new("TextButton")

ScreenGui.Name = "AntTurboHorizontalGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главное окно: 400x200
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.Position = UDim2.new(0.25, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(50, 50, 65)
UIStroke.Thickness = 1.5

-- Заголовок Panel
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "ANT SIMPLE — SUGAR MAGNET EDITION"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.TextSize = 13.000
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local function applyButtonStyle(btn)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
end

---------------------------------------------------------------------
-- СОЗДАНИЕ ВКЛАДОК (PAGES)
---------------------------------------------------------------------
local function setupPage(page, name)
    page.Name = name
    page.Parent = MainFrame
    page.BackgroundTransparency = 1
    page.Position = UDim2.new(0, 0, 0, 35)
    page.Size = UDim2.new(1, 0, 0, 125)
    page.Visible = false
end

setupPage(PageMain, "PageMain")
setupPage(PageFarm, "PageFarm")
setupPage(PageInfo, "PageInfo")

PageMain.Visible = true -- Стартовая страница

-- === 1. ЭЛЕМЕНТЫ ВКЛАДКИ MAIN ===
SafeBaseBtn.Name = "SafeBaseBtn"
SafeBaseBtn.Parent = PageMain
SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(45, 60, 110)
SafeBaseBtn.Position = UDim2.new(0.04, 0, 0.15, 0)
SafeBaseBtn.Size = UDim2.new(0.28, 0, 0, 80)
SafeBaseBtn.Font = Enum.Font.GothamBold
SafeBaseBtn.Text = "SAFE HOUSE\n[OFF]"
SafeBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SafeBaseBtn.TextSize = 11.000
applyButtonStyle(SafeBaseBtn)

-- Новая кнопка стягивания Сахара
TeleportSugarBtn.Name = "TeleportSugarBtn"
TeleportSugarBtn.Parent = PageMain
TeleportSugarBtn.BackgroundColor3 = Color3.fromRGB(140, 70, 160)
TeleportSugarBtn.Position = UDim2.new(0.36, 0, 0.15, 0)
TeleportSugarBtn.Size = UDim2.new(0.28, 0, 0, 80)
TeleportSugarBtn.Font = Enum.Font.GothamBold
TeleportSugarBtn.Text = "TELEPORT\nSUGAR"
TeleportSugarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportSugarBtn.TextSize = 11.000
applyButtonStyle(TeleportSugarBtn)

JustResetBtn.Name = "JustResetBtn"
JustResetBtn.Parent = PageMain
JustResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
JustResetBtn.Position = UDim2.new(0.68, 0, 0.15, 0)
JustResetBtn.Size = UDim2.new(0.28, 0, 0, 80)
JustResetBtn.Font = Enum.Font.GothamBold
JustResetBtn.Text = "QUICK\nRESET"
JustResetBtn.TextColor3 = Color3.fromRGB(230, 230, 235)
JustResetBtn.TextSize = 11.000
applyButtonStyle(JustResetBtn)

-- === 2. ЭЛЕМЕНТЫ ВКЛАДКИ AUTO FARM SEED ===
KillWoomyBtn.Name = "KillWoomyBtn"
KillWoomyBtn.Parent = PageFarm
KillWoomyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
KillWoomyBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
KillWoomyBtn.Size = UDim2.new(0.8, 0, 0, 80)
KillWoomyBtn.Font = Enum.Font.GothamBold
KillWoomyBtn.Text = "AUTO FARM SEED\n[OFF]"
KillWoomyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillWoomyBtn.TextSize = 15.000
applyButtonStyle(KillWoomyBtn)

-- === 3. ЭЛЕМЕНТЫ ВКЛАДКИ INFO ===
local InfoText = Instance.new("TextLabel")
InfoText.Parent = PageInfo
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Project: RusCatScript v3.5\nSugar Teleport Feature: Added to House\nTerrain Engine: Mud Roof & Water Base Active\nStatus: Ready for Delta Executor"
InfoText.TextColor3 = Color3.fromRGB(170, 170, 185)
InfoText.TextSize = 13.000

---------------------------------------------------------------------
-- СОЗДАНИЕ НИЖНЕГО ТАСКБАРА (DOWN TASKBAR)
---------------------------------------------------------------------
DownTaskbar.Name = "DownTaskbar"
DownTaskbar.Parent = MainFrame
DownTaskbar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
DownTaskbar.Position = UDim2.new(0, 0, 0.8, 0)
DownTaskbar.Size = UDim2.new(1, 0, 0, 40)

local TaskbarLine = Instance.new("Frame")
TaskbarLine.Parent = DownTaskbar
TaskbarLine.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
TaskbarLine.Size = UDim2.new(1, 0, 0, 1)

local function applyTabStyle(btn, text)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(140, 140, 155)
    btn.TextSize = 11.000
end

TabMainBtn.Name = "TabMainBtn"
TabMainBtn.Parent = DownTaskbar
TabMainBtn.Size = UDim2.new(0.333, 0, 1, 0)
TabMainBtn.Position = UDim2.new(0, 0, 0, 0)
applyTabStyle(TabMainBtn, "MAIN")
TabMainBtn.TextColor3 = Color3.fromRGB(100, 180, 255)

TabFarmBtn.Name = "TabFarmBtn"
TabFarmBtn.Parent = DownTaskbar
TabFarmBtn.Size = UDim2.new(0.333, 0, 1, 0)
TabFarmBtn.Position = UDim2.new(0.333, 0, 0, 0)
applyTabStyle(TabFarmBtn, "AUTO FARM SEED")

TabInfoBtn.Name = "TabInfoBtn"
TabInfoBtn.Parent = DownTaskbar
TabInfoBtn.Size = UDim2.new(0.334, 0, 1, 0)
TabInfoBtn.Position = UDim2.new(0.666, 0, 0, 0)
applyTabStyle(TabInfoBtn, "INFO")

local function switchTab(activePage, activeBtn)
    PageMain.Visible = false
    PageFarm.Visible = false
    PageInfo.Visible = false
    TabMainBtn.TextColor3 = Color3.fromRGB(140, 140, 155)
    TabFarmBtn.TextColor3 = Color3.fromRGB(140, 140, 155)
    TabInfoBtn.TextColor3 = Color3.fromRGB(140, 140, 155)
    activePage.Visible = true
    activeBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
end

TabMainBtn.MouseButton1Click:Connect(function() switchTab(PageMain, TabMainBtn) end)
TabFarmBtn.MouseButton1Click:Connect(function() switchTab(PageFarm, TabFarmBtn) end)
TabInfoBtn.MouseButton1Click:Connect(function() switchTab(PageInfo, TabInfoBtn) end)

---------------------------------------------------------------------
-- СИСТЕМНАЯ ЛОГИКА ДОМА И МУЛЬТИ-ФАРМА
---------------------------------------------------------------------
_G.WoomyResetLoop = false
_G.SafeBaseActive = false

local player = game.Players.LocalPlayer
local houseFolder = nil 

local baseCFrame = CFrame.new(1000, 500, 1000)        
local secondFloorCFrame = CFrame.new(1000, 515, 1000) 
local roofCFrame = CFrame.new(1000, 530, 1000)        

local function createStructure(name, size, cframe, color, transparent, canCollide)
    local part = Instance.new("Part")
    part.Name = name
    part.Size = size
    part.CFrame = cframe
    part.Anchored = true
    part.Color = color
    part.Material = Enum.Material.SmoothPlastic
    part.Transparency = transparent or 0
    part.CanCollide = (canCollide == nil) and true or canCollide
    part.Parent = houseFolder
    return part
end

local function toggleSafeHouse(state)
    if state then
        if not houseFolder then
            houseFolder = Instance.new("Folder")
            houseFolder.Name = "SafeHouseFolder"
            houseFolder.Parent = workspace
        end

        createStructure("Floor1", Vector3.new(35, 1, 35), baseCFrame, Color3.fromRGB(30, 30, 40))
        createStructure("Floor2", Vector3.new(35, 1, 35), secondFloorCFrame, Color3.fromRGB(25, 45, 65))
        createStructure("Roof", Vector3.new(35, 1, 35), roofCFrame, Color3.fromRGB(20, 20, 25))
        
        createStructure("Wall_L", Vector3.new(1, 32, 35), baseCFrame * CFrame.new(-17.5, 16, 0), Color3.fromRGB(40, 40, 50), 0.4)
        createStructure("Wall_R", Vector3.new(1, 32, 35), baseCFrame * CFrame.new(17.5, 16, 0), Color3.fromRGB(40, 40, 50), 0.4)
        createStructure("Wall_B", Vector3.new(35, 32, 1), baseCFrame * CFrame.new(0, 16, -17.5), Color3.fromRGB(40, 40, 50), 0.4)

        -- Ландшафт Terrain (Грязь на крыше, вода на 1 этаже)
        pcall(function()
            workspace.Terrain:FillBlock(roofCFrame * CFrame.new(0, 2, 0), Vector3.new(25, 3, 25), Enum.Material.Mud)
            workspace.Terrain:FillBlock(baseCFrame * CFrame.new(0, 3, 0), Vector3.new(15, 4, 15), Enum.Material.Water)
        end)

        pcall(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = secondFloorCFrame + Vector3.new(0, 3, 0)
            end
        end)
    else
        pcall(function()
            workspace.Terrain:FillBlock(roofCFrame * CFrame.new(0, 2, 0), Vector3.new(27, 5, 27), Enum.Material.Air)
            workspace.Terrain:FillBlock(baseCFrame * CFrame.new(0, 3, 0), Vector3.new(17, 6, 17), Enum.Material.Air)
        end)
        if houseFolder then houseFolder:Destroy() houseFolder = nil end
    end
end

-- Телепорт всего Сахара (Sugar Parts) прямо на 2 этаж дома
local function teleportSugarToHouse()
    pcall(function()
        local targetPos = secondFloorCFrame.Position + Vector3.new(0, 3, 0)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name:lower():match("sugar") then
                -- Отключаем старую привязку, если она есть, и переносим
                obj.Anchored = true
                obj.CFrame = CFrame.new(targetPos + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                obj.Anchored = false
            end
        end
    end)
end

local function checkAndDrinkWater()
    pcall(function()
        local stats = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data") or player:FindFirstChild("Stats")
        local waterValue = stats and (stats:FindFirstChild("Water") or stats:FindFirstChild("Thirst"))
        
        if (waterValue and waterValue.Value <= 5) or not waterValue then
            for _, btn in pairs(player.PlayerGui:GetDescendants()) do
                if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                    local text = btn:IsA("TextButton") and btn.Text:lower() or ""
                    local name = btn.Name:lower()
                    
                    if btn.Visible and (name:match("water") or name:match("drink") or text:match("water") or text:match("пить")) then
                        for _, connection in pairs(getconnections(btn.MouseButton1Click)) do connection:Fire() end
                        btn:Activate()
                        task.wait(0.1)
                        break
                    end
                end
            end
        end
    end)
end

local function findSeed()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():match("seed") and v:IsA("BasePart") then return v end
    end
    return nil
end

local function executeInfFeed()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local seed = findSeed()
    if not seed then return end
    
    local skyDirtPos = roofCFrame.Position + Vector3.new(0, 4, 0)
    
    root.CFrame = seed.CFrame + Vector3.new(0, 2, 0)
    task.wait(0.15)
    root.CFrame = CFrame.new(skyDirtPos)
    task.wait(0.1)
    
    root.CFrame = seed.CFrame + Vector3.new(0, 2, 0)
    task.wait(0.15)
    root.CFrame = CFrame.new(skyDirtPos)
    task.wait(0.1)
    
    root.CFrame = secondFloorCFrame + Vector3.new(0, 3, 0)
    task.wait(0.05)
end

local function forceKillCharacter()
    pcall(function()
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then humanoid.Health = 0 end
    end)
end

local function clickJoin()
    pcall(function()
        local button = player.PlayerGui.Frame.Woomy.Join
        if button then
            for _, connection in pairs(getconnections(button.MouseButton1Click)) do connection:Fire() end
            button:Activate()
        end
    end)
end

local function eggExists()
    return workspace:FindFirstChild("WoomyEgg") or workspace:FindFirstChild("WoomyEgg", true) ~= nil
end

task.spawn(function()
    while true do
        task.wait()
        checkAndDrinkWater()
        
        if _G.SafeBaseActive and not _G.WoomyResetLoop then
            pcall(function()
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root and (root.Position - secondFloorCFrame.Position).Magnitude > 30 then
                    root.CFrame = secondFloorCFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
        
        if _G.WoomyResetLoop then
            if eggExists() then
                if _G.SafeBaseActive then executeInfFeed() end
                clickJoin()
                forceKillCharacter()
                player.CharacterAdded:Wait()
            else
                _G.WoomyResetLoop = false
                KillWoomyBtn.Text = "AUTO FARM SEED\n[OFF]"
                KillWoomyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            end
        end
    end
end)

---------------------------------------------------------------------
-- СКРИПТЫ КНОПОК УПРАВЛЕНИЯ
---------------------------------------------------------------------
SafeBaseBtn.MouseButton1Click:Connect(function()
    _G.SafeBaseActive = not _G.SafeBaseActive
    toggleSafeHouse(_G.SafeBaseActive)
    if _G.SafeBaseActive then
        SafeBaseBtn.Text = "SAFE HOUSE\n[ON]"
        SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(55, 130, 90)
    else
        SafeBaseBtn.Text = "SAFE HOUSE\n[OFF]"
        SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(45, 60, 110)
    end
end)

TeleportSugarBtn.MouseButton1Click:Connect(function()
    if _G.SafeBaseActive then
        teleportSugarToHouse()
    end
end)

JustResetBtn.MouseButton1Click:Connect(function()
    forceKillCharacter()
end)

KillWoomyBtn.MouseButton1Click:Connect(function()
    _G.WoomyResetLoop = not _G.WoomyResetLoop
    if _G.WoomyResetLoop then
        KillWoomyBtn.Text = "AUTO FARM SEED\n[ON]"
        KillWoomyBtn.BackgroundColor3 = Color3.fromRGB(55, 160, 90)
    else
        KillWoomyBtn.Text = "AUTO FARM SEED\n[OFF]"
        KillWoomyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end)
