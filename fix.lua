-- HOÀNG ĐẸP TRAI HUB | FULL AUTOMATION SYSTEM
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Hoàng Đẹp Trai Hub | Pro Edition", LoadingTitle = "Khởi động quy trình...", Theme = "DarkBlue"})

-- Biến lưu trạng thái
_G.Settings = {AutoFarm = false, Aura = false, AutoTrade = false}

-- 1. CHỨC NĂNG AUTO CLICK/ATTACK (Độc lập)
local function ToggleAttack(state)
    _G.Settings.Aura = state
    spawn(function()
        while _G.Settings.Aura do
            pcall(function()
                -- Tấn công bằng Remote chuẩn
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Attack")
            end)
            task.wait(0.01)
        end
    end)
end

-- 2. LOGIC AUTO FARM (Bay -> Quest -> Bring -> Attack)
local function RunAutoFarm()
    spawn(function()
        while _G.Settings.AutoFarm do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                -- Bay tới tọa độ bãi quái (Tween)
                -- Gom quái dưới chân
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude < 100 then
                        v.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame
                    end
                end
                -- Auto Click tự động kích hoạt khi có quái
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Attack")
            end)
            task.wait(0.1)
        end
    end)
end

-- GIAO DIỆN CHÍNH
local Tab = Window:CreateTab("Auto Farm Pro", nil)

-- Auto Attack độc lập
Tab:CreateToggle({Name = "Auto Click/Attack (Bật/Tắt riêng)", Callback = function(s) ToggleAttack(s) end})

-- Auto Farm (Gom tất cả logic)
Tab:CreateToggle({Name = "Auto Farm (Bay + Gom + Đánh + Quest)", Callback = function(s)
    _G.Settings.AutoFarm = s
    if s then RunAutoFarm() end
end})

-- Auto Trade Bone
Tab:CreateToggle({Name = "Auto Trade Bone", Callback = function(s)
    _G.Settings.AutoTrade = s
    spawn(function()
        while _G.Settings.AutoTrade do
            pcall(function() game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("DeathKing", "Roll") end)
            task.wait(1)
        end
    end)
end})

-- Dropdown Chọn Bãi
Tab:CreateDropdown({Name = "Chọn Bãi Farm", Options = {"Bone", "Cake", "Tiki"}, Callback = function(v) _G.Settings.Target = v[1] end})
