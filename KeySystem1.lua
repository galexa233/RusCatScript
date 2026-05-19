-- Оригинальный секретный ключ (Строго с xxx, как ты просил)
local CORRECT_KEY = "RusCatScript-145-145-146-147-xxx-KEYSYSTEM"
local KEY_LINK = "https://lootdest.org/s?IVCaRWpa"

-- Полная очистка старых версий интерфейсов и построек
if game.CoreGui:FindFirstChild("AntTurboHorizontalGui") then game.CoreGui.AntTurboHorizontalGui:Destroy() end
if game.CoreGui:FindFirstChild("RusCatKeySystemGui") then game.CoreGui.RusCatKeySystemGui:Destroy() end
if workspace:FindFirstChild("SafeHouseFolder") then workspace.SafeHouseFolder:Destroy() end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "RusCatKeySystemGui"
KeyGui.Parent = game.CoreGui

-- Главное окно Ключ-Системы
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 360, 0, 190)
KeyFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Parent = KeyFrame
KeyStroke.Color = Color3.fromRGB(50, 50, 65)
KeyStroke.Thickness = 1.5

-- Заголовок
local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 38)
KeyTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "RUSCAT SCRIPT — KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
KeyTitle.TextSize = 13
KeyTitle.Parent = KeyFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = KeyTitle

local function applyStyle(element, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = element
end

-- Текстовое поле ввода ключа
local EditText = Instance.new("TextBox")
EditText.Name = "EditText"
EditText.Size = UDim2.new(0.9, 0, 0, 35)
EditText.Position = UDim2.new(0.05, 0, 0.32, 0)
EditText.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
EditText.Font = Enum.Font.Gotham
EditText.PlaceholderText = "Enter RusCatScript Key..."
EditText.Text = ""
EditText.TextColor3 = Color3.fromRGB(255, 255, 255)
EditText.TextSize = 10 
EditText.ClearTextOnFocus = false
EditText.Parent = KeyFrame
applyStyle(EditText, 6)

local EditStroke = Instance.new("UIStroke")
EditStroke.Parent = EditText
EditStroke.Color = Color3.fromRGB(35, 35, 45)
EditStroke.Thickness = 1

-- Кнопка получения ссылки (Get Key)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Name = "GetKeyBtn"
GetKeyBtn.Size = UDim2.new(0.43, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 55, 85)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Text = "GET KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(220, 225, 255)
GetKeyBtn.TextSize = 12
GetKeyBtn.Parent = KeyFrame
applyStyle(GetKeyBtn, 6)

-- Кнопка подтверждения (Accept Key)
local AcceptKeyBtn = Instance.new("TextButton")
AcceptKeyBtn.Name = "AcceptKeyBtn"
AcceptKeyBtn.Size = UDim2.new(0.43, 0, 0, 35)
AcceptKeyBtn.Position = UDim2.new(0.52, 0, 0.65, 0)
AcceptKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 75)
AcceptKeyBtn.Font = Enum.Font.GothamBold
AcceptKeyBtn.Text = "ACCEPT KEY"
AcceptKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AcceptKeyBtn.TextSize = 12
AcceptKeyBtn.Parent = KeyFrame
applyStyle(AcceptKeyBtn, 6)


-- ЗАПУСК ОСНОВНОГО СУПЕР-СКРИПТА (После успешной авторизации)
local function runMainScript()
    KeyGui:Destroy() 
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    local PageMain = Instance.new("Frame")
    local PageFarm = Instance.new("Frame")
    local PageInfo = Instance.new("Frame")

    local SafeBaseBtn = Instance.new("TextButton")
    local SetTeamBtn = Instance.new("TextButton")
    local TeleportSugarBtn = Instance.new("TextButton")
    local JustResetBtn = Instance.new("TextButton")
    local KillWoomyBtn = Instance.new("TextButton")

    local DownTaskbar = Instance.new("Frame")
    local TabMainBtn = Instance.new("TextButton")
    local TabFarmBtn = Instance.new("TextButton")
    local TabInfoBtn = Instance.new("TextButton")

    ScreenGui.Name = "AntTurboHorizontalGui"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Главное меню
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    MainFrame.Position = UDim2.new(0.25, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 400, 0, 240) 
    MainFrame.Active = true
    MainFrame.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    UIStroke.Parent = MainFrame
    UIStroke.Color = Color3.fromRGB(50, 50, 65)
    UIStroke.Thickness = 1.5

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ANT SIMPLE — RUSCAT HUB"
    Title.TextColor3 = Color3.fromRGB(240, 240, 245)
    Title.TextSize = 13.000
    local MainTitleCorner = Instance.new("UICorner")
    MainTitleCorner.CornerRadius = UDim.new(0, 10)
    MainTitleCorner.Parent = Title

    local function setupPage(page, name)
        page.Name = name
        page.Parent = MainFrame
        page.BackgroundTransparency = 1
        page.Position = UDim2.new(0, 0, 0, 35)
        page.Size = UDim2.new(1, 0, 0, 165)
        page.Visible = false
    end

    setupPage(PageMain, "PageMain")
    setupPage(PageFarm, "PageFarm")
    setupPage(PageInfo, "PageInfo")
    PageMain.Visible = true

    -- Элементы вкладки MAIN
    SafeBaseBtn.Parent = PageMain
    SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(45, 60, 110)
    SafeBaseBtn.Position = UDim2.new(0.05, 0, 0.08, 0)
    SafeBaseBtn.Size = UDim2.new(0.9, 0, 0, 35)
    SafeBaseBtn.Font = Enum.Font.GothamBold
    SafeBaseBtn.Text = "SAFE HOUSE [OFF]"
    SafeBaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SafeBaseBtn.TextSize = 12
    applyStyle(SafeBaseBtn, 6)

    -- Кнопка SET TEAM: HUMAN
    SetTeamBtn.Parent = PageMain
    SetTeamBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
    SetTeamBtn.Position = UDim2.new(0.05, 0, 0.33, 0)
    SetTeamBtn.Size = UDim2.new(0.9, 0, 0, 35)
    SetTeamBtn.Font = Enum.Font.GothamBold
    SetTeamBtn.Text = "SET TEAM: HUMAN"
    SetTeamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SetTeamBtn.TextSize = 12
    applyStyle(SetTeamBtn, 6)

    TeleportSugarBtn.Parent = PageMain
    TeleportSugarBtn.BackgroundColor3 = Color3.fromRGB(140, 70, 160)
    TeleportSugarBtn.Position = UDim2.new(0.05, 0, 0.58, 0)
    TeleportSugarBtn.Size = UDim2.new(0.43, 0, 0, 45)
    TeleportSugarBtn.Font = Enum.Font.GothamBold
    TeleportSugarBtn.Text = "TELEPORT\nSUGAR"
    TeleportSugarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportSugarBtn.TextSize = 11.000
    applyStyle(TeleportSugarBtn, 6)

    JustResetBtn.Parent = PageMain
    JustResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    JustResetBtn.Position = UDim2.new(0.52, 0, 0.58, 0)
    JustResetBtn.Size = UDim2.new(0.43, 0, 0, 45)
    JustResetBtn.Font = Enum.Font.GothamBold
    JustResetBtn.Text = "QUICK\nRESET"
    JustResetBtn.TextColor3 = Color3.fromRGB(230, 230, 235)
    JustResetBtn.TextSize = 11.000
    applyStyle(JustResetBtn, 6)

    -- Элементы вкладки FARM
    KillWoomyBtn.Parent = PageFarm
    KillWoomyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    KillWoomyBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
    KillWoomyBtn.Size = UDim2.new(0.8, 0, 0, 80)
    KillWoomyBtn.Font = Enum.Font.GothamBold
    KillWoomyBtn.Text = "AUTO FARM SEED\n[OFF]"
    KillWoomyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    KillWoomyBtn.TextSize = 15.000
    applyStyle(KillWoomyBtn, 6)

    -- Элементы вкладки INFO
    local InfoText = Instance.new("TextLabel")
    InfoText.Parent = PageInfo
    InfoText.BackgroundTransparency = 1
    InfoText.Size = UDim2.new(1, 0, 1, 0)
    InfoText.Font = Enum.Font.Gotham
    InfoText.Text = "Project: RusCatScript v4.0\nStatus: Key Authenticated\nDownTaskbar Setup: Enabled\nSafe Sky Terrain & Water Block: Engaged"
    InfoText.TextColor3 = Color3.fromRGB(170, 170, 185)
    InfoText.TextSize = 13.000

    -- Панель DownTaskbar
    DownTaskbar.Parent = MainFrame
    DownTaskbar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    DownTaskbar.Position = UDim2.new(0, 0, 0.83, 0)
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

    TabMainBtn.Parent = DownTaskbar
    TabMainBtn.Size = UDim2.new(0.333, 0, 1, 0)
    TabMainBtn.Position = UDim2.new(0, 0, 0, 0)
    applyTabStyle(TabMainBtn, "MAIN")
    TabMainBtn.TextColor3 = Color3.fromRGB(100, 180, 255)

    TabFarmBtn.Parent = DownTaskbar
    TabFarmBtn.Size = UDim2.new(0.333, 0, 1, 0)
    TabFarmBtn.Position = UDim2.new(0.333, 0, 0, 0)
    applyTabStyle(TabFarmBtn, "AUTO FARM SEED")

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
    -- ЛОГИКА НАЖАТИЙ КНОПОК ОСНОВНОГО МЕНЮ
    ---------------------------------------------------------------------
    local player = game.Players.LocalPlayer

    -- Обработка смены команды (Проверка по имени, цвету и ивентам)
    SetTeamBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local teams = game:GetService("Teams")
            local potentialColors = {BrickColor.new("White"), BrickColor.new("Institutional white"), BrickColor.new("Bright yellow")}
            local found = false
            
            for _, team in pairs(teams:GetTeams()) do
                local matchName = team.Name:lower():match("human")
                local matchColor = false
                for _, color in pairs(potentialColors) do
                    if team.TeamColor == color then matchColor = true break end
                end
                
                if matchName or matchColor then
                    player.Team = team
                    player.TeamColor = team.TeamColor
                    
                    for _, v in pairs(game:GetDescendants()) do
                        if v:IsA("RemoteEvent") and (v.Name:lower():match("team") or v.Name:lower():match("join")) then
                            v:FireServer(team.Name)
                        end
                    end
                    found = true
                    break
                end
            end
            
            if found then
                SetTeamBtn.Text = "TEAM ASSIGNED!"
                SetTeamBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 75)
            else
                SetTeamBtn.Text = "TEAM NOT FOUND"
                SetTeamBtn.BackgroundColor3 = Color3.fromRGB(140, 50, 50)
            end
            task.wait(1)
            SetTeamBtn.Text = "SET TEAM: HUMAN"
            SetTeamBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
        end)
    end)

    SafeBaseBtn.MouseButton1Click:Connect(function()
        _G.SafeBaseActive = not _G.SafeBaseActive
        toggleSafeHouse(_G.SafeBaseActive)
        if _G.SafeBaseActive then
            SafeBaseBtn.Text = "SAFE HOUSE [ON]"
            SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(55, 130, 90)
        else
            SafeBaseBtn.Text = "SAFE HOUSE [OFF]"
            SafeBaseBtn.BackgroundColor3 = Color3.fromRGB(45, 60, 110)
        end
    end)

    TeleportSugarBtn.MouseButton1Click:Connect(function()
        if _G.SafeBaseActive then
            pcall(function()
                local targetPos = CFrame.new(1000, 515, 1000).Position + Vector3.new(0, 3, 0)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name:lower():match("sugar") then
                        obj.Anchored = true
                        obj.CFrame = CFrame.new(targetPos + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                        obj.Anchored = false
                    end
                end
            end)
        end
    end)

    JustResetBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.Health = 0 end
        end)
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
end

---------------------------------------------------------------------
-- ИГРОВАЯ ЛОГИКА И ПОСТРОЙКА БУНКЕРА SAFE HOUSE
---------------------------------------------------------------------
_G.WoomyResetLoop = false
_G.SafeBaseActive = false

local player = game.Players.LocalPlayer
local houseFolder = nil 

local baseCFrame = CFrame.new(1000, 500, 1000)        
local secondFloorCFrame = CFrame.new(1000, 515, 1000) 
local roofCFrame = CFrame.new(1000, 530, 1000)        

function toggleSafeHouse(state)
    if state then
        if not houseFolder then
            houseFolder = Instance.new("Folder")
            houseFolder.Name = "SafeHouseFolder"
            houseFolder.Parent = workspace
        end
        local function createPart(name, size, cframe, color, trans)
            local p = Instance.new("Part")
            p.Name = name p.Size = size p.CFrame = cframe p.Anchored = true p.Color = color
            p.Transparency = trans or 0 p.Parent = houseFolder
        end
        createPart("Floor1", Vector3.new(35, 1, 35), baseCFrame, Color3.fromRGB(30, 30, 40))
        createPart("Floor2", Vector3.new(35, 1, 35), secondFloorCFrame, Color3.fromRGB(25, 45, 65))
        createPart("Roof", Vector3.new(35, 1, 35), roofCFrame, Color3.fromRGB(20, 20, 25))
        createPart("Wall1", Vector3.new(1, 32, 35), baseCFrame * CFrame.new(-17.5, 16, 0), Color3.fromRGB(40, 40, 50), 0.4)
        createPart("Wall2", Vector3.new(1, 32, 35), baseCFrame * CFrame.new(17.5, 16, 0), Color3.fromRGB(40, 40, 50), 0.4)
        createPart("Wall3", Vector3.new(35, 32, 1), baseCFrame * CFrame.new(0, 16, -17.5), Color3.fromRGB(40, 40, 50), 0.4)

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

-- Цикл авто-пополнения воды и сбора семян
task.spawn(function()
    while true do
        task.wait()
        
        -- Пополнение воды через GUI
        pcall(function()
            local stats = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data") or player:FindFirstChild("Stats")
            local waterValue = stats and (stats:FindFirstChild("Water") or stats:FindFirstChild("Thirst"))
            if (waterValue and waterValue.Value <= 5) or not waterValue then
                for _, btn in pairs(player.PlayerGui:GetDescendants()) do
                    if btn:IsA("TextButton") and btn.Visible and (btn.Name:lower():match("water") or btn.Text:lower():match("water") or btn.Text:lower():match("пить")) then
                        for _, c in pairs(getconnections(btn.MouseButton1Click)) do c:Fire() end
                        btn:Activate() break
                    end
                end
            end
        end)
        
        -- Удержание в бункере
        if _G.SafeBaseActive and not _G.WoomyResetLoop then
            pcall(function()
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root and (root.Position - secondFloorCFrame.Position).Magnitude > 30 then
                    root.CFrame = secondFloorCFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
        
        -- Сбор семян
        if _G.WoomyResetLoop then
            local egg = workspace:FindFirstChild("WoomyEgg") or workspace:FindFirstChild("WoomyEgg", true)
            if egg then
                pcall(function()
                    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    local seed = nil
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v.Name:lower():match("seed") and v:IsA("BasePart") then seed = v break end
                    end
                    if root and seed and _G.SafeBaseActive then
                        root.CFrame = seed.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.15)
                        root.CFrame = CFrame.new(roofCFrame.Position + Vector3.new(0, 4, 0))
                        task.wait(0.1)
                    end
                end)
                pcall(function()
                    local button = player.PlayerGui.Frame.Woomy.Join
                    if button then button:Activate() end
                    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid.Health = 0 end
                end)
                player.CharacterAdded:Wait()
            else
                _G.WoomyResetLoop = false
            end
        end
    end
end)

---------------------------------------------------------------------
-- ОБРАБОТКА ДЕЙСТВИЙ ОКНА АВТОРИЗАЦИИ
---------------------------------------------------------------------
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
        GetKeyBtn.Text = "LINK COPIED!"
        task.wait(1.5)
        GetKeyBtn.Text = "GET KEY"
    end
end)

AcceptKeyBtn.MouseButton1Click:Connect(function()
    if EditText.Text == CORRECT_KEY then
        AcceptKeyBtn.Text = "ACCESS GRANTED"
        AcceptKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 180, 90)
        task.wait(0.6)
        runMainScript()
    else
        AcceptKeyBtn.Text = "INVALID KEY"
        AcceptKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
        task.wait(1.2)
        AcceptKeyBtn.Text = "ACCEPT KEY"
        AcceptKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 75)
    end
end)
