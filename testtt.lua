local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui  

-- Main GUI Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.35, 0, 0.7, 0)
Frame.Position = UDim2.new(0.325, 0, 0.15, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.2
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local function roundEdges(instance, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(radius, 0)
    UICorner.Parent = instance
end

-- Title Label
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Size = UDim2.new(1, 0, 0.1, 0)
CreatorLabel.Text = "Made by Bexruz"
CreatorLabel.TextScaled = true
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Parent = Frame

-- Scrollable Section
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0.9, 0, 0.8, 0)
ScrollFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollFrame.BackgroundTransparency = 0.2
ScrollFrame.Parent = Frame
roundEdges(ScrollFrame, 0.2)

-- Store Scroll Position
local lastScrollPosition = Vector2.new(0, 0)
local isOpen = false

-- Function to toggle GUI
local function toggleGUI()
    if isOpen then
        lastScrollPosition = ScrollFrame.CanvasPosition
        local tween = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
        {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
        tween:Play()
        tween.Completed:Wait()
        Frame.Visible = false
    else
        Frame.Size = UDim2.new(0, 0, 0, 0)
        Frame.BackgroundTransparency = 1
        Frame.Visible = true
        ScrollFrame.CanvasPosition = lastScrollPosition
        local tween = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
        {Size = UDim2.new(0.35, 0, 0.7, 0), BackgroundTransparency = 0.2})
        tween:Play()
    end
    isOpen = not isOpen
end

-- Open Button
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0.1, 0, 0.1, 0)
OpenButton.Position = UDim2.new(0.02, 0, 0.02, 0)
OpenButton.Text = "☰"
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextScaled = true
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
OpenButton.BackgroundTransparency = 0.2
OpenButton.Draggable = true
OpenButton.Parent = ScreenGui
roundEdges(OpenButton, 1)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextScaled = true
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Parent = Frame
roundEdges(CloseButton, 0.3)

-- Style Input Box
local StyleInput = Instance.new("TextBox")
StyleInput.Size = UDim2.new(0.9, 0, 0.08, 0)
StyleInput.Position = UDim2.new(0.05, 0, 0)
StyleInput.PlaceholderText = "Enter Style Name..."
StyleInput.Text = ""
StyleInput.TextScaled = true
StyleInput.TextColor3 = Color3.fromRGB(255, 255, 255)
StyleInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StyleInput.Parent = ScrollFrame
roundEdges(StyleInput, 0.2)

-- Function to create buttons
local function createButton(text, position, script)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0.08, 0)
    btn.Position = UDim2.new(0.05, 0, position, 0)
    btn.Text = text
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.2
    btn.Parent = ScrollFrame
    roundEdges(btn, 0.25)
    btn.MouseButton1Click:Connect(script)
end

createButton("Set Custom Style", 0.1, function()
    local input = StyleInput.Text
    if input and input ~= "" then
        game.Players.LocalPlayer.PlayerStats.Style.Value = input
        showNotification("Style set to: " .. input)
    else
        showNotification("Please enter a style name!")
    end
end)

-- Updated No CD Button with Loadstring
createButton("No CD", 0.2, function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BexruzScripts/Blue-lock-no-cd-reo-get-any-style-script.-WORKS-WITH-WORLD-CLASSES-/refs/heads/main/no%20cd.lua"))()
    end)
    
    if success then
        showNotification("No CD Activated Successfully!")
    else
        showNotification("No CD Failed: "..tostring(err))
    end
end)

-- Style Buttons
local styles = { "Kurona", "NEL Isagi", "Sae", "Rin", "Shidou" }
for i, style in ipairs(styles) do
    createButton(style, 0.3 + (i - 1) * 0.1, function()
        game.Players.LocalPlayer.PlayerStats.Style.Value = style
        showNotification("Style set to: " .. style)
    end)
end

-- Notification System
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Size = UDim2.new(0.25, 0, 0.08, 0)
NotificationFrame.Position = UDim2.new(1.1, 0, 0.85, 0)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NotificationFrame.BackgroundTransparency = 0.2
NotificationFrame.Visible = false
NotificationFrame.Parent = ScreenGui
roundEdges(NotificationFrame, 0.3)

local NotificationText = Instance.new("TextLabel")
NotificationText.Size = UDim2.new(1, 0, 1, 0)
NotificationText.TextScaled = true
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.BackgroundTransparency = 1
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = NotificationFrame

-- Animated Notifications
function showNotification(text)
    NotificationText.Text = text
    NotificationFrame.Visible = true

    local slideIn = TweenService:Create(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
    {Position = UDim2.new(0.75, 0, 0.85, 0)})
    slideIn:Play()
    slideIn.Completed:Wait()

    wait(2)

    local slideOut = TweenService:Create(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
    {Position = UDim2.new(1.1, 0, 0.85, 0)})
    slideOut:Play()
    slideOut.Completed:Wait()

    NotificationFrame.Visible = false
end

OpenButton.MouseButton1Click:Connect(toggleGUI)
CloseButton.MouseButton1Click:Connect(toggleGUI)