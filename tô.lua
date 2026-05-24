-- HOÀNG ĐẸP TRAI HUB | FULL FEATURES (REDZ STYLE)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Hoàng Đẹp Trai Hub | Blox Fruits", LoadingTitle = "Đang tải dữ liệu...", Theme = "DarkBlue"})

_G.Settings = {Mode = "Level", Weapon = "Melee", AutoFarm = false, Bring = false, Aura = false, TradeBone = false}

-- Tab 1: Farm (Chứa toàn bộ chức năng chọn lựa)
local Tab = Window:CreateTab("Auto Farm", nil)

Tab:CreateDropdown({Name = "Chọn Mode", Options = {"Level", "Bone", "Cake", "Tiki"}, Callback = function(v) _G.Settings.Mode = v[1] end})
Tab:CreateDropdown({Name = "Chọn Vũ khí", Options = {"Melee", "Sword", "Gun", "Fruit"}, Callback = function(v) _G.Settings.Weapon = v[1] end})

-- Chức năng Bring & Attack (Gom quái dưới chân & Đánh)
Tab:CreateToggle({Name = "Auto Farm Active (Gom quái + Đánh)", Callback = function(s)
    _G.Settings.AutoFarm = s
    _G.Settings.Bring = s
    _G.Settings.Aura = s
    
    -- Bring quái dưới chân
    spawn(function()
        while _G.Settings.Bring do
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 100 then
                    v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    v.HumanoidRootPart.CanCollide = false
                end
            end
            task.wait(0.1)
        end
    end)
    
    -- Attack (Remote chuẩn)
    spawn(function()
        while _G.Settings.Aura do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Attack")
            end)
            task.wait(0.01)
        end
    end)
end})

-- Chức năng Auto Quest
Tab:CreateToggle({Name = "Auto Quest (Tự nhận nhiệm vụ)", Callback = function(s)
    _G.Settings.AutoQuest = s
    spawn(function()
        while _G.Settings.AutoQuest do
            pcall(function()
                if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                    game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("StartQuest", "Bandit", 1)
                end
            end)
            task.wait(2)
        end
    end)
end})

-- Chức năng Auto Trade Bone
Tab:CreateToggle({Name = "Auto Trade Bone", Callback = function(s)
    _G.Settings.TradeBone = s
    spawn(function()
        while _G.Settings.TradeBone do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("DeathKing", "Roll")
            end)
            task.wait(1)
        end
    end)
end})

-- Tween Đảo (Hệ thống điều hướng)
Tab:CreateButton({Name = "Tween tới đảo mục tiêu", Callback = function()
    local pos = {
        ["Level"] = Vector3.new(1063, 16, 1545),
        ["Bone"] = Vector3.new(-5030, 315, -3150),
        ["Cake"] = Vector3.new(-2090, 70, -12120)
    }
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, 
    TweenInfo.new(10), {CFrame = CFrame.new(pos[_G.Settings.Mode] or pos["Level"])}):Play()
end})
