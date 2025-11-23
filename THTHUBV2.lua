-- THT HUB - CÓ NÚT BẬT/TẮT UI VỚI ICON CUSTOM
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Tạo nút toggle nhỏ với icon
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("ImageButton")

ToggleGui.Name = "ToggleGui"
ToggleGui.Parent = CoreGui
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 10, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "http://www.roblox.com/asset/?id=121516369236727"
ToggleButton.ScaleType = Enum.ScaleType.Fit

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

-- Tạo GUI chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THTHubV2"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Có thể di chuyển)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Text = "THT HUB V2 - VIP PRO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

local HideButton = Instance.new("TextButton")
HideButton.Parent = TitleBar
HideButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
HideButton.BorderSizePixel = 0
HideButton.Position = UDim2.new(1, -70, 0, 5)
HideButton.Size = UDim2.new(0, 30, 0, 30)
HideButton.Text = "_"
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideButton.TextSize = 14
HideButton.Font = Enum.Font.GothamBold

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 6)
HideCorner.Parent = HideButton

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.BackgroundTransparency = 1
TabsContainer.Position = UDim2.new(0, 0, 0, 40)
TabsContainer.Size = UDim2.new(1, 0, 1, -40)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = TabsContainer
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2.new(0, 120, 1, 0)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = TabsContainer
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 125, 0, 0)
ContentFrame.Size = UDim2.new(1, -125, 1, 0)

local ContentScrolling = Instance.new("ScrollingFrame")
ContentScrolling.Parent = ContentFrame
ContentScrolling.BackgroundTransparency = 1
ContentScrolling.Size = UDim2.new(1, 0, 1, 0)
ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScrolling.ScrollBarThickness = 3

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Parent = ContentScrolling
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Biến quản lý
local currentTab = nil
local tabs = {}

-- Hàm tạo tab
local function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Parent = Sidebar
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    tabButton.BorderSizePixel = 0
    tabButton.Size = UDim2.new(1, -10, 0, 35)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 40 + 5)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 13
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextWrapped = true
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Parent = ContentScrolling
    tabContent.BackgroundTransparency = 1
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Visible = false
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.ScrollBarThickness = 3
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContent
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    tabButton.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
            currentTab.Content.Visible = false
        end
        
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        tabContent.Visible = true
        currentTab = {Button = tabButton, Content = tabContent, Layout = tabLayout}
    end)
    
    local tabData = {
        Button = tabButton,
        Content = tabContent,
        Layout = tabLayout
    }
    
    table.insert(tabs, tabData)
    
    if #tabs == 1 then
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        tabContent.Visible = true
        currentTab = tabData
    end
    
    return tabData
end

-- Hàm tạo button
local function createButton(tabData, text, description, callback)
    local button = Instance.new("TextButton")
    button.Parent = tabData.Content
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -10, 0, 50)
    button.Text = ""
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = button
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.Size = UDim2.new(1, -30, 0, 20)
    titleLabel.Text = text
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = button
    descLabel.BackgroundTransparency = 1
    descLabel.Position = UDim2.new(0, 15, 0, 25)
    descLabel.Size = UDim2.new(1, -30, 0, 20)
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    end)
    
    button.MouseButton1Click:Connect(function()
        callback()
    end)
    
    tabData.Content.CanvasSize = UDim2.new(0, 0, 0, tabData.Layout.AbsoluteContentSize.Y)
    
    return button
end

-- TẠO CÁC TAB VÀ NỘI DUNG

-- Tab Trang Chủ
local homeTab = createTab("🏠 Trang Chủ")
createButton(homeTab, "TikTok Chính", "Theo dõi TikTok chính của tôi", function()
    setclipboard("https://www.tiktok.com/@caygolike?_r=1&_t=ZS-91dMFcauXCb")
end)

createButton(homeTab, "TikTok Phụ", "Kênh TikTok thứ 2", function()
    setclipboard("https://www.tiktok.com/@caygolike?_r=1&_t=ZS-91dMFcauXCb")
end)

createButton(homeTab, "TikTok Script", "Nơi cập nhật script mới", function()
    setclipboard("https://www.tiktok.com/@caygolike?_r=1&_t=ZS-91dMFcauXCb")
end)

-- Tab Brain Rot
local brainTab = createTab("💩 Brain Rot")
createButton(brainTab, "Chill Hub", "No Key - Ổn định", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkahanh1/spicy/main/Chilli.lua"))()
end)

createButton(brainTab, "VN Hub", "Script người Việt làm", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/replit8173/VietnamHub/refs/heads/main/VietnamseHub.lua", true))()
end)

-- Tab 99 Đêm
local nightTab = createTab("🥷 99 Đêm")
createButton(nightTab, "Combo New", "Có Key - Ổn đỉnh", function()
     loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/d677d5082e89f251ee62248d5c22657d.lua"))()
end)

-- Tab Blox Fruit
local bloxTab = createTab("🔥 Blox Fruit")
createButton(bloxTab, "Trẩu Roblox", "Khá là tốt", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/traurobloxdeptrai/traukhoaito/refs/heads/main/traurobloxredzv4.lua"))()
end)

createButton(bloxTab, "Pine Hub", "Key:GL-SKY", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jadelly261/BloxFruits/refs/heads/main/PineLoader", true))()
end)

-- Xử lý nút đóng/ẩn
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

HideButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Nút toggle UI
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    end
end)

-- Hiệu ứng hover
ToggleButton.MouseEnter:Connect(function()
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
end)

ToggleButton.MouseLeave:Connect(function()
    if not MainFrame.Visible then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
    end
end)

-- Cho phép kéo nút toggle
ToggleButton.Draggable = true

-- Thông báo thành công
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "THT HUB V2",
    Text = "Đã load! Nhấn icon để bật/tắt UI",
    Duration = 5
})

print("🎮 THT HUB V2 ĐÃ SẴN SÀNG!")