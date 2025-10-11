-- RusCatScript Campfire System - ALL IN ONE
-- Put this in ServerScriptService

local CampfireSystem = {}

-- Campfire levels
local CAMPFIRE_LEVELS = {
    [1] = {fuelNeeded = 5, name = "🔥 Basic Campfire", size = 8},
    [2] = {fuelNeeded = 15, name = "🔥 Small Campfire", size = 12},
    [3] = {fuelNeeded = 30, name = "🔥 Medium Campfire", size = 16},
    [4] = {fuelNeeded = 50, name = "🔥 Large Campfire", size = 20},
    [5] = {fuelNeeded = 75, name = "🔥 Epic Campfire", size = 25},
    [6] = {fuelNeeded = 100, name = "🔥 Legendary Campfire", size = 30}
}

-- Valid fuel items
local VALID_FUEL = {"chair", "fuel can", "coal", "log", "wood", "stick", "plank", "branch"}

-- DataStore
local DataStoreService = game:GetService("DataStoreService")
local campfireData = DataStoreService:GetDataStore("CampfireData")

-- Function to get player data
function CampfireSystem:GetPlayerData(player)
    local success, data = pcall(function()
        return campfireData:GetAsync(tostring(player.UserId))
    end)
    
    if success and data then
        return data
    else
        return {
            level = 1,
            fuelAdded = 0,
            lastUpdate = os.time()
        }
    end
end

-- Function to save player data
function CampfireSystem:SavePlayerData(player, data)
    pcall(function()
        campfireData:SetAsync(tostring(player.UserId), data)
    end)
end

-- Function to add fuel
function CampfireSystem:AddFuel(player, fuelItem)
    local data = self:GetPlayerData(player)
    local fuelName = string.lower(fuelItem)
    
    local isValid = false
    for _, validFuel in pairs(VALID_FUEL) do
        if string.find(fuelName, validFuel) then
            isValid = true
            break
        end
    end
    
    if not isValid then
        return false, "Not valid fuel!"
    end
    
    data.fuelAdded += 1
    data.lastUpdate = os.time()
    
    local leveledUp = false
    local oldLevel = data.level
    
    while data.level < #CAMPFIRE_LEVELS and data.fuelAdded >= CAMPFIRE_LEVELS[data.level + 1].fuelNeeded do
        data.level += 1
        leveledUp = true
    end
    
    self:SavePlayerData(player, data)
    return true, data.level, data.fuelAdded, leveledUp, oldLevel
end

-- Function to get fuel needed for next level
function CampfireSystem:GetFuelToNextLevel(player)
    local data = self:GetPlayerData(player)
    if data.level >= #CAMPFIRE_LEVELS then
        return 0
    end
    return CAMPFIRE_LEVELS[data.level + 1].fuelNeeded - data.fuelAdded
end

-- Create RemoteEvents
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateCampfireEvent = Instance.new("RemoteEvent")
UpdateCampfireEvent.Name = "UpdateCampfireEvent"
UpdateCampfireEvent.Parent = ReplicatedStorage

local AddFuelEvent = Instance.new("RemoteEvent")
AddFuelEvent.Name = "AddFuelEvent"
AddFuelEvent.Parent = ReplicatedStorage

-- Create campfire in workspace
local function createCampfire()
    local campfire = Instance.new("Part")
    campfire.Name = "Campfire"
    campfire.Size = Vector3.new(6, 6, 6)
    campfire.Position = Vector3.new(0, 10, 0)
    campfire.Anchored = true
    campfire.BrickColor = BrickColor.new("Reddish brown")
    campfire.Material = Enum.Material.Wood
    campfire.Parent = workspace

    -- Fire effect
    local fire = Instance.new("Fire")
    fire.Heat = 8
    fire.Size = 8
    fire.Color = Color3.new(1, 0.5, 0)
    fire.SecondaryColor = Color3.new(1, 0, 0)
    fire.Parent = campfire

    -- Light effect
    local light = Instance.new("PointLight")
    light.Brightness = 3
    light.Range = 20
    light.Color = Color3.fromRGB(255, 100, 0)
    light.Parent = campfire

    -- Fuel drop zone
    local fuelZone = Instance.new("Part")
    fuelZone.Name = "FuelZone"
    fuelZone.Size = Vector3.new(15, 3, 15)
    fuelZone.Position = campfire.Position + Vector3.new(0, -4, 0)
    fuelZone.Anchored = true
    fuelZone.CanCollide = false
    fuelZone.Transparency = 0.5
    fuelZone.BrickColor = BrickColor.new("Bright green")
    fuelZone.Parent = campfire

    return campfire, fuelZone, fire, light
end

local campfire, fuelZone, fire, light = createCampfire()

-- Fuel collection system
fuelZone.Touched:Connect(function(touchPart)
    local character = touchPart:FindFirstAncestorOfClass("Model")
    if character then
        local player = game.Players:GetPlayerFromCharacter(character)
        if player then
            -- Check if touched part is fuel
            local isFuel = false
            local fuelName = touchPart.Name
            
            for _, validFuel in pairs(VALID_FUEL) do
                if string.lower(fuelName):find(validFuel) then
                    isFuel = true
                    break
                end
            end
            
            if isFuel then
                -- Make item glow
                local glow = Instance.new("PointLight")
                glow.Brightness = 5
                glow.Range = 8
                glow.Color = Color3.new(1, 0.5, 0)
                glow.Parent = touchPart
                
                -- Teleport to campfire center
                touchPart.CFrame = campfire.CFrame + Vector3.new(0, 2, 0)
                touchPart.Anchored = true
                
                -- Wait then destroy and add fuel
                wait(0.5)
                
                local success, level, fuelAdded, leveledUp = CampfireSystem:AddFuel(player, fuelName)
                
                if success then
                    -- Update fire based on level
                    local levelInfo = CAMPFIRE_LEVELS[level]
                    fire.Size = levelInfo.size
                    light.Brightness = 3 + (level * 0.8)
                    light.Range = 20 + (level * 5)
                    
                    -- Update GUI
                    local fuelToNext = CampfireSystem:GetFuelToNextLevel(player)
                    UpdateCampfireEvent:FireClient(player, level, fuelAdded, fuelToNext, levelInfo.name)
                    
                    -- Destroy fuel item
                    if touchPart then
                        touchPart:Destroy()
                    end
                    
                    if leveledUp then
                        -- Level up effects
                        local explosion = Instance.new("Explosion")
                        explosion.Position = campfire.Position
                        explosion.BlastPressure = 0
                        explosion.BlastRadius = 15
                        explosion.Visible = false
                        explosion.Parent = workspace
                        
                        local sparkles = Instance.new("Sparkles")
                        sparkles.SparkleColor = Color3.new(1, 0.8, 0)
                        sparkles.Parent = campfire
                        game:GetService("Debris"):AddItem(sparkles, 3)
                    end
                end
            end
        end
    end
end)

-- Handle manual fuel adding
AddFuelEvent.OnServerEvent:Connect(function(player, fuelItemName)
    local success, level, fuelAdded, leveledUp = CampfireSystem:AddFuel(player, fuelItemName)
    
    if success then
        local levelInfo = CAMPFIRE_LEVELS[level]
        fire.Size = levelInfo.size
        light.Brightness = 3 + (level * 0.8)
        light.Range = 20 + (level * 5)
        
        local fuelToNext = CampfireSystem:GetFuelToNextLevel(player)
        UpdateCampfireEvent:FireClient(player, level, fuelAdded, fuelToNext, levelInfo.name)
    end
end)

-- Create GUI for players when they join
game.Players.PlayerAdded:Connect(function(player)
    -- Wait for player to load
    player.CharacterAdded:Connect(function()
        wait(2)
        
        -- Create GUI for this player
        local playerGui = player:WaitForChild("PlayerGui")
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "RusCatScript_Campfire"
        screenGui.Parent = playerGui

        -- Main Frame
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 350, 0, 180)
        mainFrame.Position = UDim2.new(0, 20, 0, 20)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = mainFrame

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 100, 0)
        stroke.Thickness = 2
        stroke.Parent = mainFrame

        -- Title
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
        title.Text = "🔥 VOIDWARE CAMPFIRE"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextScaled = true
        title.Font = Enum.Font.GothamBlack
        title.Parent = mainFrame

        -- Level Display
        local levelLabel = Instance.new("TextLabel")
        levelLabel.Size = UDim2.new(1, 0, 0, 30)
        levelLabel.Position = UDim2.new(0, 0, 0, 45)
        levelLabel.BackgroundTransparency = 1
        levelLabel.Text = "Level 1: Basic Campfire"
        levelLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        levelLabel.TextScaled = true
        levelLabel.Font = Enum.Font.GothamBold
        levelLabel.Parent = mainFrame

        -- Fuel Display
        local fuelLabel = Instance.new("TextLabel")
        fuelLabel.Size = UDim2.new(1, 0, 0, 25)
        fuelLabel.Position = UDim2.new(0, 0, 0, 75)
        fuelLabel.BackgroundTransparency = 1
        fuelLabel.Text = "Fuel: 0/5"
        fuelLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        fuelLabel.TextScaled = true
        fuelLabel.Font = Enum.Font.Gotham
        fuelLabel.Parent = mainFrame

        -- Progress Bar
        local progressBarBg = Instance.new("Frame")
        progressBarBg.Size = UDim2.new(0.85, 0, 0, 20)
        progressBarBg.Position = UDim2.new(0.075, 0, 0, 105)
        progressBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        progressBarBg.BorderSizePixel = 0
        progressBarBg.Parent = mainFrame

        local progressBarBgCorner = Instance.new("UICorner")
        progressBarBgCorner.CornerRadius = UDim.new(0, 10)
        progressBarBgCorner.Parent = progressBarBg

        local progressBar = Instance.new("Frame")
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.Position = UDim2.new(0, 0, 0, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        progressBar.BorderSizePixel = 0
        progressBar.Parent = progressBarBg

        local progressBarCorner = Instance.new("UICorner")
        progressBarCorner.CornerRadius = UDim.new(0, 10)
        progressBarCorner.Parent = progressBar

        -- Instructions
        local instructions = Instance.new("TextLabel")
        instructions.Size = UDim2.new(1, 0, 0, 40)
        instructions.Position = UDim2.new(0, 0, 0, 130)
        instructions.BackgroundTransparency = 1
        instructions.Text = "Throw CHAIR, COAL, LOGS into green zone!"
        instructions.TextColor3 = Color3.fromRGB(0, 255, 0)
        instructions.TextScaled = true
        instructions.Font = Enum.Font.Gotham
        instructions.TextWrapped = true
        instructions.Parent = mainFrame

        -- Update GUI function
        local function updateGUI(level, fuelAdded, fuelToNext, campfireName)
            levelLabel.Text = "Level " .. level .. ": " .. campfireName
            fuelLabel.Text = "Fuel: " .. fuelAdded .. "/" .. (fuelAdded + fuelToNext)
            
            local progress = fuelAdded / (fuelAdded + fuelToNext)
            if progress ~= progress then progress = 0 end
            progressBar.Size = UDim2.new(progress, 0, 1, 0)
        end

        -- Connect to remote event
        UpdateCampfireEvent.OnClientEvent:Connect(function(level, fuelAdded, fuelToNext, campfireName)
            updateGUI(level, fuelAdded, fuelToNext, campfireName)
        end)

        -- Send initial data to this player
        local data = CampfireSystem:GetPlayerData(player)
        local fuelToNext = CampfireSystem:GetFuelToNextLevel(player)
        local levelInfo = CAMPFIRE_LEVELS[data.level]
        updateGUI(data.level, data.fuelAdded, fuelToNext, levelInfo.name)
    end)
end)

-- Update existing players
for _, player in pairs(game.Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        wait(2)
        local data = CampfireSystem:GetPlayerData(player)
        local fuelToNext = CampfireSystem:GetFuelToNextLevel(player)
        local levelInfo = CAMPFIRE_LEVELS[data.level]
        UpdateCampfireEvent:FireClient(player, data.level, data.fuelAdded, fuelToNext, levelInfo.name)
    end)
end

print("🔥 RusCatScript Campfire System LOADED! - ALL IN ONE SCRIPT")
