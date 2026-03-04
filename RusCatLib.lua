--[[
    RusCatScript Library
    Версия: 2.0
    Стиль: Rayfield
    Категории: Player, Main, Game, Fun
]]

local RusCatScript = {}

-- Основные цвета в стиле Rayfield
local theme = {
    Background = Color3.fromRGB(20, 20, 20),
    Topbar = Color3.fromRGB(30, 30, 30),
    CategoryBar = Color3.fromRGB(25, 25, 25),
    ElementBg = Color3.fromRGB(35, 35, 35),
    ElementHover = Color3.fromRGB(45, 45, 45),
    Accent = Color3.fromRGB(0, 160, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(160, 160, 160),
    CloseButton = Color3.fromRGB(255, 70, 70),
    MinimizeButton = Color3.fromRGB(255, 200, 70),
    PinButton = Color3.fromRGB(70, 200, 255),
    ProgressBg = Color3.fromRGB(45, 45, 45),
    ProgressFill = Color3.fromRGB(0, 160, 255)
}

-- Функция создания главного окна
function RusCatScript:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RusCatScript_GUI"
    screenGui.Parent = game.CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Главный фрейм с закругленными углами
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Active = true
    mainFrame.Parent = screenGui
    
    -- Закругленные углы (для поддержки старых версий Roblox)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Верхняя панель для drag
    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 40)
    topbar.BackgroundColor3 = theme.Topbar
    topbar.BorderSizePixel = 0
    topbar.Parent = mainFrame
    
    local topbarCorner = Instance.new("UICorner")
    topbarCorner.CornerRadius = UDim.new(0, 8)
    topbarCorner.Parent = topbar
    
    -- Название
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -120, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "RusCatScript"
    titleLabel.TextColor3 = theme.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = topbar
    
    -- Кнопки управления
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -105, 0.5, -15)
    closeButton.BackgroundColor3 = theme.CloseButton
    closeButton.Text = "X"
    closeButton.TextColor3 = theme.Text
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = topbar
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
    minimizeButton.BackgroundColor3 = theme.MinimizeButton
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = theme.Text
    minimizeButton.TextSize = 24
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Parent = topbar
    
    local pinButton = Instance.new("TextButton")
    pinButton.Name = "PinButton"
    pinButton.Size = UDim2.new(0, 30, 0, 30)
    pinButton.Position = UDim2.new(1, -35, 0.5, -15)
    pinButton.BackgroundColor3 = theme.PinButton
    pinButton.Text = "📌"
    pinButton.TextColor3 = theme.Text
    pinButton.TextSize = 16
    pinButton.Font = Enum.Font.GothamBold
    pinButton.BorderSizePixel = 0
    pinButton.Parent = topbar
    
    -- Панель категорий
    local categoryBar = Instance.new("Frame")
    categoryBar.Name = "CategoryBar"
    categoryBar.Size = UDim2.new(1, 0, 0, 50)
    categoryBar.Position = UDim2.new(0, 0, 0, 40)
    categoryBar.BackgroundColor3 = theme.CategoryBar
    categoryBar.BorderSizePixel = 0
    categoryBar.Parent = mainFrame
    
    local categoryList = Instance.new("Frame")
    categoryList.Name = "CategoryList"
    categoryList.Size = UDim2.new(1, -20, 1, -10)
    categoryList.Position = UDim2.new(0, 10, 0, 5)
    categoryList.BackgroundTransparency = 1
    categoryList.Parent = categoryBar
    
    -- Контейнер для контента
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -20, 1, -100)
    contentContainer.Position = UDim2.new(0, 10, 0, 95)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame
    
    -- Контейнеры для каждой категории
    local categoryFrames = {}
    local categories = {"Main", "Player", "Game", "Fun"}
    
    local function createCategoryFrame(catName)
        local frame = Instance.new("ScrollingFrame")
        frame.Name = catName .. "Page"
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.ScrollBarThickness = 6
        frame.ScrollBarImageColor3 = theme.Accent
        frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.Visible = false
        frame.Parent = contentContainer
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 8)
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Parent = frame
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 5)
        padding.PaddingBottom = UDim.new(0, 5)
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.Parent = frame
        
        return frame
    end
    
    for _, cat in ipairs(categories) do
        categoryFrames[cat] = createCategoryFrame(cat)
    end
    
    -- Создание кнопок категорий
    local categoryButtons = {}
    local function createCategoryButton(name, pos)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "Button"
        btn.Size = UDim2.new(0, 100, 1, 0)
        btn.Position = UDim2.new(0, (pos-1) * 110, 0, 0)
        btn.BackgroundTransparency = 1
        btn.Text = name
        btn.TextColor3 = theme.TextSecondary
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Parent = categoryList
        
        local line = Instance.new("Frame")
        line.Name = "Underline"
        line.Size = UDim2.new(1, 0, 0, 2)
        line.Position = UDim2.new(0, 0, 1, -2)
        line.BackgroundColor3 = theme.Accent
        line.BackgroundTransparency = 1
        line.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            for _, otherBtn in pairs(categoryButtons) do
                otherBtn.TextColor3 = theme.TextSecondary
                otherBtn.Underline.BackgroundTransparency = 1
            end
            for _, frame in pairs(categoryFrames) do
                frame.Visible = false
            end
            
            btn.TextColor3 = theme.Accent
            btn.Underline.BackgroundTransparency = 0
            categoryFrames[name].Visible = true
        end)
        
        table.insert(categoryButtons, btn)
        return btn
    end
    
    for i, cat in ipairs(categories) do
        createCategoryButton(cat, i)
    end
    
    -- Показываем первую категорию
    if categoryButtons[1] then
        categoryButtons[1].TextColor3 = theme.Accent
        categoryButtons[1].Underline.BackgroundTransparency = 0
        categoryFrames[categories[1]].Visible = true
    end
    
    -- Drag система
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
    
    -- Функции кнопок
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    local minimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            mainFrame.Size = UDim2.new(0, 500, 0, 40)
            categoryBar.Visible = false
            contentContainer.Visible = false
            minimizeButton.Text = "□"
        else
            mainFrame.Size = UDim2.new(0, 500, 0, 350)
            categoryBar.Visible = true
            contentContainer.Visible = true
            minimizeButton.Text = "-"
        end
    end)
    
    local pinned = false
    pinButton.MouseButton1Click:Connect(function()
        pinned = not pinned
        if pinned then
            pinButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
            pinButton.Text = "📍"
            mainFrame.ZIndex = 10
        else
            pinButton.BackgroundColor3 = theme.PinButton
            pinButton.Text = "📌"
            mainFrame.ZIndex = 1
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
    
    -- Возвращаем API
    return {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        CategoryFrames = categoryFrames,
        
        -- Создание секции
        CreateSection = function(self, category, name)
            local frame = categoryFrames[category]
            if not frame then return end
            
            local section = Instance.new("Frame")
            section.Name = name .. "Section"
            section.Size = UDim2.new(1, -10, 0, 30)
            section.BackgroundTransparency = 1
            section.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = name
            label.TextColor3 = theme.Accent
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = section
            
            local line = Instance.new("Frame")
            line.Size = UDim2.new(1, 0, 0, 1)
            line.Position = UDim2.new(0, 0, 1, -1)
            line.BackgroundColor3 = theme.Accent
            line.BackgroundTransparency = 0.5
            line.Parent = section
            
            return section
        end,
        
        -- Кнопка
        CreateButton = function(self, category, config)
            local frame = categoryFrames[category]
            if not frame then return end
            
            local button = Instance.new("TextButton")
            button.Name = config.Name or "Button"
            button.Size = UDim2.new(1, -10, 0, 40)
            button.BackgroundColor3 = theme.ElementBg
            button.Text = ""
            button.BorderSizePixel = 0
            button.AutoButtonColor = false
            button.Parent = frame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = button
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -50, 1, 0)
            title.Position = UDim2.new(0, 15, 0, 0)
            title.BackgroundTransparency = 1
            title.Text = config.Text or "Button"
            title.TextColor3 = theme.Text
            title.Font = Enum.Font.Gotham
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = button
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 30, 1, 0)
            arrow.Position = UDim2.new(1, -35, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "→"
            arrow.TextColor3 = theme.TextSecondary
            arrow.Font = Enum.Font.Gotham
            arrow.TextSize = 18
            arrow.Parent = button
            
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = theme.ElementHover
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = theme.ElementBg
            end)
            
            if config.Callback then
                button.MouseButton1Click:Connect(config.Callback)
            end
            
            return button
        end,
        
        -- Прогресс бар
        CreateProgress = function(self, category, config)
            local frame = categoryFrames[category]
            if not frame then return end
            
            local progressFrame = Instance.new("Frame")
            progressFrame.Name = config.Name or "Progress"
            progressFrame.Size = UDim2.new(1, -10, 0, 50)
            progressFrame.BackgroundColor3 = theme.ElementBg
            progressFrame.BorderSizePixel = 0
            progressFrame.Parent = frame
            
            local progCorner = Instance.new("UICorner")
            progCorner.CornerRadius = UDim.new(0, 6)
            progCorner.Parent = progressFrame
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -20, 0, 20)
            title.Position = UDim2.new(0, 10, 0, 5)
            title.BackgroundTransparency = 1
            title.Text = config.Text or "Progress"
            title.TextColor3 = theme.Text
            title.Font = Enum.Font.Gotham
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = progressFrame
            
            local percentLabel = Instance.new("TextLabel")
            percentLabel.Size = UDim2.new(0, 50, 0, 20)
            percentLabel.Position = UDim2.new(1, -60, 0, 5)
            percentLabel.BackgroundTransparency = 1
            percentLabel.Text = "0%"
            percentLabel.TextColor3 = theme.Accent
            percentLabel.Font = Enum.Font.GothamBold
            percentLabel.TextSize = 14
            percentLabel.Parent = progressFrame
            
            local barBg = Instance.new("Frame")
            barBg.Size = UDim2.new(1, -20, 0, 10)
            barBg.Position = UDim2.new(0, 10, 0, 30)
            barBg.BackgroundColor3 = theme.ProgressBg
            barBg.BorderSizePixel = 0
            barBg.Parent = progressFrame
            
            local barCorner = Instance.new("UICorner")
            barCorner.CornerRadius = UDim.new(0, 4)
            barCorner.Parent = barBg
            
            local barFill = Instance.new("Frame")
            barFill.Size = UDim2.new(config.Value or 0, 0, 1, 0)
            barFill.BackgroundColor3 = theme.ProgressFill
            barFill.BorderSizePixel = 0
            barFill.Parent = barBg
            
            local fillCorner = Instance.new("UICorner")
            fillCorner.CornerRadius = UDim.new(0, 4)
            fillCorner.Parent = barFill
            
            return {
                SetValue = function(val)
                    val = math.clamp(val, 0, 1)
                    barFill.Size = UDim2.new(val, 0, 1, 0)
                    percentLabel.Text = math.floor(val * 100) .. "%"
                end
            }
        end,
        
        -- Тоггл (переключатель)
        CreateToggle = function(self, category, config)
            local frame = categoryFrames[category]
            if not frame then return end
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = config.Name or "Toggle"
            toggleFrame.Size = UDim2.new(1, -10, 0, 40)
            toggleFrame.BackgroundColor3 = theme.ElementBg
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = frame
            
            local togCorner = Instance.new("UICorner")
            togCorner.CornerRadius = UDim.new(0, 6)
            togCorner.Parent = toggleFrame
            
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, -60, 1, 0)
            title.Position = UDim2.new(0, 15, 0, 0)
            title.BackgroundTransparency = 1
            title.Text = config.Text or "Toggle"
            title.TextColor3 = theme.Text
            title.Font = Enum.Font.Gotham
            title.TextSize = 14
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = toggleFrame
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 40, 0, 20)
            toggleBtn.Position = UDim2.new(1, -55, 0.5, -10)
            toggleBtn.BackgroundColor3 = theme.ProgressBg
            toggleBtn.Text = ""
            toggleBtn.BorderSizePixel = 0
            toggleBtn.Parent = toggleFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(1, 0)
            btnCorner.Parent = toggleBtn
            
            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, 16, 0, 16)
            circle.Position = UDim2.new(0, 2, 0.5, -8)
            circle.BackgroundColor3 = theme.Text
            circle.BorderSizePixel = 0
            circle.Parent = toggleBtn
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = circle
            
            local toggled = config.Default or false
            local function updateToggle()
                if toggled then
                    toggleBtn.BackgroundColor3 = theme.Accent
                    circle.Position = UDim2.new(0, 22, 0.5, -8)
                else
                    toggleBtn.BackgroundColor3 = theme.ProgressBg
                    circle.Position = UDim2.new(0, 2, 0.5, -8)
                end
            end
            updateToggle()
            
            toggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                updateToggle()
                if config.Callback then
                    config.Callback(toggled)
                end
            end)
            
            return {
                SetValue = function(val)
                    toggled = val
                    updateToggle()
                end,
                GetValue = function()
                    return toggled
            
