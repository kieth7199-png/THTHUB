-- THT HUB - Blox Fruits Auto Farm System
-- Educational purposes only

local THT_HUB = {
    Name = "THT HUB",
    Version = "3.0",
    Enabled = false,
    CurrentTarget = nil,
    FarmingArea = "Jungle"
}

-- KẾT NỐI DỊCH VỤ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- HIỂN THỊ LOGO THT HUB
function THT_HUB.ShowLogo()
    print([[
    
    ████████╗██╗  ██╗████████╗
    ╚══██╔══╝██║  ██║╚══██╔══╝
       ██║   ███████║   ██║   
       ██║   ██╔══██║   ██║   
       ██║   ██║  ██║   ██║   
       ╚═╝   ╚═╝  ╚═╝   ╚═╝   
       
       BLOX FRUITS AUTO FARM
            Version 3.0
    ]])
end

-- HỆ THỐNG TỰ ĐỘNG TẤN CÔNG
function THT_HUB.FindNearestEnemy()
    local closestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestEnemy = enemy
            end
        end
    end
    
    return closestEnemy
end

-- HỆ THỐNG DI CHUYỂN TỰ ĐỘNG
function THT_HUB.MoveToTarget(target)
    if target and target:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
    end
end

-- HỆ THỐNG TẤN CÔNG TỰ ĐỘNG
function THT_HUB.AutoAttack()
    if not THT_HUB.Enabled then return end
    
    local target = THT_HUB.FindNearestEnemy()
    if target then
        THT_HUB.MoveToTarget(target)
        
        -- Kích hoạt kỹ năng
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
        wait(0.5)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
        wait(0.5)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
    end
end

-- HỆ THỐNG THU THẬP VẬT PHẨM
function THT_HUB.CollectDrops()
    for _, drop in pairs(workspace:GetChildren()) do
        if drop.Name == "Fruit" or drop.Name == "Material" then
            if drop:FindFirstChild("Handle") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = drop.Handle.CFrame
                wait(0.2)
            end
        end
    end
end

-- VÒNG LẶP CHÍNH
THT_HUB.Connection = RunService.Heartbeat:Connect(function()
    if THT_HUB.Enabled then
        THT_HUB.AutoAttack()
        THT_HUB.CollectDrops()
    end
end)

-- GIAO DIỆN ĐIỀU KHIỂN THT HUB
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("THT HUB - Blox Fruits Auto Farm", "Sentinel")

-- HIỂN THỊ THÔNG TIN THT HUB
local InfoTab = Window:NewTab("THT HUB Info")
local InfoSection = InfoTab:NewSection("Thông Tin THT HUB")

InfoSection:NewLabel("Tên: THT HUB")
InfoSection:NewLabel("Phiên bản: 3.0")
InfoSection:NewLabel("Trò chơi: Blox Fruits")
InfoSection:NewLabel("Tác giả: DarkForge-X Research")

local MainTab = Window:NewTab("Auto Farm")
local MainSection = MainTab:NewSection("Cài Đặt Tự Động THT HUB")

MainSection:NewToggle("Bật/Tắt Auto Farm", "Tự động farm level - THT HUB", function(state)
    THT_HUB.Enabled = state
    if state then
        Library:Notification("THT HUB", "Auto Farm đã được kích hoạt!", "ok")
    else
        Library:Notification("THT HUB", "Auto Farm đã tắt!", "warn")
    end
end)

MainSection:NewDropdown("Chọn Khu Vực Farm", "Chọn nơi farm - THT HUB", {"Jungle", "Desert", "Snow Village", "Marine Fortress", "Sky Island"}, function(area)
    THT_HUB.FarmingArea = area
    Library:Notification("THT HUB", "Đã chọn khu vực: " .. area, "ok")
end)

-- TỰ ĐỘNG ĂN TRÁI CÂY
local FruitSection = MainTab:NewSection("Tự Động Ăn Trái - THT HUB")

function THT_HUB.EatFruits()
    for _, fruit in pairs(LocalPlayer.Backpack:GetChildren()) do
        if fruit:IsA("Tool") and fruit.Name:find("Fruit") then
            LocalPlayer.Character.Humanoid:EquipTool(fruit)
            wait(0.5)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
        end
    end
end

FruitSection:NewToggle("Tự Động Ăn Trái", "Tự động ăn trái devil fruit - THT HUB", function(state)
    THT_HUB.AutoEatFruits = state
    if state then
        Library:Notification("THT HUB", "Auto Eat Fruits đã bật!", "ok")
        spawn(function()
            while THT_HUB.AutoEatFruits do
                THT_HUB.EatFruits()
                wait(10)
            end
        end)
    else
        Library:Notification("THT HUB", "Auto Eat Fruits đã tắt!", "warn")
    end
end)

-- TỰ ĐỘNG MUA VẬT PHẨM
local ShopSection = MainTab:NewSection("Tự Động Mua Đồ - THT HUB")

function THT_HUB.BuyItems()
    local shop = workspace:FindFirstChild("Shop") or workspace:FindFirstChild("BlackbeardDealer")
    if shop then
        LocalPlayer.Character.HumanoidRootPart.CFrame = shop.CFrame
        wait(2)
        
        -- Mua vật phẩm
        local args = {
            [1] = "BuyItem",
            [2] = "Combat"
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("Remotes").CommF_:InvokeServer(unpack(args))
    end
end

ShopSection:NewToggle("Tự Động Mua Đồ", "Tự động mua vật phẩm - THT HUB", function(state)
    THT_HUB.AutoBuyItems = state
    if state then
        Library:Notification("THT HUB", "Auto Buy Items đã bật!", "ok")
        spawn(function()
            while THT_HUB.AutoBuyItems do
                THT_HUB.BuyItems()
                wait(60)
            end
        end)
    end
end)

-- TỰ ĐỘNG TRAINING
local TrainingSection = MainTab:NewSection("Auto Training - THT HUB")

function THT_HUB.AutoTrain()
    -- Tự động tập luyện stats
    local args = {
        [1] = "AddPoint",
        [2] = "Melee",
        [3] = 1
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("Remotes").CommF_:InvokeServer(unpack(args))
end

TrainingSection:NewToggle("Tự Động Training", "Tự động training stats - THT HUB", function(state)
    THT_HUB.AutoTraining = state
    if state then
        spawn(function()
            while THT_HUB.AutoTraining do
                THT_HUB.AutoTrain()
                wait(5)
            end
        end)
    end
end)

-- BẢO VỆ CHỐNG KICK
local SafetySection = MainTab:NewSection("Bảo Vệ - THT HUB")

SafetySection:NewToggle("Chống Anti-AFK", "Tránh bị kick - THT HUB", function(state)
    if state then
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        Library:Notification("THT HUB", "Anti-AFK đã kích hoạt!", "ok")
    end
end)

-- CÀI ĐẶT GIAO DIỆN
local SettingsTab = Window:NewTab("Cài Đặt THT HUB")
local ThemeSection = SettingsTab:NewSection("Tùy Chỉnh Giao Diện")

ThemeSection:NewKeybind("Phím Tắt GUI", "Mở/đóng THT HUB", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)

-- KHỞI ĐỘNG THT HUB
THT_HUB.ShowLogo()
Library:Notification("THT HUB", "Đã khởi động thành công!", "ok")

-- TỰ ĐỘNG DỪNG KHI CHẾT
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(function()
        if THT_HUB.Enabled then
            Library:Notification("THT HUB", "Nhân vật đã chết - Tạm dừng Auto Farm", "warn")
        end
    end)
end)