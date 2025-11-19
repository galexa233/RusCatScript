-- RusCatScript Fast Auto Farm with Fly, Hide GUI & Jump Animation
-- Fast win detection with flying and R6 jump animation

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RusCatScriptGUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame 400x200
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Header.BorderSizePixel = 0
Header.Active = true
Header.Draggable = true
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "RusCatScript FAST FARM"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Control Buttons
local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0, 30, 0, 30)
HideButton.Position = UDim2.new(1, -60, 0, 0)
HideButton.BackgroundColor3 = Color3.fromRGB(255, 180, 60)
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.Text = "-"
HideButton.Font = Enum.Font.GothamBold
HideButton.TextSize = 16
HideButton.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = Header

-- Scrolling Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
ScrollFrame.Parent = MainFrame

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 0, 350)
Content.Position = UDim2.new(0, 0, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = ScrollFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 50)
StatusLabel.Position = UDim2.new(0, 10, 0, 10)
StatusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Status: Ready\nWins: 0\nPosition: Waiting..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextWrapped = true
StatusLabel.Parent = Content

-- Win Counter
local WinsLabel = Instance.new("TextLabel")
WinsLabel.Size = UDim2.new(1, -20, 0, 20)
WinsLabel.Position = UDim2.new(0, 10, 0, 70)
WinsLabel.BackgroundTransparency = 1
WinsLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
WinsLabel.Text = "Total Wins: 0 | Session: 0"
WinsLabel.Font = Enum.Font.GothamBold
WinsLabel.TextSize = 12
WinsLabel.TextXAlignment = Enum.TextXAlignment.Left
WinsLabel.Parent = Content

-- Win Position Section
local WinPosLabel = Instance.new("TextLabel")
WinPosLabel.Size = UDim2.new(1, -20, 0, 20)
WinPosLabel.Position = UDim2.new(0, 10, 0, 95)
WinPosLabel.BackgroundTransparency = 1
WinPosLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
WinPosLabel.Text = "Win Position:"
WinPosLabel.Font = Enum.Font.Gotham
WinPosLabel.TextSize = 12
WinPosLabel.TextXAlignment = Enum.TextXAlignment.Left
WinPosLabel.Parent = Content

local XBox = Instance.new("TextBox")
XBox.Size = UDim2.new(0.3, -10, 0, 25)
XBox.Position = UDim2.new(0, 10, 0, 120)
XBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
XBox.TextColor3 = Color3.fromRGB(255, 255, 255)
XBox.Text = "57.25"
XBox.PlaceholderText = "X"
XBox.Font = Enum.Font.Gotham
XBox.TextSize = 12
XBox.Parent = Content

local YBox = Instance.new("TextBox")
YBox.Size = UDim2.new(0.3, -10, 0, 25)
YBox.Position = UDim2.new(0.33, 0, 0, 120)
YBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
YBox.TextColor3 = Color3.fromRGB(255, 255, 255)
YBox.Text = "241.75"
YBox.PlaceholderText = "Y"
YBox.Font = Enum.Font.Gotham
YBox.TextSize = 12
YBox.Parent = Content

local ZBox = Instance.new("TextBox")
ZBox.Size = UDim2.new(0.3, -10, 0, 25)
ZBox.Position = UDim2.new(0.66, 0, 0, 120)
ZBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ZBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ZBox.Text = "226.75"
ZBox.PlaceholderText = "Z"
ZBox.Font = Enum.Font.Gotham
ZBox.TextSize = 12
ZBox.Parent = Content

-- Buttons
local StartFarmButton = Instance.new("TextButton")
StartFarmButton.Size = UDim2.new(1, -20, 0, 30)
StartFarmButton.Position = UDim2.new(0, 10, 0, 155)
StartFarmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
StartFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartFarmButton.Text = "🚀 START FAST FARM"
StartFarmButton.Font = Enum.Font.GothamBold
StartFarmButton.TextSize = 12
StartFarmButton.Parent = Content

local StopFarmButton = Instance.new("TextButton")
StopFarmButton.Size = UDim2.new(1, -20, 0, 30)
StopFarmButton.Position = UDim2.new(0, 10, 0, 190)
StopFarmButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
StopFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopFarmButton.Text = "🛑 STOP FARM"
StopFarmButton.Font = Enum.Font.GothamBold
StopFarmButton.TextSize = 12
StopFarmButton.Parent = Content

local FindWinButton = Instance.new("TextButton")
FindWinButton.Size = UDim2.new(0.48, -5, 0, 25)
FindWinButton.Position = UDim2.new(0, 10, 0, 225)
FindWinButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
FindWinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FindWinButton.Text = "🔍 FIND WIN PART"
FindWinButton.Font = Enum.Font.Gotham
FindWinButton.TextSize = 11
FindWinButton.Parent = Content

local GetPosButton = Instance.new("TextButton")
GetPosButton.Size = UDim2.new(0.48, -5, 0, 25)
GetPosButton.Position = UDim2.new(0.52, 0, 0, 225)
GetPosButton.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
GetPosButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetPosButton.Text = "📍 GET POSITION"
GetPosButton.Font = Enum.Font.Gotham
GetPosButton.TextSize = 11
GetPosButton.Parent = Content

local ToggleFlyButton = Instance.new("TextButton")
ToggleFlyButton.Size = UDim2.new(0.48, -5, 0, 25)
ToggleFlyButton.Position = UDim2.new(0, 10, 0, 255)
ToggleFlyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
ToggleFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFlyButton.Text = "🦅 TOGGLE FLY"
ToggleFlyButton.Font = Enum.Font.Gotham
ToggleFlyButton.TextSize = 11
ToggleFlyButton.Parent = Content

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.48, -5, 0, 25)
TeleportButton.Position = UDim2.new(0.52, 0, 0, 255)
TeleportButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "✨ TELEPORT"
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.TextSize = 11
TeleportButton.Parent = Content

local StopAllButton = Instance.new("TextButton")
StopAllButton.Size = UDim2.new(1, -20, 0, 25)
StopAllButton.Position = UDim2.new(0, 10, 0, 285)
StopAllButton.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
StopAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopAllButton.Text = "🛑 STOP ALL"
StopAllButton.Font = Enum.Font.Gotham
StopAllButton.TextSize = 11
StopAllButton.Parent = Content

-- Mini GUI for when hidden
local MiniFrame = Instance.new("Frame")
MiniFrame.Size = UDim2.new(0, 150, 0, 40)
MiniFrame.Position = UDim2.new(0, 10, 0, 10)
MiniFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
MiniFrame.BorderSizePixel = 0
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Parent = ScreenGui

local MiniTitle = Instance.new("TextLabel")
MiniTitle.Size = UDim2.new(1, -60, 1, 0)
MiniTitle.Position = UDim2.new(0, 10, 0, 0)
MiniTitle.BackgroundTransparency = 1
MiniTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniTitle.Text = "RusCatScript"
MiniTitle.Font = Enum.Font.GothamBold
MiniTitle.TextSize = 12
MiniTitle.TextXAlignment = Enum.TextXAlignment.Left
MiniTitle.Parent = MiniFrame

local MiniShowButton = Instance.new("TextButton")
MiniShowButton.Size = UDim2.new(0, 30, 0, 40)
MiniShowButton.Position = UDim2.new(1, -30, 0, 0)
MiniShowButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
MiniShowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniShowButton.Text = "+"
MiniShowButton.Font = Enum.Font.GothamBold
MiniShowButton.TextSize = 16
MiniShowButton.Parent = MiniFrame

local MiniCloseButton = Instance.new("TextButton")
MiniCloseButton.Size = UDim2.new(0, 30, 0, 40)
MiniCloseButton.Position = UDim2.new(1, -60, 0, 0)
MiniCloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
MiniCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniCloseButton.Text = "X"
MiniCloseButton.Font = Enum.Font.GothamBold
MiniShowButton.TextSize = 14
MiniCloseButton.Parent = MiniFrame

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MiniCloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Hide/Show functionality
local IsGUIVisible = true

HideButton.MouseButton1Click:Connect(function()
    IsGUIVisible = false
    MainFrame.Visible = false
    MiniFrame.Visible = true
end)

MiniShowButton.MouseButton1Click:Connect(function()
    IsGUIVisible = true
    MainFrame.Visible = true
    MiniFrame.Visible = false
end)

-- Auto Farm Variables
local IsFarming = false
local IsFlying = false
local IsJumping = false
local FarmConnection = nil
local FlyConnection = nil
local JumpConnection = nil
local TotalWins = 0
local SessionWins = 0

-- Fly System Variables
local BGV = nil
local BV = nil
local FlySpeed = 100

-- Function to create R6 Jump Animation
function CreateJumpAnimation()
    if not Character then return nil end
    
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return nil end
    
    -- Create animation track for jumping
    local Animation = Instance.new("Animation")
    Animation.AnimationId = "rbxassetid://180436148" -- Default jump animation
    
    local AnimationTrack = Humanoid:LoadAnimation(Animation)
    return AnimationTrack
end

-- Function to start jump animation loop
function StartJumpAnimation()
    if IsJumping then return end
    
    IsJumping = true
    local JumpAnimation = CreateJumpAnimation()
    
    if not JumpAnimation then 
        IsJumping = false
        return 
    end
    
    JumpConnection = RunService.Heartbeat:Connect(function()
        if not IsJumping or not IsFarming then
            JumpConnection:Disconnect()
            IsJumping = false
            return
        end
        
        -- Play jump animation every 1 second
        if JumpAnimation then
            JumpAnimation:Play()
            wait(0.5)
            if JumpAnimation then
                JumpAnimation:Stop()
            end
            wait(0.5)
        end
    end)
end

-- Function to stop jump animation
function StopJumpAnimation()
    IsJumping = false
    if JumpConnection then
        JumpConnection:Disconnect()
        JumpConnection = nil
    end
end

-- Function to enable Fly
function EnableFly()
    if IsFlying then return end
    
    repeat wait() until Character and HumanoidRootPart and Character:FindFirstChildOfClass("Humanoid")
    
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    Humanoid.PlatformStand = true
    
    BGV = Instance.new("BodyGyro")
    BV = Instance.new("BodyVelocity")
    
    BGV.Parent = HumanoidRootPart
    BV.Parent = HumanoidRootPart
    
    BGV.MaxTorque = Vector3.new(0, 0, 0)
    BGV.P = 10000
    BGV.D = 1000
    
    BV.MaxForce = Vector3.new(40000, 40000, 40000)
    BV.Velocity = Vector3.new(0, 0, 0)
    
    IsFlying = true
    
    FlyConnection = RunService.Heartbeat:Connect(function()
        if not IsFlying then return end
        
        if not Character or not HumanoidRootPart then
            DisableFly()
            return
        end
        
        BGV.CFrame = workspace.CurrentCamera.CoordinateFrame
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            BV.Velocity = moveDirection.Unit * FlySpeed
        else
            BV.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- Function to disable Fly
function DisableFly()
    IsFlying = false
    
    if BGV then BGV:Destroy() end
    if BV then BV:Destroy() end
    
    if Character and Character:FindFirstChildOfClass("Humanoid") then
        Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
end

-- Function to fly to position FAST
function FlyToPosition(x, y, z)
    if not IsFlying then
        EnableFly()
    end
    
    local target = CFrame.new(x, y, z)
    HumanoidRootPart.CFrame = target
end

-- Function to teleport to coordinates
function TeleportToCoordinates(x, y, z)
    local success, error = pcall(function()
        HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end)
    return success
end

-- Function to get current position
function GetCurrentPosition()
    local pos = HumanoidRootPart.Position
    return math.floor(pos.X * 100)/100, math.floor(pos.Y * 100)/100, math.floor(pos.Z * 100)/100
end

-- FAST Win Detection Function
function CheckForWins()
    -- Method 1: Check leaderboard
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local wins = leaderstats:FindFirstChild("Wins") or leaderstats:FindFirstChild("wins")
        if wins and wins.Value > TotalWins then
            local newWins = wins.Value - TotalWins
            TotalWins = wins.Value
            SessionWins = SessionWins + newWins
            UpdateWinDisplay()
            return true
        end
    end
    
    return false
end

-- Update win display
function UpdateWinDisplay()
    WinsLabel.Text = "Total Wins: " .. TotalWins .. " | Session: " .. SessionWins
end

-- Function to find win parts FAST
function FindWinPart()
    StatusLabel.Text = "🔍 Searching for win parts..."
    
    local winParts = {}
    
    -- Check common win part locations first
    local commonLocations = {
        "Finish", "Win", "End", "Victory", "Goal",
        "Portal", "Exit", "Complete", "Final"
    }
    
    for _, location in pairs(commonLocations) do
        local part = workspace:FindFirstChild(location)
        if part and part:IsA("Part") then
            table.insert(winParts, part)
        end
    end
    
    -- Search all parts if not found
    if #winParts == 0 then
        local allObjects = workspace:GetDescendants()
        for _, obj in pairs(allObjects) do
            if obj:IsA("Part") then
                local objName = obj.Name:lower()
                if objName:find("win") or objName:find("finish") or objName:find("end") or objName:find("victory") or objName:find("goal") then
                    table.insert(winParts, obj)
                end
            end
        end
    end
    
    if #winParts > 0 then
        local firstWin = winParts[1]
        XBox.Text = tostring(math.floor(firstWin.Position.X * 100)/100)
        YBox.Text = tostring(math.floor(firstWin.Position.Y * 100)/100)
        ZBox.Text = tostring(math.floor(firstWin.Position.Z * 100)/100)
        StatusLabel.Text = "✅ Found win part! Position updated."
    else
        StatusLabel.Text = "❌ No win parts found. Set position manually."
    end
    
    return winParts
end

-- FAST Auto Farm function
function AutoFarm()
    if not IsFarming then return end
    
    -- Enable fly for fast movement
    if not IsFlying then
        EnableFly()
    end
    
    -- Start jump animation if not already started
    if not IsJumping then
        StartJumpAnimation()
    end
    
    -- Get win position from text boxes
    local winX = tonumber(XBox.Text) or 57.25
    local winY = tonumber(YBox.Text) or 241.75
    local winZ = tonumber(ZBox.Text) or 226.75
    
    -- FAST: Fly to win position
    FlyToPosition(winX, winY, winZ)
    StatusLabel.Text = "🎯 Flying to win position..."
    wait(0.1)
    
    -- FAST: Look for enemies and slap them
    local enemies = workspace:GetChildren()
    local slapped = false
    
    for _, enemy in pairs(enemies) do
        if not IsFarming then break end
        
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            local enemyRoot = enemy.HumanoidRootPart
            
            -- FAST: Fly to enemy
            FlyToPosition(enemyRoot.Position.X, enemyRoot.Position.Y + 3, enemyRoot.Position.Z)
            StatusLabel.Text = "👊 Flying to enemy..."
            wait(0.05)
            
            -- FAST: Try to slap the enemy
            local args = {
                [1] = enemy,
                [2] = enemy.HumanoidRootPart,
                [3] = {
                    ["hit"] = enemy.HumanoidRootPart,
                    ["damage"] = 99999
                }
            }
            
            -- Try multiple remote events quickly
            local remotes = {
                "Slap", "Damage", "Hit", "Attack", 
                "SlapEvent", "SlapPlayer", "ReplicateSlap",
                "TouchInterest", "ClickDetector"
            }
            
            for _, remoteName in pairs(remotes) do
                pcall(function()
                    for _, service in pairs({game:GetService("ReplicatedStorage"), game:GetService("Workspace")}) do
                        local remote = service:FindFirstChild(remoteName)
                        if remote then
                            if remote:IsA("RemoteEvent") then
                                remote:FireServer(unpack(args))
                            elseif remote:IsA("BindableEvent") then
                                remote:Fire(unpack(args))
                            end
                            slapped = true
                        end
                    end
                end)
            end
            
            if slapped then
                StatusLabel.Text = "💥 Slapped enemy! Checking for win..."
                -- Immediately check for win after slap
                CheckForWins()
            end
            
            wait(0.05)
        end
    end
    
    -- FAST: Return to win position
    FlyToPosition(winX, winY, winZ)
    wait(0.1)
    
    -- FAST: Look for finish zones and trigger them
    local finishObjects = workspace:GetDescendants()
    
    for _, obj in pairs(finishObjects) do
        if not IsFarming then break end
        
        local objName = obj.Name:lower()
        if objName:find("finish") or objName:find("end") or objName:find("complete") or objName:find("win") then
            if obj:IsA("Part") then
                -- FAST: Fly to finish object
                FlyToPosition(obj.Position.X, obj.Position.Y, obj.Position.Z)
                StatusLabel.Text = "🏁 Flying to finish object..."
                wait(0.05)
                
                -- FAST: Trigger touch events
                firetouchinterest(HumanoidRootPart, obj, 0)
                firetouchinterest(HumanoidRootPart, obj, 1)
                
                StatusLabel.Text = "✅ Finish object triggered! Checking for win..."
                -- Immediately check for win
                CheckForWins()
                wait(0.05)
            end
        end
    end
end

-- Main farm function
function StartFarm()
    if IsFarming then return end
    
    IsFarming = true
    StatusLabel.Text = "🚀 FAST FARM STARTED!\nFlying to targets + Jump Animation..."
    
    -- Start jump animation when farming begins
    StartJumpAnimation()
    
    FarmConnection = RunService.Heartbeat:Connect(function()
        if not IsFarming then
            FarmConnection:Disconnect()
            return
        end
        
        -- Execute FAST farming routine
        AutoFarm()
        
        -- Check for wins continuously
        CheckForWins()
    end)
end

function StopFarm()
    IsFarming = false
    StopJumpAnimation()
    StatusLabel.Text = "🛑 Farming Stopped\nTotal Wins: " .. TotalWins
    
    if FarmConnection then
        FarmConnection:Disconnect()
        FarmConnection = nil
    end
end

function StopAll()
    IsFarming = false
    DisableFly()
    StopJumpAnimation()
    StatusLabel.Text = "🛑 All Functions Stopped\nWins: " .. TotalWins
    
    if FarmConnection then 
        FarmConnection:Disconnect() 
        FarmConnection = nil 
    end
end

-- Button events
StartFarmButton.MouseButton1Click:Connect(StartFarm)
StopFarmButton.MouseButton1Click:Connect(StopFarm)
StopAllButton.MouseButton1Click:Connect(StopAll)

FindWinButton.MouseButton1Click:Connect(function()
    FindWinPart()
end)

GetPosButton.MouseButton1Click:Connect(function()
    local x, y, z = GetCurrentPosition()
    XBox.Text = tostring(x)
    YBox.Text = tostring(y)
    ZBox.Text = tostring(z)
    StatusLabel.Text = string.format("📍 Position Updated: %.2f, %.2f, %.2f", x, y, z)
end)

ToggleFlyButton.MouseButton1Click:Connect(function()
    if IsFlying then
        DisableFly()
        StatusLabel.Text = "🦅 Fly Disabled"
    else
        EnableFly()
        StatusLabel.Text = "🦅 Fly Enabled - Use WASD+Space+Shift"
    end
end)

TeleportButton.MouseButton1Click:Connect(function()
    local x = tonumber(XBox.Text) or 57.25
    local y = tonumber(YBox.Text) or 241.75
    local z = tonumber(ZBox.Text) or 226.75
    
    FlyToPosition(x, y, z)
    StatusLabel.Text = string.format("✨ Flew to: %.2f, %.2f, %.2f", x, y, z)
end)

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Update position display and check wins continuously
RunService.Heartbeat:Connect(function()
    local x, y, z = GetCurrentPosition()
    local farmStatus = IsFarming and "🚀 FARMING" or "🟢 READY"
    local flyStatus = IsFlying and "🦅 FLYING" or "🔴 NO FLY"
    local jumpStatus = IsJumping and "🕺 JUMPING" or "🔴 NO JUMP"
    
    StatusLabel.Text = string.format("%s | %s | %s\n🎯 Pos: %.1f, %.1f, %.1f\n🏆 Wins: %d", 
        farmStatus, flyStatus, jumpStatus, x, y, z, TotalWins)
        
    -- Continuous win checking
    if IsFarming then
        CheckForWins()
    end
end)

-- Initialize
UpdateWinDisplay()

print("🚀 RusCatScript FAST FARM Loaded!")
print("🦅 Fly System: Use WASD + Space/Shift to fly")
print("🕺 Jump Animation: Auto plays when farming")
print("📱 GUI Controls: Use (-) to hide, (+) to show")
print("⚡ Fast win detection and flying to targets!")
