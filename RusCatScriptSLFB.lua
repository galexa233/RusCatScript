local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Title = Instance.new("TextLabel")
local UICorner_Main = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "RusCatScript"

-- Главное окно
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.5, -110, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 12)
UICorner_Main.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "RusCatScript" -- Исправленное название
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2.5, 0)
ScrollingFrame.ScrollBarThickness = 2

UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 6)

-- Переменные состояний
local lp = game.Players.LocalPlayer
local godModeActive = false
local vipUnlockActive = false
local noclipEnabled = false
local flyEnabled = false
local flySpeed = 50

-- Функция создания кнопок
local function createBtn(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

--- ЛОГИКА ФУНКЦИЙ ---

game:GetService("RunService").Stepped:Connect(function()
    -- GodMode (Удаление лавы)
    if godModeActive then
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Lava" then obj:Destroy() end
        end
    end
    -- Unlock VIPDoor
    if vipUnlockActive then
        for _, door in pairs(game.Workspace:GetDescendants()) do
            if door.Name == "VIPDoor" and door:IsA("BasePart") then
                door.CanCollide = false
                door.Transparency = 0.5
            end
        end
    end
    -- Noclip
    if noclipEnabled and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

--- КНОПКИ МЕНЮ ---

createBtn("GodMode: OFF", Color3.fromRGB(100, 0, 0), function(btn)
    godModeActive = not godModeActive
    btn.Text = godModeActive and "GodMode: ON" or "GodMode: OFF"
    btn.BackgroundColor3 = godModeActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
end)

createBtn("Unlock VIPDoor: OFF", Color3.fromRGB(70, 0, 130), function(btn)
    vipUnlockActive = not vipUnlockActive
    btn.Text = vipUnlockActive and "Unlock VIPDoor: ON" or "Unlock VIPDoor: OFF"
    btn.BackgroundColor3 = vipUnlockActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(70, 0, 130)
end)

createBtn("Invisible", Color3.fromRGB(80, 80, 80), function()
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
        end
    end
end)

createBtn("Noclip: OFF", Color3.fromRGB(40, 40, 40), function(btn)
    noclipEnabled = not noclipEnabled
    btn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    btn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

createBtn("Fly: OFF", Color3.fromRGB(0, 100, 150), function(btn)
    flyEnabled = not flyEnabled
    btn.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    btn.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(0, 100, 150)
end)

createBtn("Speed: 80", Color3.fromRGB(50, 150, 0), function()
    lp.Character.Humanoid.WalkSpeed = 80
end)

createBtn("Jump: 120", Color3.fromRGB(0, 150, 120), function()
    lp.Character.Humanoid.JumpPower = 120
end)

createBtn("Low Gravity", Color3.fromRGB(150, 150, 0), function()
    game.Workspace.Gravity = 45
end)

createBtn("Reset Physics", Color3.fromRGB(200, 80, 0), function()
    lp.Character.Humanoid.WalkSpeed = 16
    lp.Character.Humanoid.JumpPower = 50
    game.Workspace.Gravity = 196.2
    noclipEnabled = false
end)

createBtn("Close RusCatScript", Color3.fromRGB(30, 30, 30), function()
    ScreenGui:Destroy()
end)

-- Логика полета
task.spawn(function()
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    while task.wait() do
        if flyEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            bv.Parent = lp.Character.HumanoidRootPart
            bv.Velocity = lp.Character.Humanoid.MoveDirection * flySpeed + Vector3.new(0, 2, 0)
        else
            bv.Parent = nil
        end
    end
end)
