-- Sử dụng đường link Redz UI V5 mới nhất (Không bị lỗi sập web)
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

-- Khởi tạo Giao diện chính
local Window = redzlib:MakeWindow({
  Title = "Gavity Hub",
  SubTitle = "by DhuutaiScript",
  SaveFolder = "GavityConfig.lua"
})

-- Tạo nút Thu nhỏ (Minimize) có Logo của bạn (Giống 100% Redz Hub)
Window:AddMinimizeButton({
  Button = { 
      Image = "rbxassetid://92816396268641", -- Logo mới của bạn đã được chèn vào đây
      BackgroundTransparency = 0 
  },
  Corner = { CornerRadius = UDim.new(0, 6) }
})

-- Tạo Tab Trang Chủ
local MainTab = Window:MakeTab({"Trang chủ", "home"})

-- Tạo nút bấm thử nghiệm
MainTab:AddButton({"Test Giao Diện", function()
  Redzlib:MakeNotification({
    Title = "Gavity Hub",
    Text = "Nút bấm hoạt động tốt!",
    Time = 3
  })
end})

-- Thông báo khi bật Script
redzlib:MakeNotification({
  Title = "Gavity Hub",
  Text = "Đã tải giao diện thành công!",
  Time = 5
})
