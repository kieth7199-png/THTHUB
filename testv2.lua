-- GUI MỚI - GIAO DIỆN HIỆN ĐẠI CÓ THỂ DI CHUYỂN
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("TÉO HUB V2 - VIP PRO 💎", "Sentinel")

-- Tạo MainFrame có thể di chuyển
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local DragHandle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép di chuyển

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(1, -30, 1, 0)
TitleText.Text = "TÉO HUB V2 - VIP PRO 💎"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinBtn.BorderSizePixel = 0
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.GothamBold

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Parent = MainFrame
TabsContainer.BackgroundTransparency = 1
TabsContainer.Position = UDim2.new(0, 0, 0, 40)
TabsContainer.Size = UDim2.new(1, 0, 1, -40)

-- Ẩn UI mặc định của Kavo UI
Window.Main.Visible = false

-- Tạo tabs container mới
local TabsFrame = Instance.new("ScrollingFrame")
TabsFrame.Parent = TabsContainer
TabsFrame.BackgroundTransparency = 1
TabsFrame.Size = UDim2.new(0, 120, 1, 0)
TabsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TabsFrame.ScrollBarThickness = 3

local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = TabsContainer
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 120, 0, 0)
ContentFrame.Size = UDim2.new(1, -120, 1, 0)

-- Biến lưu trữ
local currentTab = nil
local tabs = {}

-- Hàm tạo tab mới
function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Parent = TabsFrame
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.BorderSizePixel = 0
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, #tabs * 45)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Parent = ContentFrame
    tabContent.BackgroundTransparency = 1
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Visible = false
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.ScrollBarThickness = 5
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContent
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    tabButton.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            currentTab.Content.Visible = false
        end
        
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        tabContent.Visible = true
        currentTab = {Button = tabButton, Content = tabContent}
    end)
    
    local tabData = {
        Button = tabButton,
        Content = tabContent,
        Layout = tabLayout
    }
    
    table.insert(tabs, tabData)
    TabsFrame.CanvasSize = UDim2.new(0, 0, 0, #tabs * 45)
    
    -- Chọn tab đầu tiên
    if #tabs == 1 then
        tabButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        tabContent.Visible = true
        currentTab = tabData
    end
    
    return tabData
end

-- Hàm tạo button trong tab
function createButton(tabData, name, description, callback)
    local button = Instance.new("TextButton")
    button.Parent = tabData.Content
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 0)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.TextWrapped = true
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = button
    descLabel.BackgroundTransparency = 1
    descLabel.Position = UDim2.new(0, 10, 0, 25)
    descLabel.Size = UDim2.new(1, -20, 0, 20)
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    button.MouseButton1Click: callback
    
    -- Update canvas size
    tabData.Content.CanvasSize = UDim2.new(0, 0, 0, tabData.Layout.AbsoluteContentSize.Y)
    
    return button
end

-- Hàm tạo toggle trong tab
function createToggle(tabData, name, description, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = tabData.Content
    toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Size = UDim2.new(1, -20, 0, 50)
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = toggleFrame
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.Size = UDim2.new(0.7, -10, 0, 20)
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = toggleFrame
    descLabel.BackgroundTransparency = 1
    descLabel.Position = UDim2.new(0, 10, 0, 25)
    descLabel.Size = UDim2.new(0.7, -10, 0, 20)
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = toggleFrame
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(120, 0, 0)
    toggleButton.BorderSizePixel = 0
    toggleButton.Position = UDim2.new(0.8, 0, 0.2, 0)
    toggleButton.Size = UDim2.new(0.15, 0, 0.6, 0)
    toggleButton.Text = default and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    
    local toggleBtnCorner = Instance.new("UICorner")
    toggleBtnCorner.CornerRadius = UDim.new(0, 6)
    toggleBtnCorner.Parent = toggleButton
    
    local state = default
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(120, 0, 0)
        toggleButton.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    -- Update canvas size
    tabData.Content.CanvasSize = UDim2.new(0, 0, 0, tabData.Layout.AbsoluteContentSize.Y)
    
    return toggleFrame
end

-- TẠO CÁC TAB VÀ NỘI DUNG

-- Tab Trang Chủ
local homeTab = createTab("🏠 TRANG CHỦ")
createButton(homeTab, "TikTok Chính", "Theo dõi TikTok chính của tôi", function()
    setclipboard("https://www.tiktok.com/@jannie3342?_t=ZS-90QsJQ5j0NO&_r=1")
end)

createButton(homeTab, "TikTok Phụ", "Kênh TikTok thứ 2", function()
    setclipboard("https://www.tiktok.com/@b.yt03?_t=ZS-90QsHokNlwN&_r=1")
end)

createButton(homeTab, "TikTok Script", "Nơi cập nhật script mới", function()
    setclipboard("https://www.tiktok.com/@b.yt03?_t=ZS-90QsHmSjaiu&_r=1")
end)

-- Tab Grow A Garden
local gardenTab = createTab("🌱 GROW A GARDEN")
createButton(gardenTab, "Speed Hub 🌱", "Script đầy đủ tính năng", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

createButton(gardenTab, "ThundeZ Hub ⚡", "Hub chất lượng cao", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ThundeZ/GrowAGardenScript/refs/heads/main/ThunderZHub.lua"))()
end)

-- Tab Brain Rot
local brainTab = createTab("💩 BRAIN ROT")
createButton(brainTab, "Chill Hub 😌", "No Key - Ổn định", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
end)

createButton(brainTab, "VN Hub 🇻🇳", "Script người Việt làm", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/replit8173/VietnamHub/refs/heads/main/VietnamseHub.lua", true))()
end)

-- Tab 99 Đêm
local nightTab = createTab("🥷 99 ĐÊM")
createButton(nightTab, "Combo New 😍", "No Key - Full Tiếng Việt", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/checkurasshole/Trt/refs/heads/main/999NIGH"))()
end)

createButton(nightTab, "Foxname Hub", "No Key - Chất lượng", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"))()
end)

-- Tab Blox Fruit
local bloxTab = createTab("🍎 BLOX FRUIT")
createButton(bloxTab, "Redz Hub 😍", "Tốt nhất hiện nay", function()
    local Settings = {
        JoinTeam = "Pirates";
        Translator = true;
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))(Settings)
end)

-- Tab Cài Đặt
local settingsTab = createTab("⚙️ CÀI ĐẶT")
createToggle(settingsTab, "Fix Lag Siêu Cấp", "Xoá map và tối ưu đồ hoạ", false, function(state)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    
    if state then
        StarterGui:SetCore("SendNotification", {
            Title = "⚙️ Fix Lag Siêu Mạnh",
            Text = "Đang xoá map và giảm đồ hoạ...",
            Duration = 4
        })

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 9e9

        for _,v in pairs(workspace:GetChildren()) do
            if not (v == LocalPlayer.Character or v.Name == "Camera" or v:FindFirstChildOfClass("Humanoid")) then
                v:Destroy()
            end
        end

        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            end
        end

        StarterGui:SetCore("SendNotification", {
            Title = "✅ Thành công!",
            Text = "Fix lag siêu mạnh đã bật",
            Duration = 5
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "❌ Đã tắt Fix Lag",
            Text = "Reload game để khôi phục map",
            Duration = 5
        })
    end
end)

-- Nút đóng và ẩn
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Thông báo khi load
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "TÉO HUB V2",
    Text = "Đã load thành công! Có thể di chuyển UI",
    Duration = 5
})

print("🎮 TÉO HUB V2 - VIP PRO đã khởi động! (Có thể di chuyển UI)")