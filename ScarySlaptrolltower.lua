-- RusCatScript Ultimate Hub - Complete All-in-One
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🧿 RusCatScript Ultimate v9.0",
    LoadingTitle = "Complete All-in-One System",
    LoadingSubtitle = "ESP + Auto Farm + Player Controls + VIP Tags",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RusCatScriptComplete",
        FileName = "CompleteConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "sirius",
        RememberJoins = true
    },
    KeySystem = false,
})

-- GamePass Configuration
local GamePassID = 1585571770
local VIP = {
    HasVIP = false,
    Price = 100,
    GamePassId = GamePassID,
    Tag = "Scripter VIP"
}

-- Auto Farm Configuration
local WinPositions = {
    Win1 = Vector3.new(57.25, 241.75, 226.75),
    Spawn = Vector3.new(0, 5, 0)
}

local FarmStats = {
    TotalWins = 0,
    IsFarming = false,
    TargetWins = 10
}

-- Player Control Variables
local PlayerControls = {
    Speed = 16,
    JumpPower = 50,
    FlyEnabled = false,
    VFlyEnabled = false,
    FreeCamEnabled = false,
    Noclip = false
}

-- ESP Configuration
local ESPConfig = {
    Enabled = false,
    Boxes = true,
    Names = true,
    Distance = true,
    Health = true,
    ShowHead = true,
    ShowHitbox = true,
    ShowSegments = true,
    Color = Color3.fromRGB(255, 0, 0)
}

local ESPObjects = {}
local Connections = {}

-- ========== AUTO FARM WINS TAB ==========
local FarmTab = Window:CreateTab("🎯 Auto Farm Wins", 1234567890)

-- Position Configuration
local PositionSection = FarmTab:CreateSection("Win Position Settings")

local WinX = FarmTab:CreateInput({
    Name = "Win Position X",
    PlaceholderText = "57.25",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if tonumber(Text) then
            WinPositions.Win1 = Vector3.new(tonumber(Text), WinPositions.Win1.Y, WinPositions.Win1.Z)
        end
    end,
})

local WinY = FarmTab:CreateInput({
    Name = "Win Position Y",
    PlaceholderText = "241.75",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if tonumber(Text) then
            WinPositions.Win1 = Vector3.new(WinPositions.Win1.X, tonumber(Text), WinPositions.Win1.Z)
        end
    end,
})

local WinZ = FarmTab:CreateInput({
    Name = "Win Position Z",
    PlaceholderText = "226.75",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if tonumber(Text) then
            WinPositions.Win1 = Vector3.new(WinPositions.Win1.X, WinPositions.Win1.Y, tonumber(Text))
        end
    end,
})

local SpawnInput = FarmTab:CreateInput({
    Name = "Spawn Position (X,Y,Z)",
    PlaceholderText = "0,5,0",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local x, y, z = Text:match("([%d%-%.]+),([%d%-%.]+),([%d%-%.]+)")
        if x and y and z then
            WinPositions.Spawn = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
        end
    end,
})

-- Farm Control Section
local FarmSection = FarmTab:CreateSection("Farm Control")

local WinsTarget = FarmTab:CreateInput({
    Name = "Target Wins Count (1-100000)",
    PlaceholderText = "10",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local target = tonumber(Text)
        if target and target >= 1 and target <= 100000 then
            FarmStats.TargetWins = target
            UpdateFarmDisplay()
        end
    end,
})

local DelayInput = FarmTab:CreateInput({
    Name = "Farm Delay (Seconds)",
    PlaceholderText = "1",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.FarmDelay = tonumber(Text) or 1
    end,
})

_G.FarmDelay = 1

-- Main Farm Toggle
local AutoFarmToggle = FarmTab:CreateToggle({
    Name = "🔄 Start Auto Win Farm",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            StartWinFarm()
        else
            StopWinFarm()
        end
    end,
})

-- Farm Statistics
local StatsSection = FarmTab:CreateSection("Farm Statistics")

local WinsLabel = FarmTab:CreateLabel("Total Wins: 0")
local TargetLabel = FarmTab:CreateLabel("Target Wins: 10")
local StatusLabel = FarmTab:CreateLabel("Status: Ready")

function UpdateFarmDisplay()
    WinsLabel:Set("Total Wins: " .. FarmStats.TotalWins)
    TargetLabel:Set("Target Wins: " .. FarmStats.TargetWins)
    
    if FarmStats.IsFarming then
        StatusLabel:Set("Status: Farming... (" .. FarmStats.TotalWins .. "/" .. FarmStats.TargetWins .. ")")
    else
        StatusLabel:Set("Status: Ready")
    end
end

-- Farm Functions
function TeleportToPosition(position)
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position)
            return true
        end
    end
    return false
end

function StartWinFarm()
    FarmStats.IsFarming = true
    
    Rayfield:Notify({
        Title = "🚀 Auto Farm Started",
        Content = string.format("Target: %d wins | Delay: %ds", FarmStats.TargetWins, _G.FarmDelay),
        Duration = 5.0,
        Image = 1234567890,
    })
    
    -- Farm coroutine
    coroutine.wrap(function()
        while FarmStats.IsFarming and FarmStats.TotalWins < FarmStats.TargetWins do
            local success = pcall(function()
                -- Teleport to win position
                if TeleportToPosition(WinPositions.Win1) then
                    task.wait(_G.FarmDelay)
                    
                    -- Teleport back to spawn
                    TeleportToPosition(WinPositions.Spawn)
                    task.wait(0.5)
                    
                    -- Increment win counter
                    FarmStats.TotalWins += 1
                    
                    -- Update UI
                    UpdateFarmDisplay()
                    
                    -- Progress notifications
                    if _G.WinNotifications and FarmStats.TotalWins % _G.ProgressInterval == 0 then
                        Rayfield:Notify({
                            Title = "📈 Farm Progress",
                            Content = string.format("Reached %d/%d wins!", FarmStats.TotalWins, FarmStats.TargetWins),
                            Duration = 3.0,
                            Image = 1234567890,
                        })
                    end
                    
                    -- Check if target reached
                    if FarmStats.TotalWins >= FarmStats.TargetWins then
                        StopWinFarm()
                        Rayfield:Notify({
                            Title = "🎉 Target Reached!",
                            Content = string.format("Completed %d wins!", FarmStats.TotalWins),
                            Duration = 8.0,
                            Image = 1234567890,
                        })
                    end
                end
            end)
            
            if not success then
                warn("Farm iteration failed, continuing...")
            end
            
            task.wait(_G.FarmDelay)
        end
    end)()
end

function StopWinFarm()
    FarmStats.IsFarming = false
    UpdateFarmDisplay()
    Rayfield:Notify({
        Title = "⏹️ Farm Stopped",
        Content = string.format("Total Wins: %d", FarmStats.TotalWins),
        Duration = 5.0,
        Image = 1234567890,
    })
end

-- Quick Farm Actions
local ActionsSection = FarmTab:CreateSection("Quick Actions")

local TestWin = FarmTab:CreateButton({
    Name = "🧪 Test Win Position",
    Callback = function()
        if TeleportToPosition(WinPositions.Win1) then
            Rayfield:Notify({
                Title = "✅ Test Successful",
                Content = "Teleported to win position!",
                Duration = 4.0,
                Image = 1234567890,
            })
        end
    end,
})

local ResetCounter = FarmTab:CreateButton({
    Name = "🔄 Reset Win Counter",
    Callback = function()
        FarmStats.TotalWins = 0
        UpdateFarmDisplay()
        Rayfield:Notify({
            Title = "🔄 Counter Reset",
            Content = "Win counter set to 0",
            Duration = 3.0,
            Image = 1234567890,
        })
    end,
})

-- ========== LOCAL PLAYER CONTROLS TAB ==========
local PlayerTab = Window:CreateTab("🎮 Local Player", 1234567890)

-- Speed Section
local SpeedSection = PlayerTab:CreateSection("Movement Controls")

local SpeedSlider = PlayerTab:CreateSlider({
    Name = "🚀 WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = 16,
    Flag = "Speed",
    Callback = function(Value)
        PlayerControls.Speed = Value
        UpdatePlayerSpeed()
    end,
})

local JumpSlider = PlayerTab:CreateSlider({
    Name = "🦘 JumpPower",
    Range = {50, 200},
    Increment = 1,
    Suffix = "power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        PlayerControls.JumpPower = Value
        UpdatePlayerJump()
    end,
})

-- Fly System
local FlySection = PlayerTab:CreateSection("Flight Controls")

local FlyToggle = PlayerTab:CreateToggle({
    Name = "✈️ Enable Fly",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            EnableFly()
        else
            DisableFly()
        end
    end,
})

local FlySpeed = PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 100},
    Increment = 1,
    Suffix = "studs/s",
    CurrentValue = 20,
    Flag = "FlySpeed",
    Callback = function(Value)
        _G.FLYSPEED = Value
    end,
})

-- Movement Functions
function UpdatePlayerSpeed()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = PlayerControls.Speed
        end
    end
end

function UpdatePlayerJump()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = PlayerControls.JumpPower
        end
    end
end

-- Fly System
function EnableFly()
    PlayerControls.FlyEnabled = true
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    _G.FLYSPEED = _G.FLYSPEED or 20
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Name = "RusCatFly"
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
    
    _G.FlyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if PlayerControls.FlyEnabled and character and character:FindFirstChild("HumanoidRootPart") then
            local root = character.HumanoidRootPart
            local camera = workspace.CurrentCamera
            
            local flyDirection = Vector3.new(0, 0, 0)
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                flyDirection = flyDirection + camera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                flyDirection = flyDirection - camera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                flyDirection = flyDirection - camera.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                flyDirection = flyDirection + camera.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                flyDirection = flyDirection + Vector3.new(0, 1, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                flyDirection = flyDirection - Vector3.new(0, 1, 0)
            end
            
            if flyDirection.Magnitude > 0 then
                flyDirection = flyDirection.Unit * _G.FLYSPEED
            end
            
            bodyVelocity.Velocity = flyDirection
            humanoid.PlatformStand = flyDirection.Magnitude > 0
        end
    end)
end

function DisableFly()
    PlayerControls.FlyEnabled = false
    if _G.FlyConnection then
        _G.FlyConnection:Disconnect()
    end
    
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local flyPart = player.Character:FindFirstChild("RusCatFly")
        if flyPart then
            flyPart:Destroy()
        end
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

-- ========== FREE ESP TAB ==========
local ESPTab = Window:CreateTab("👁️ Free ESP", 1234567890)

local ESPToggleSection = ESPTab:CreateSection("ESP Control")

local ESPToggle = ESPTab:CreateToggle({
    Name = "👁️ Enable Enemy ESP (FREE)",
    CurrentValue = false,
    Callback = function(Value)
        ESPConfig.Enabled = Value
        if Value then
            StartESP()
        else
            StopESP()
        end
    end,
})

-- ESP Functions
function CreateESP(object)
    if not object or not object:IsA("BasePart") then return end
    
    local partName = object.Name:lower()
    local shouldHighlight = false
    
    if ESPConfig.ShowHead and partName:find("head") then
        shouldHighlight = true
    elseif ESPConfig.ShowHitbox and partName:find("hitbox") then
        shouldHighlight = true
    elseif ESPConfig.ShowSegments and partName:find("segment") then
        shouldHighlight = true
    end
    
    if not shouldHighlight then return end
    if ESPObjects[object] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "RusCatESP"
    highlight.Adornee = object
    highlight.FillColor = ESPConfig.Color
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = object
    
    if object:FindFirstChildWhichIsA("BillboardGui") == nil then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "RusCatInfo"
        billboard.Adornee = object
        billboard.Size = UDim2.new(0, 200, 0, 100)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 500
        billboard.Parent = object
        
        local label = Instance.new("TextLabel")
        label.Name = "InfoLabel"
        label.BackgroundTransparency = 1
        label.TextSize = 14
        label.TextColor3 = ESPConfig.Color
        label.TextStrokeTransparency = 0
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
        
        UpdateESPInfo(object)
    end
    
    ESPObjects[object] = {
        Highlight = highlight,
        Billboard = object:FindFirstChild("RusCatInfo")
    }
end

function UpdateESPInfo(object)
    if not ESPObjects[object] then return end
    
    local billboard = object:FindFirstChild("RusCatInfo")
    if not billboard then return end
    
    local label = billboard:FindFirstChild("InfoLabel")
    if not label then return end
    
    local infoText = ""
    
    if ESPConfig.Names then
        infoText = infoText .. object.Name .. "\n"
    end
    
    if ESPConfig.Distance then
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (object.Position - player.Character.HumanoidRootPart.Position).Magnitude
            infoText = infoText .. string.format("Dist: %.1f\n", distance)
        end
    end
    
    if ESPConfig.Health then
        local model = object:FindFirstAncestorOfClass("Model")
        if model then
            local humanoid = model:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                infoText = infoText .. string.format("HP: %d/%d", humanoid.Health, humanoid.MaxHealth)
            end
        end
    end
    
    label.Text = infoText
    label.TextColor3 = ESPConfig.Color
end

function RemoveESP(object)
    if ESPObjects[object] then
        if ESPObjects[object].Highlight then
            ESPObjects[object].Highlight:Destroy()
        end
        if ESPObjects[object].Billboard then
            ESPObjects[object].Billboard:Destroy()
        end
        ESPObjects[object] = nil
    end
end

function UpdateAllESP()
    for object, espData in pairs(ESPObjects) do
        if object and object.Parent then
            if espData.Highlight then
                espData.Highlight.FillColor = ESPConfig.Color
                espData.Highlight.Enabled = ESPConfig.Boxes
            end
            if espData.Billboard then
                espData.Billboard.Enabled = ESPConfig.Names or ESPConfig.Distance or ESPConfig.Health
                UpdateESPInfo(object)
            end
        else
            RemoveESP(object)
        end
    end
end

function ScanForEnemies()
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") then
            local partName = object.Name:lower()
            if (ESPConfig.ShowHead and partName:find("head")) or
               (ESPConfig.ShowHitbox and partName:find("hitbox")) or
               (ESPConfig.ShowSegments and partName:find("segment")) then
                CreateESP(object)
            end
        end
    end
end

function StartESP()
    StopESP()
    ScanForEnemies()
    
    table.insert(Connections, workspace.DescendantAdded:Connect(function(object)
        if ESPConfig.Enabled and object:IsA("BasePart") then
            task.wait(0.1)
            local partName = object.Name:lower()
            if (ESPConfig.ShowHead and partName:find("head")) or
               (ESPConfig.ShowHitbox and partName:find("hitbox")) or
               (ESPConfig.ShowSegments and partName:find("segment")) then
                CreateESP(object)
            end
        end
    end))
    
    table.insert(Connections, workspace.DescendantRemoving:Connect(function(object)
        if ESPObjects[object] then
            RemoveESP(object)
        end
    end))
    
    table.insert(Connections, game:GetService("RunService").Heartbeat:Connect(function()
        if ESPConfig.Enabled then
            for object in pairs(ESPObjects) do
                if object and object.Parent then
                    UpdateESPInfo(object)
                else
                    RemoveESP(object)
                end
            end
        end
    end))
    
    Rayfield:Notify({
        Title = "👁️ ESP Activated",
        Content = "Enemy ESP system is now active!",
        Duration = 5.0,
        Image = 1234567890,
    })
end

function StopESP()
    for _, connection in pairs(Connections) do
        connection:Disconnect()
    end
    Connections = {}
    
    for object in pairs(ESPObjects) do
        RemoveESP(object)
    end
    ESPObjects = {}
    
    Rayfield:Notify({
        Title = "👁️ ESP Deactivated",
        Content = "Enemy ESP system stopped!",
        Duration = 5.0,
        Image = 1234567890,
    })
end

-- ========== VIP STORE & TAG SYSTEM ==========
local StoreTab = Window:CreateTab("👑 VIP Store", 1234567890)

local VIPSection = StoreTab:CreateSection("GamePass VIP System")

StoreTab:CreateParagraph({
    Title = "VIP Benefits",
    Content = "🆓 FREE: ESP, Speed, Jump Power, Fly\n👑 VIP: Auto Farm, VFly, FreeCam, NoClip + 'Scripter VIP' Tag!"
})

local VIPPriceLabel = StoreTab:CreateLabel("GamePass ID: " .. VIP.GamePassId)
local VIPStatus = StoreTab:CreateLabel("Status: Checking VIP...")
local VIPTagLabel = StoreTab:CreateLabel("VIP Tag: " .. VIP.Tag)

-- Check VIP Status and Apply Tag
local function CheckVIPStatus()
    local player = game.Players.LocalPlayer
    local success, hasPass = pcall(function()
        return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, VIP.GamePassId)
    end)
    
    if success and hasPass then
        VIP.HasVIP = true
        VIPStatus:Set("Status: 👑 VIP MEMBER (Verified)")
        ApplyVIPTag()
        Rayfield:Notify({
            Title = "🎉 VIP Verified!",
            Content = "Welcome back, VIP member! 'Scripter VIP' tag applied!",
            Duration = 8.0,
            Image = 1234567890,
        })
    else
        VIP.HasVIP = false
        VIPStatus:Set("Status: 🆓 FREE USER")
        RemoveVIPTag()
    end
end

-- Apply VIP Tag to Player
function ApplyVIPTag()
    local player = game.Players.LocalPlayer
    
    -- Method 1: Change DisplayName
    if player then
        if not _G.OriginalPlayerName then
            _G.OriginalPlayerName = player.DisplayName
        end
        player.DisplayName = _G.OriginalPlayerName .. " [" .. VIP.Tag .. "]"
    end
    
    -- Method 2: Create Leaderstats VIP Tag
    CreateLeaderstatsVIPTag()
    
    -- Method 3: Billboard GUI above player
    CreateVIPTagBillboard()
end

function RemoveVIPTag()
    local player = game.Players.LocalPlayer
    
    -- Restore original name
    if player and _G.OriginalPlayerName then
        player.DisplayName = _G.OriginalPlayerName
    end
    
    -- Remove leaderstats
    RemoveLeaderstatsVIPTag()
    
    -- Remove billboard
    RemoveVIPTagBillboard()
end

-- Leaderstats VIP Tag
function CreateLeaderstatsVIPTag()
    local player = game.Players.LocalPlayer
    if not player then return end
    
    if player.Character then
        AddLeaderstatsToCharacter(player.Character)
    end
    
    player.CharacterAdded:Connect(function(character)
        AddLeaderstatsToCharacter(character)
    end)
end

function AddLeaderstatsToCharacter(character)
    task.wait(1)
    
    local vipFolder = Instance.new("Folder")
    vipFolder.Name = "VIPTag"
    vipFolder.Parent = character
    
    local vipValue = Instance.new("StringValue")
    vipValue.Name = "ScripterVIP"
    vipValue.Value = "⭐ VIP Member ⭐"
    vipValue.Parent = vipFolder
end

function RemoveLeaderstatsVIPTag()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local vipFolder = player.Character:FindFirstChild("VIPTag")
        if vipFolder then
            vipFolder:Destroy()
        end
    end
end

-- Billboard VIP Tag
function CreateVIPTagBillboard()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end
    
    player.CharacterAdded:Connect(function(character)
        task.wait(1)
        CreateBillboardOnCharacter(character)
    end)
    
    if player.Character then
        CreateBillboardOnCharacter(player.Character)
    end
end

function CreateBillboardOnCharacter(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end
    
    local existingBillboard = head:FindFirstChild("VIPTagBillboard")
    if existingBillboard then
        existingBillboard:Destroy()
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "VIPTagBillboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 100
    billboard.Parent = head
    
    local label = Instance.new("TextLabel")
    label.Name = "VIPLabel"
    label.BackgroundTransparency = 1
    label.Text = "🌟 " .. VIP.Tag .. " 🌟"
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.TextStrokeTransparency = 0
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Parent = billboard
end

function RemoveVIPTagBillboard()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local head = player.Character:FindFirstChild("Head")
        if head then
            local billboard = head:FindFirstChild("VIPTagBillboard")
            if billboard then
                billboard:Destroy()
            end
        end
    end
end

-- Purchase VIP Button
local BuyVIP = StoreTab:CreateButton({
    Name = "👑 Purchase VIP GamePass",
    Callback = function()
        game:GetService("MarketplaceService"):PromptGamePassPurchase(game.Players.LocalPlayer, VIP.GamePassId)
        
        Rayfield:Notify({
            Title = "👑 VIP Purchase",
            Content = "After purchase, you'll get the 'Scripter VIP' tag!",
            Duration = 6.0,
            Image = 1234567890,
        })
    end,
})

-- Verify VIP Button
local VerifyVIP = StoreTab:CreateButton({
    Name = "🔄 Verify VIP & Apply Tag",
    Callback = function()
        CheckVIPStatus()
        Rayfield:Notify({
            Title = "🔍 Checking VIP Status",
            Content = "Verifying GamePass and applying VIP tag...",
            Duration = 3.0,
            Image = 1234567890,
        })
    end,
})

-- ========== INITIALIZE ==========

-- Set default positions
WinX:Set("57.25")
WinY:Set("241.75")
WinZ:Set("226.75")
SpawnInput:Set("0,5,0")
WinsTarget:Set("10")
DelayInput:Set("1")

-- Initialize settings
_G.FLYSPEED = 20
_G.WinNotifications = true
_G.ProgressInterval = 10

UpdateFarmDisplay()

-- Check VIP status on startup
task.wait(2)
CheckVIPStatus()

-- Auto re-apply tag when character respawns
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(2)
    if VIP.HasVIP then
        ApplyVIPTag()
    end
end)

Rayfield:Notify({
    Title = "🧿 RusCatScript Ultimate v9.0",
    Content = "Complete system loaded! All features available!",
    Duration = 8.0,
    Image = 1234567890,
})
