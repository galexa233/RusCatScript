--[[
    RusCatScript Library
    Версия: 1.0
    Размер GUI: 400x200
]]

local RusCatScript = {}

-- Основные цвета
local theme = {
    Background = Color3.fromRGB(25, 25, 25),
    Topbar = Color3.fromRGB(35, 35, 35),
    ButtonHover = Color3.fromRGB(45, 45, 45),
    Text = Color3.fromRGB(255, 255, 255),
    CloseButton = Color3.fromRGB(255, 70, 70),
    MinimizeButton = Color3.fromRGB(255, 200, 70),
    PinButton = Color3.fromRGB(70, 200, 255)
}

-- Функция создания главного окна
function RusCatScript:CreateWindow(title)
    -- Проверяем, есть ли уже ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RusCatScript_GUI"
    screenGui.Parent = game.CoreGui
    
    -- Создаем главный фрейм
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    mainFrame.BackgroundColor3 = theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = false -- Будем делать свою draggable систему
    mainFrame.Parent = screenGui
    
    -- Верхняя панель для перетаскивания
    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 30)
    topbar.BackgroundColor3 = theme.Topbar
    topbar.BorderSizePixel = 0
    topbar.Parent = mainFrame
    
    -- Название окна
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -90, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "RusCatScript"
    titleLabel.TextColor3 = theme.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = topbar
    
    -- Кнопка закрытия (X)
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -90, 0, 0)
    closeButton.BackgroundColor3 = theme.CloseButton
    closeButton.Text = "X"
    closeButton.TextColor3 = theme.Text
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = topbar
    
    -- Кнопка свернуть (-)
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -60, 0, 0)
    minimizeButton.BackgroundColor3 = theme.MinimizeButton
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = theme.Text
    minimizeButton.TextSize = 24
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Parent = topbar
    
    -- Кнопка закрепить (Pin)
    local pinButton = Instance.new("TextButton")
    pinButton.Name = "PinButton"
    pinButton.Size = UDim2.new(0, 30, 0, 30)
    pinButton.Position = UDim2.new(1, -30, 0, 0)
    pinButton.BackgroundColor3 = theme.PinButton
    pinButton.Text = "📌"
    pinButton.TextColor3 = theme.Text
    pinButton.TextSize = 16
    pinButton.Font = Enum.Font.GothamBold
    pinButton.BorderSizePixel = 0
    pinButton.Parent = topbar
    
    -- Контейнер для элементов
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -20, 1, -40)
    container.Position = UDim2.new(0, 10, 0, 35)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame
    
    -- Переменные состояния
    local minimized = false
    local pinned = false
    local normalSize = UDim2.new(0, 400, 0, 200)
    local minimizedSize = UDim2.new(0, 400, 0, 30)
    
    -- Функционал перетаскивания
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Функционал кнопки закрытия
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Функционал кнопки свернуть
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            mainFrame.Size = minimizedSize
            container.Visible = false
            minimizeButton.Text = "□"
        else
            mainFrame.Size = normalSize
            container.Visible = true
            minimizeButton.Text = "-"
        end
    end)
    
    -- Функционал кнопки закрепить
    pinButton.MouseButton1Click:Connect(function()
        pinned = not pinned
        if pinned then
            pinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
            pinButton.Text = "📍"
            -- Здесь можно добавить логику закрепления поверх других окон
        else
            pinButton.BackgroundColor3 = theme.PinButton
            pinButton.Text = "📌"
        end
    end)
    
    -- Эффекты наведения
    local function setupHover(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = hoverColor
        end)
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = normalColor
        end)
    end
    
    setupHover(closeButton, theme.CloseButton, Color3.fromRGB(255, 100, 100))
    setupHover(minimizeButton, theme.MinimizeButton, Color3.fromRGB(255, 220, 100))
    setupHover(pinButton, theme.PinButton, Color3.fromRGB(100, 220, 255))
    
    -- Возвращаем объекты для дальнейшего использования
    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        Container = container,
        
        -- Метод для создания кнопки
        CreateButton = function(self, config)
            local button = Instance.new("TextButton")
            button.Name = config.Name or "Button"
            button.Size = UDim2.new(1, 0, 0, 35)
            button.Position = UDim2.new(0, 0, 0, (#container:GetChildren() - 1) * 40)
            button.BackgroundColor3 = theme.Topbar
            button.Text = config.Text or "Button"
            button.TextColor3 = theme.Text
            button.Font = Enum.Font.Gotham
            button.TextSize = 14
            button.BorderSizePixel = 0
            button.Parent = container
            
            if config.Callback then
                button.MouseButton1Click:Connect(config.Callback)
            end
            
            return button
        end,
        
        -- Метод для создания текстового поля
        CreateLabel = function(self, config)
            local label = Instance.new("TextLabel")
            label.Name = config.Name or "Label"
            label.Size = UDim2.new(1, 0, 0, 30)
            label.Position = UDim2.new(0, 0, 0, (#container:GetChildren() - 1) * 35)
            label.BackgroundTransparency = 1
            label.Text = config.Text or "Label"
            label.TextColor3 = theme.Text
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.Parent = container
            
            return label
        end
    }
end

return RusCatScript
