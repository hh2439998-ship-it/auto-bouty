-- HOÀNG ĐẸP TRAI HUB | FULL AUTOMATION
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Hoàng Đẹp Trai Hub", LoadingTitle = "Khởi động chiến thần...", Theme = "DarkBlue"})

_G.Settings = {Mode = "Level", Bring = false, Aura = false, AutoTrade = false}

-- Hàm Trade Bone (Đổi xương)
local function TradeBone()
    spawn(function()
        while _G.Settings.AutoTrade do
            pcall(function()
                -- Thay "DeathKing" bằng tên NPC đổi bone nếu cần thiết
                game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("DeathKing", "Roll")
            end)
            task.wait(1)
        end
    end)
end

-- Tab chính
local Tab = Window:CreateTab("Auto Farm Pro", nil)

-- Chọn bãi
Tab:CreateDropdown({Name = "Chọn Bãi Farm", Options = {"Level", "Bone", "Cake", "Tiki"}, Callback = function(v) _G.Settings.Mode = v[1] end})

-- Bring Mob (Local 4 con)
Tab:CreateToggle({Name = "Bring Mobs (Tối đa 4 con)", Callback = function(s)
    _G.Settings.Bring = s
    spawn(function()
        while _G.Settings.Bring do
            local count = 0
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and count < 4 then
                    local dist = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 60 then
                        v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        count = count + 1
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})

-- Kill Aura (Fix lỗi tấn công)
Tab:CreateToggle({Name = "Attack Aura (Fix)", Callback = function(s)
    _G.Settings.Aura = s
    spawn(function()
        while _G.Settings.Aura do
            pcall(function()
                -- Sử dụng Remote chuẩn của Blox Fruits để chắc chắn quái mất máu
                local args = { [1] = "Attack" }
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(unpack(args))
            end)
            task.wait(0.05)
        end
    end)
end})

-- Chức năng Auto Trade Bone (Mới)
Tab:CreateToggle({Name = "Auto Trade Bone", Callback = function(s)
    _G.Settings.AutoTrade = s
    if s then TradeBone() end
end})

-- Tween Đảo (Hệ thống điều hướng)
Tab:CreateButton({Name = "Tween tới bãi đã chọn", Callback = function()
    local Waypoints = {
        ["Bone"] = Vector3.new(-5030, 315, -3150),
        ["Cake"] = Vector3.new(-2090, 70, -12120),
        ["Tiki"] = Vector3.new(-16000, 50, -1500)
    }
    local pos = Waypoints[_G.Settings.Mode]
    if pos then
        local tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, 
        TweenInfo.new(10), {CFrame = CFrame.new(pos)})
        tween:Play()
    end
end})
