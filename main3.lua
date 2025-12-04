local UILibrary = {}
UILibrary.__index = UILibrary

local Colors = {
    Background = Color3.fromRGB(10, 10, 10),
    Secondary = Color3.fromRGB(15, 15, 15),
    Tertiary = Color3.fromRGB(20, 20, 20),
    Border = Color3.fromRGB(30, 30, 30),
    White = Color3.fromRGB(255, 255, 255),
    Gray = Color3.fromRGB(160, 160, 160),
    Red = Color3.fromRGB(239, 68, 68),
    DarkRed = Color3.fromRGB(200, 50, 50),
    Accent = Color3.fromRGB(239, 68, 68)
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function UILibrary.new(config)
    local self = setmetatable({}, UILibrary)
    
    self.Name = config.Name or "UI Library"
    self.Icon = config.Icon or "rbxassetid://122340386055007"
    self.MinimizedBar = nil
    self.IsMinimized = false
    self.IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    
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
    Window.Size = UDim2.new(0, 650, 0, 450)
    Window.Position = UDim2.new(0.5, -325, 0.5, -225)
    Window.BackgroundColor3 = Colors.Background
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = self.ScreenGui
    self.Window = Window
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Window
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Colors.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = Window
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Window
    
    local IconContainer = Instance.new("Frame")
    IconContainer.Name = "IconContainer"
    IconContainer.Size = UDim2.new(0, 35, 0, 35)
    IconContainer.Position = UDim2.new(0, 15, 0.5, -17.5)
    IconContainer.BackgroundColor3 = Colors.Secondary
    IconContainer.BorderSizePixel = 0
    IconContainer.Parent = TopBar
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = IconContainer
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0.8, 0, 0.8, 0)
    Icon.Position = UDim2.new(0.1, 0, 0.1, 0)
    Icon.BackgroundTransparency = 1
    Icon.Image = self.Icon
    Icon.ImageColor3 = Colors.White
    Icon.Parent = IconContainer
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 60, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = self.Name
    Title.TextColor3 = Colors.White
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamMedium
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(0, 70, 0, 30)
    ButtonContainer.Position = UDim2.new(1, -85, 0.5, -15)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = TopBar
    
    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0, 0, 0, 0)
    MinimizeButton.BackgroundColor3 = Colors.Secondary
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Image = "rbxassetid://135767012904945"
    MinimizeButton.ImageColor3 = Colors.Gray
    MinimizeButton.Parent = ButtonContainer
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeButton
    
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(0, 40, 0, 0)
    CloseButton.BackgroundColor3 = Colors.Secondary
    CloseButton.BorderSizePixel = 0
    CloseButton.Image = "rbxassetid://132854725146991"
    CloseButton.ImageColor3 = Colors.Gray
    CloseButton.Parent = ButtonContainer
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    local Separator = Instance.new("Frame")
    Separator.Name = "Separator"
    Separator.Size = UDim2.new(1, -30, 0, 1)
    Separator.Position = UDim2.new(0, 15, 0, 50)
    Separator.BackgroundColor3 = Colors.Border
    Separator.BorderSizePixel = 0
    Separator.BackgroundTransparency = 0.5
    Separator.Parent = Window
    
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -30, 1, -65)
    Content.Position = UDim2.new(0, 15, 0, 55)
    Content.BackgroundTransparency = 1
    Content.Parent = Window
    
    self.Content = Content
    
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Tertiary}):Play()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {ImageColor3 = Colors.White}):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Secondary}):Play()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {ImageColor3 = Colors.Gray}):Play()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Red}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {ImageColor3 = Colors.White}):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Secondary}):Play()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {ImageColor3 = Colors.Gray}):Play()
    end)
    
    if not self.IsMobile then
        self:MakeDraggable(Window, TopBar)
        self:MakeResizable(Window)
    else
        self:MakeDraggable(Window, TopBar)
    end
    
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
    Notification.Size = UDim2.new(0, 0, 0, 0)
    Notification.Position = UDim2.new(1, -20, 1, -20)
    Notification.AnchorPoint = Vector2.new(1, 1)
    Notification.BackgroundColor3 = Colors.Secondary
    Notification.BorderSizePixel = 0
    Notification.Visible = false
    Notification.ZIndex = 100
    Notification.ClipsDescendants = true
    Notification.Parent = self.ScreenGui
    self.Notification = Notification
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = Notification
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Colors.Border
    NotifStroke.Thickness = 1
    NotifStroke.Transparency = 0.5
    NotifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    NotifStroke.Parent = Notification
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -30, 1, -30)
    ContentFrame.Position = UDim2.new(0, 15, 0, 15)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Notification
    
    local IconFrame = Instance.new("Frame")
    IconFrame.Name = "IconFrame"
    IconFrame.Size = UDim2.new(0, 45, 0, 45)
    IconFrame.Position = UDim2.new(0, 0, 0, 0)
    IconFrame.BackgroundColor3 = Colors.Tertiary
    IconFrame.BorderSizePixel = 0
    IconFrame.Parent = ContentFrame
    
    local IconFrameCorner = Instance.new("UICorner")
    IconFrameCorner.CornerRadius = UDim.new(0, 10)
    IconFrameCorner.Parent = IconFrame
    
    local NotifIcon = Instance.new("ImageLabel")
    NotifIcon.Name = "Icon"
    NotifIcon.Size = UDim2.new(0, 28, 0, 28)
    NotifIcon.Position = UDim2.new(0.5, -14, 0.5, -14)
    NotifIcon.BackgroundTransparency = 1
    NotifIcon.Image = "rbxassetid://132275613947554"
    NotifIcon.ImageColor3 = Colors.Red
    NotifIcon.Parent = IconFrame
    
    local TextContainer = Instance.new("Frame")
    TextContainer.Name = "TextContainer"
    TextContainer.Size = UDim2.new(1, -60, 0, 45)
    TextContainer.Position = UDim2.new(0, 60, 0, 0)
    TextContainer.BackgroundTransparency = 1
    TextContainer.Parent = ContentFrame
    
    local Message = Instance.new("TextLabel")
    Message.Name = "Message"
    Message.Size = UDim2.new(1, 0, 1, 0)
    Message.BackgroundTransparency = 1
    Message.Text = "Are you sure you want to close the interface?"
    Message.TextColor3 = Colors.White
    Message.TextSize = 13
    Message.Font = Enum.Font.Gotham
    Message.TextWrapped = true
    Message.TextXAlignment = Enum.TextXAlignment.Left
    Message.TextYAlignment = Enum.TextYAlignment.Center
    Message.Parent = TextContainer
    
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Name = "LoadingBar"
    LoadingBar.Size = UDim2.new(1, 0, 0, 3)
    LoadingBar.Position = UDim2.new(0, 0, 1, -3)
    LoadingBar.BackgroundColor3 = Colors.Red
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Parent = Notification
    
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
    ButtonFrame.Position = UDim2.new(0, 0, 0, 75)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = ContentFrame
    
    local YesButton = Instance.new("TextButton")
    YesButton.Name = "YesButton"
    YesButton.Size = UDim2.new(0.48, 0, 1, 0)
    YesButton.Position = UDim2.new(0, 0, 0, 0)
    YesButton.BackgroundColor3 = Colors.Red
    YesButton.BorderSizePixel = 0
    YesButton.Text = ""
    YesButton.AutoButtonColor = false
    YesButton.Parent = ButtonFrame
    
    local YesCorner = Instance.new("UICorner")
    YesCorner.CornerRadius = UDim.new(0, 8)
    YesCorner.Parent = YesButton
    
    local YesContainer = Instance.new("Frame")
    YesContainer.Size = UDim2.new(1, 0, 1, 0)
    YesContainer.BackgroundTransparency = 1
    YesContainer.Parent = YesButton
    
    local YesIcon = Instance.new("ImageLabel")
    YesIcon.Size = UDim2.new(0, 16, 0, 16)
    YesIcon.Position = UDim2.new(0, 12, 0.5, -8)
    YesIcon.BackgroundTransparency = 1
    YesIcon.Image = "rbxassetid://135347761366449"
    YesIcon.ImageColor3 = Colors.White
    YesIcon.Parent = YesContainer
    
    local YesLabel = Instance.new("TextLabel")
    YesLabel.Size = UDim2.new(1, -35, 1, 0)
    YesLabel.Position = UDim2.new(0, 35, 0, 0)
    YesLabel.BackgroundTransparency = 1
    YesLabel.Text = "Yes"
    YesLabel.TextColor3 = Colors.White
    YesLabel.TextSize = 13
    YesLabel.Font = Enum.Font.GothamMedium
    YesLabel.TextXAlignment = Enum.TextXAlignment.Left
    YesLabel.Parent = YesContainer
    
    local NoButton = Instance.new("TextButton")
    NoButton.Name = "NoButton"
    NoButton.Size = UDim2.new(0.48, 0, 1, 0)
    NoButton.Position = UDim2.new(0.52, 0, 0, 0)
    NoButton.BackgroundColor3 = Colors.Tertiary
    NoButton.BorderSizePixel = 0
    NoButton.Text = ""
    NoButton.AutoButtonColor = false
    NoButton.Parent = ButtonFrame
    
    local NoCorner = Instance.new("UICorner")
    NoCorner.CornerRadius = UDim.new(0, 8)
    NoCorner.Parent = NoButton
    
    local NoContainer = Instance.new("Frame")
    NoContainer.Size = UDim2.new(1, 0, 1, 0)
    NoContainer.BackgroundTransparency = 1
    NoContainer.Parent = NoButton
    
    local NoIcon = Instance.new("ImageLabel")
    NoIcon.Size = UDim2.new(0, 16, 0, 16)
    NoIcon.Position = UDim2.new(0, 12, 0.5, -8)
    NoIcon.BackgroundTransparency = 1
    NoIcon.Image = "rbxassetid://132854725146991"
    NoIcon.ImageColor3 = Colors.White
    NoIcon.Parent = NoContainer
    
    local NoLabel = Instance.new("TextLabel")
    NoLabel.Size = UDim2.new(1, -35, 1, 0)
    NoLabel.Position = UDim2.new(0, 35, 0, 0)
    NoLabel.BackgroundTransparency = 1
    NoLabel.Text = "No"
    NoLabel.TextColor3 = Colors.White
    NoLabel.TextSize = 13
    NoLabel.Font = Enum.Font.GothamMedium
    NoLabel.TextXAlignment = Enum.TextXAlignment.Left
    NoLabel.Parent = NoContainer
    
    YesButton.MouseEnter:Connect(function()
        TweenService:Create(YesButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.DarkRed}):Play()
    end)
    
    YesButton.MouseLeave:Connect(function()
        TweenService:Create(YesButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Red}):Play()
    end)
    
    NoButton.MouseEnter:Connect(function()
        TweenService:Create(NoButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Border}):Play()
    end)
    
    NoButton.MouseLeave:Connect(function()
        TweenService:Create(NoButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Tertiary}):Play()
    end)
    
    YesButton.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        self:HideNotification()
    end)
end

function UILibrary:ShowCloseConfirmation()
    self.Notification.Visible = true
    self.Notification.Size = UDim2.new(0, 0, 0, 0)
    self.Notification.BackgroundTransparency = 1
    
    local sizeTween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 320, 0, 140)}
    )
    
    local fadeTween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    )
    
    fadeTween:Play()
    task.wait(0.1)
    sizeTween:Play()
end

function UILibrary:HideNotification()
    local sizeTween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    
    local fadeTween = TweenService:Create(
        self.Notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {BackgroundTransparency = 1}
    )
    
    sizeTween:Play()
    task.wait(0.2)
    fadeTween:Play()
    
    sizeTween.Completed:Connect(function()
        self.Notification.Visible = false
        self.Notification.BackgroundTransparency = 0
    end)
end

function UILibrary:Close()
    local tween = TweenService:Create(
        self.Window,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    tween:Play()
    tween.Completed:Connect(function()
        self.ScreenGui:Destroy()
    end)
end

function UILibrary:Minimize()
    local tween = TweenService:Create(
        self.Window,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    tween:Play()
    
    tween.Completed:Connect(function()
        self.Window.Visible = false
        self.IsMinimized = true
        
        if not self.MinimizedBar then
            local MinBar = Instance.new("Frame")
            MinBar.Name = "MinimizedBar"
            MinBar.Size = UDim2.new(0, 0, 0, 0)
            MinBar.Position = UDim2.new(0.5, -175, 0.5, -22.5)
            MinBar.BackgroundColor3 = Colors.Secondary
            MinBar.BorderSizePixel = 0
            MinBar.Parent = self.ScreenGui
            self.MinimizedBar = MinBar
            
            local MinBarCorner = Instance.new("UICorner")
            MinBarCorner.CornerRadius = UDim.new(0, 10)
            MinBarCorner.Parent = MinBar
            
            local MinBarStroke = Instance.new("UIStroke")
            MinBarStroke.Color = Colors.Border
            MinBarStroke.Thickness = 1
            MinBarStroke.Transparency = 0.5
            MinBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            MinBarStroke.Parent = MinBar
            
            local MinIconContainer = Instance.new("Frame")
            MinIconContainer.Name = "IconContainer"
            MinIconContainer.Size = UDim2.new(0, 30, 0, 30)
            MinIconContainer.Position = UDim2.new(0, 10, 0.5, -15)
            MinIconContainer.BackgroundColor3 = Colors.Tertiary
            MinIconContainer.BorderSizePixel = 0
            MinIconContainer.Parent = MinBar
            
            local MinIconCorner = Instance.new("UICorner")
            MinIconCorner.CornerRadius = UDim.new(0, 8)
            MinIconCorner.Parent = MinIconContainer
            
            local MinBarIcon = Instance.new("ImageLabel")
            MinBarIcon.Name = "Icon"
            MinBarIcon.Size = UDim2.new(0.7, 0, 0.7, 0)
            MinBarIcon.Position = UDim2.new(0.15, 0, 0.15, 0)
            MinBarIcon.BackgroundTransparency = 1
            MinBarIcon.Image = self.Icon
            MinBarIcon.ImageColor3 = Colors.White
            MinBarIcon.Parent = MinIconContainer
            
            local MinBarTitle = Instance.new("TextLabel")
            MinBarTitle.Name = "Title"
            MinBarTitle.Size = UDim2.new(1, -130, 1, 0)
            MinBarTitle.Position = UDim2.new(0, 50, 0, 0)
            MinBarTitle.BackgroundTransparency = 1
            MinBarTitle.Text = self.Name
            MinBarTitle.TextColor3 = Colors.White
            MinBarTitle.TextSize = 13
            MinBarTitle.Font = Enum.Font.GothamMedium
            MinBarTitle.TextXAlignment = Enum.TextXAlignment.Left
            MinBarTitle.Parent = MinBar
            
            local MinButtonContainer = Instance.new("Frame")
            MinButtonContainer.Name = "ButtonContainer"
            MinButtonContainer.Size = UDim2.new(0, 65, 0, 28)
            MinButtonContainer.Position = UDim2.new(1, -75, 0.5, -14)
            MinButtonContainer.BackgroundTransparency = 1
            MinButtonContainer.Parent = MinBar
            
            local OpenButton = Instance.new("ImageButton")
            OpenButton.Name = "OpenButton"
            OpenButton.Size = UDim2.new(0, 28, 0, 28)
            OpenButton.Position = UDim2.new(0, 0, 0, 0)
            OpenButton.BackgroundColor3 = Colors.Tertiary
            OpenButton.BorderSizePixel = 0
            OpenButton.Image = "rbxassetid://116845122064768"
            OpenButton.ImageColor3 = Colors.Gray
            OpenButton.Parent = MinButtonContainer
            
            local OpenCorner = Instance.new("UICorner")
            OpenCorner.CornerRadius = UDim.new(0, 6)
            OpenCorner.Parent = OpenButton
            
            local CloseMinButton = Instance.new("ImageButton")
            CloseMinButton.Name = "CloseButton"
            CloseMinButton.Size = UDim2.new(0, 28, 0, 28)
            CloseMinButton.Position = UDim2.new(0, 37, 0, 0)
            CloseMinButton.BackgroundColor3 = Colors.Tertiary
            CloseMinButton.BorderSizePixel = 0
            CloseMinButton.Image = "rbxassetid://132854725146991"
            CloseMinButton.ImageColor3 = Colors.Gray
            CloseMinButton.Parent = MinButtonContainer
            
            local CloseMinCorner = Instance.new("UICorner")
            CloseMinCorner.CornerRadius = UDim.new(0, 6)
            CloseMinCorner.Parent = CloseMinButton
            
            OpenButton.MouseEnter:Connect(function()
                TweenService:Create(OpenButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Border}):Play()
                TweenService:Create(OpenButton, TweenInfo.new(0.2), {ImageColor3 = Colors.White}):Play()
            end)
            
            OpenButton.MouseLeave:Connect(function()
                TweenService:Create(OpenButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Tertiary}):Play()
                TweenService:Create(OpenButton, TweenInfo.new(0.2), {ImageColor3 = Colors.Gray}):Play()
            end)
            
            CloseMinButton.MouseEnter:Connect(function()
                TweenService:Create(CloseMinButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Red}):Play()
                TweenService:Create(CloseMinButton, TweenInfo.new(0.2), {ImageColor3 = Colors.White}):Play()
            end)
            
            CloseMinButton.MouseLeave:Connect(function()
                TweenService:Create(CloseMinButton, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Tertiary}):Play()
                TweenService:Create(CloseMinButton, TweenInfo.new(0.2), {ImageColor3 = Colors.Gray}):Play()
            end)
            
            self:MakeDraggable(MinBar, MinBar)
            
            OpenButton.MouseButton1Click:Connect(function()
                self:Restore()
            end)
            
            CloseMinButton.MouseButton1Click:Connect(function()
                self:ShowCloseConfirmation()
            end)
            
            local expandTween = TweenService:Create(
                MinBar,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 350, 0, 45)}
            )
            expandTween:Play()
        else
            self.MinimizedBar.Visible = true
            local expandTween = TweenService:Create(
                self.MinimizedBar,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 350, 0, 45)}
            )
            expandTween:Play()
        end
    end)
end

function UILibrary:Restore()
    local shrinkTween = TweenService:Create(
        self.MinimizedBar,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    shrinkTween:Play()
    
    shrinkTween.Completed:Connect(function()
        self.MinimizedBar.Visible = false
        self.Window.Visible = true
        self.IsMinimized = false
        
        self.Window.Size = UDim2.new(0, 0, 0, 0)
        local expandTween = TweenService:Create(
            self.Window,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 650, 0, 450)}
        )
        expandTween:Play()
    end)
end

function UILibrary:MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
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
    ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
    ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
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
            local newWidth = math.max(400, startSize.X.Offset + delta.X)
            local newHeight = math.max(250, startSize.Y.Offset + delta.Y)
            
            frame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

return UILibrary
