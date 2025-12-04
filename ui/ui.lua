local UILibrary = {}
UILibrary.__index = UILibrary

local Colors = {
    Background = Color3.fromRGB(35, 35, 35),
    DarkGray = Color3.fromRGB(45, 45, 45),
    LightGray = Color3.fromRGB(55, 55, 55),
    White = Color3.fromRGB(255, 255, 255),
    Red = Color3.fromRGB(220, 50, 50),
    DarkRed = Color3.fromRGB(180, 40, 40),
    Shadow = Color3.fromRGB(20, 20, 20)
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function UILibrary.new(config)
    local self = setmetatable({}, UILibrary)
    
    self.Name = config.Name or "UI Library"
    self.Icon = config.Icon or ""
    self.MinimizedBar = nil
    self.IsMinimized = false
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILibrary"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = CoreGui
    
    self:CreateWindow()
    self:CreateNotification()
    
    return self
end

function UILibrary:CreateWindow()
    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = UDim2.new(0, 600, 0, 400)
    Window.Position = UDim2.new(0.5, -300, 0.5, -200)
    Window.BackgroundColor3 = Colors.Background
    Window.BorderSizePixel = 0
    Window.Parent = self.ScreenGui
    self.Window = Window
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = Window
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Shadow.ImageColor3 = Colors.Shadow
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = Window
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Colors.DarkGray
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Window
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar
    
    local TopBarBottom = Instance.new("Frame")
    TopBarBottom.Size = UDim2.new(1, 0, 0, 8)
    TopBarBottom.Position = UDim2.new(0, 0, 1, -8)
    TopBarBottom.BackgroundColor3 = Colors.DarkGray
    TopBarBottom.BorderSizePixel = 0
    TopBarBottom.Parent = TopBar
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = self.Name
    Title.TextColor3 = Colors.White
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
    MinimizeButton.Position = UDim2.new(1, -60, 0.5, -12.5)
    MinimizeButton.BackgroundColor3 = Colors.LightGray
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Image = "rbxassetid://135767012904945"
    MinimizeButton.ImageColor3 = Colors.White
    MinimizeButton.Parent = TopBar
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton
    
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -30, 0.5, -12.5)
    CloseButton.BackgroundColor3 = Colors.Red
    CloseButton.BorderSizePixel = 0
    CloseButton.Image = "rbxassetid://132854725146991"
    CloseButton.ImageColor3 = Colors.White
    CloseButton.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton
    
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -20, 1, -45)
    Content.Position = UDim2.new(0, 10, 0, 40)
    Content.BackgroundTransparency = 1
    Content.Parent = Window
    
    self.Content = Content
    
    self:MakeDraggable(Window, TopBar)
    self:MakeResizable(Window)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        self:Minimize()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        self:ShowCloseConfirmation()
    end)
end

function UILibrary:CreateNotification()
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification"
    Notification.Size = UDim2.new(0, 350, 0, 150)
    Notification.Position = UDim2.new(0.5, -175, 0.5, -75)
    Notification.BackgroundColor3 = Colors.DarkGray
    Notification.BorderSizePixel = 0
    Notification.Visible = false
    Notification.ZIndex = 10
    Notification.Parent = self.ScreenGui
    self.Notification = Notification
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = Notification
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 15, 0, 15)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://132275613947554"
    Icon.ImageColor3 = Colors.Red
    Icon.Parent = Notification
    
    local Message = Instance.new("TextLabel")
    Message.Name = "Message"
    Message.Size = UDim2.new(1, -70, 0, 50)
    Message.Position = UDim2.new(0, 60, 0, 15)
    Message.BackgroundTransparency = 1
    Message.Text = "Do you really want to close the interface?"
    Message.TextColor3 = Colors.White
    Message.TextSize = 14
    Message.Font = Enum.Font.Gotham
    Message.TextWrapped = true
    Message.TextXAlignment = Enum.TextXAlignment.Left
    Message.Parent = Notification
    
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Name = "LoadingBar"
    LoadingBar.Size = UDim2.new(1, -30, 0, 4)
    LoadingBar.Position = UDim2.new(0, 15, 0, 70)
    LoadingBar.BackgroundColor3 = Colors.DarkRed
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Parent = Notification
    
    local LoadingBarCorner = Instance.new("UICorner")
    LoadingBarCorner.CornerRadius = UDim.new(0, 2)
    LoadingBarCorner.Parent = LoadingBar
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(1, -30, 0, 40)
    ButtonContainer.Position = UDim2.new(0, 15, 1, -50)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = Notification
    
    local YesButton = Instance.new("ImageButton")
    YesButton.Name = "YesButton"
    YesButton.Size = UDim2.new(0.48, 0, 1, 0)
    YesButton.Position = UDim2.new(0, 0, 0, 0)
    YesButton.BackgroundColor3 = Colors.Red
    YesButton.BorderSizePixel = 0
    YesButton.Image = "rbxassetid://135347761366449"
    YesButton.ImageColor3 = Colors.White
    YesButton.Parent = ButtonContainer
    
    local YesCorner = Instance.new("UICorner")
    YesCorner.CornerRadius = UDim.new(0, 6)
    YesCorner.Parent = YesButton
    
    local YesLabel = Instance.new("TextLabel")
    YesLabel.Size = UDim2.new(1, 0, 1, 0)
    YesLabel.BackgroundTransparency = 1
    YesLabel.Text = "Yes"
    YesLabel.TextColor3 = Colors.White
    YesLabel.TextSize = 14
    YesLabel.Font = Enum.Font.GothamBold
    YesLabel.Parent = YesButton
    
    local NoButton = Instance.new("ImageButton")
    NoButton.Name = "NoButton"
    NoButton.Size = UDim2.new(0.48, 0, 1, 0)
    NoButton.Position = UDim2.new(0.52, 0, 0, 0)
    NoButton.BackgroundColor3 = Colors.LightGray
    NoButton.BorderSizePixel = 0
    NoButton.Image = "rbxassetid://132854725146991"
    NoButton.ImageColor3 = Colors.White
    NoButton.Parent = ButtonContainer
    
    local NoCorner = Instance.new("UICorner")
    NoCorner.CornerRadius = UDim.new(0, 6)
    NoCorner.Parent = NoButton
    
    local NoLabel = Instance.new("TextLabel")
    NoLabel.Size = UDim2.new(1, 0, 1, 0)
    NoLabel.BackgroundTransparency = 1
    NoLabel.Text = "No"
    NoLabel.TextColor3 = Colors.White
    NoLabel.TextSize = 14
    NoLabel.Font = Enum.Font.GothamBold
    NoLabel.Parent = NoButton
    
    YesButton.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        self:HideNotification()
    end)
end

function UILibrary:ShowCloseConfirmation()
    self.Notification.Visible = true
    local tween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 150)}
    )
    tween:Play()
end

function UILibrary:HideNotification()
    local tween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    tween:Play()
    tween.Completed:Connect(function()
        self.Notification.Visible = false
    end)
end

function UILibrary:Close()
    self.ScreenGui:Destroy()
end

function UILibrary:Minimize()
    self.Window.Visible = false
    self.IsMinimized = true
    
    if not self.MinimizedBar then
        local MinBar = Instance.new("Frame")
        MinBar.Name = "MinimizedBar"
        MinBar.Size = UDim2.new(0, 400, 0, 50)
        MinBar.Position = UDim2.new(0.5, -200, 0.5, -25)
        MinBar.BackgroundColor3 = Colors.DarkGray
        MinBar.BorderSizePixel = 0
        MinBar.Parent = self.ScreenGui
        self.MinimizedBar = MinBar
        
        local MinBarCorner = Instance.new("UICorner")
        MinBarCorner.CornerRadius = UDim.new(0, 8)
        MinBarCorner.Parent = MinBar
        
        local MinBarIcon = Instance.new("ImageLabel")
        MinBarIcon.Name = "Icon"
        MinBarIcon.Size = UDim2.new(0, 30, 0, 30)
        MinBarIcon.Position = UDim2.new(0, 10, 0.5, -15)
        MinBarIcon.BackgroundTransparency = 1
        MinBarIcon.Image = self.Icon
        MinBarIcon.ImageColor3 = Colors.White
        MinBarIcon.Parent = MinBar
        
        local MinBarTitle = Instance.new("TextLabel")
        MinBarTitle.Name = "Title"
        MinBarTitle.Size = UDim2.new(1, -120, 1, 0)
        MinBarTitle.Position = UDim2.new(0, 45, 0, 0)
        MinBarTitle.BackgroundTransparency = 1
        MinBarTitle.Text = self.Name
        MinBarTitle.TextColor3 = Colors.White
        MinBarTitle.TextSize = 14
        MinBarTitle.Font = Enum.Font.GothamBold
        MinBarTitle.TextXAlignment = Enum.TextXAlignment.Left
        MinBarTitle.Parent = MinBar
        
        local OpenButton = Instance.new("ImageButton")
        OpenButton.Name = "OpenButton"
        OpenButton.Size = UDim2.new(0, 30, 0, 30)
        OpenButton.Position = UDim2.new(1, -70, 0.5, -15)
        OpenButton.BackgroundColor3 = Colors.LightGray
        OpenButton.BorderSizePixel = 0
        OpenButton.Image = "rbxassetid://116845122064768"
        OpenButton.ImageColor3 = Colors.White
        OpenButton.Parent = MinBar
        
        local OpenCorner = Instance.new("UICorner")
        OpenCorner.CornerRadius = UDim.new(0, 4)
        OpenCorner.Parent = OpenButton
        
        local CloseMinButton = Instance.new("ImageButton")
        CloseMinButton.Name = "CloseButton"
        CloseMinButton.Size = UDim2.new(0, 30, 0, 30)
        CloseMinButton.Position = UDim2.new(1, -35, 0.5, -15)
        CloseMinButton.BackgroundColor3 = Colors.Red
        CloseMinButton.BorderSizePixel = 0
        CloseMinButton.Image = "rbxassetid://132854725146991"
        CloseMinButton.ImageColor3 = Colors.White
        CloseMinButton.Parent = MinBar
        
        local CloseMinCorner = Instance.new("UICorner")
        CloseMinCorner.CornerRadius = UDim.new(0, 4)
        CloseMinCorner.Parent = CloseMinButton
        
        self:MakeDraggable(MinBar, MinBar)
        
        OpenButton.MouseButton1Click:Connect(function()
            self:Restore()
        end)
        
        CloseMinButton.MouseButton1Click:Connect(function()
            self:ShowCloseConfirmation()
        end)
    else
        self.MinimizedBar.Visible = true
    end
end

function UILibrary:Restore()
    self.Window.Visible = true
    self.MinimizedBar.Visible = false
    self.IsMinimized = false
end

function UILibrary:MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

function UILibrary:MakeResizable(frame)
    local resizing = false
    local resizeStart
    local startSize
    
    local ResizeHandle = Instance.new("Frame")
    ResizeHandle.Name = "ResizeHandle"
    ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
    ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
    ResizeHandle.BackgroundColor3 = Colors.Red
    ResizeHandle.BorderSizePixel = 0
    ResizeHandle.Parent = frame
    
    local ResizeCorner = Instance.new("UICorner")
    ResizeCorner.CornerRadius = UDim.new(0, 4)
    ResizeCorner.Parent = ResizeHandle
    
    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            startSize = frame.Size
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            local newWidth = math.max(300, startSize.X.Offset + delta.X)
            local newHeight = math.max(200, startSize.Y.Offset + delta.Y)
            
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

return UILibrary
