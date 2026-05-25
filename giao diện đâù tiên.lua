-- Load Redz UI Library
local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLib/main/Source.lua"))()

-- Khởi tạo Window
local Window = RedzLib:MakeWindow({
    Title = "Gavity Hub",
    SubTitle = "by DhuutaiScript",
    Icon = "109601226345105", -- Đặt ID ảnh của bạn vào đây làm Logo
    SaveFolder = "GavityConfig"
})

-- Tạo Tab
local Tab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

-- Tạo nút chức năng
Tab:AddButton({
    Name = "Kích hoạt Auto",
    Callback = function()
        print("Đã nhấn nút!")
    end
})

-- Thông báo
RedzLib:MakeNotification({
    Title = "Gavity Hub",
    Text = "Giao diện đã tải thành công!",
    Time = 5
})
