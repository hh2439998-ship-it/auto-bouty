-- Owner : DhuutaiScript | Giao diện: Gavity Hub
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroer/Gravity-UI/main/Library.lua"))()
local Window = Library:CreateWindow("Gavity Hub", "Blox Fruits Pro System")

-- 1. KHỞI TẠO CÁC BIẾN CƠ BẢN
_G.AutoFarm = false
_G.AutoTrade = false
_G.SelectMaterial = ""

-- 2. TẠO CÁC TAB TRONG GIAO DIỆN
local MainTab = Window:AddTab("Auto Farm")
local MiscTab = Window:AddTab("Misc")

-- 3. CÁC NÚT ĐIỀU KHIỂN (Toggle & Button)
MainTab:AddToggle("Bật Auto Farm", function(state)
    _G.AutoFarm = state
    if state then
        print("Đang chạy Auto Farm...")
        -- Chỗ này sẽ gọi hàm Logic chính
    end
end)

MainTab:AddToggle("Auto Trade Bone", function(state)
    _G.AutoTrade = state
    if state then
        spawn(function()
            while _G.AutoTrade do
                game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("DeathKing", "Roll")
                task.wait(1)
            end
        end)
    end
end)

MiscTab:AddButton("Tween Tới Đảo", function()
    -- Hệ thống Tween
    print("Đang di chuyển...")
end)

-- 4. PHẦN BẠN CẦN DÁN LOGIC VÀO:
-- [Dán các hàm CheckQuest, MaterialMon, và các Hook của bạn xuống dưới đây]

-- Ví dụ:
-- function CheckQuest()
--     ... code cũ của bạn ...
-- end

print("Gavity Hub đã sẵn sàng!")
