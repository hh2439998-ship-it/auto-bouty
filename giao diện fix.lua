local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLib/main/Source.lua"))()

local Window = RedzLib:MakeWindow({
    Title = "Gavity Hub",
    SubTitle = "by DhuutaiScript",
    Icon = "92816396268641", -- ID mới của bạn
    SaveFolder = "GavityConfig"
})

-- Tạo Tab để test xem ảnh có lên không
local Tab = Window:MakeTab({
    Name = "Thử nghiệm Logo",
    Icon = "rbxassetid://4483362458",
    Premium = false
})

Tab:AddButton({
    Name = "Check Logo",
    Callback = function()
        print("Đang kiểm tra Logo: 92816396268641")
    end
})

RedzLib:MakeNotification({
    Title = "Gavity Hub",
    Text = "Đang tải giao diện...",
    Time = 3
})
