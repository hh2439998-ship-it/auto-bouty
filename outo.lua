-- HOÀNG ĐẸP TRAI HUB - BẢN TỐI ƯU TỰ ĐỘNG HÓA
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Hoàng Đẹp Trai Hub | Pro Auto", LoadingTitle = "Đang tối ưu hóa bãi farm...", Theme = "DarkBlue"})

_G.Settings = {AutoFarm = false, Bring = false, Aura = false}

-- 1. Hàm Bring Mob "Dưới chân" (Hút quái chính xác vào tọa độ người chơi)
local function BringMobsUnderFeet()
    spawn(function()
        while _G.Settings.Bring do
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local dist = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 80 then -- Phạm vi hút bãi
                        v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

-- 2. Hàm Attack Aura (Đánh 100% bằng Remote chuẩn - Không dùng VirtualUser)
local function AttackLogic()
    spawn(function()
        while _G.Settings.Aura do
            pcall(function()
                -- Thay thế FireServer Combat bằng Remote cụ thể của game
                local Remotes = game:GetService("ReplicatedStorage").Remotes
                if Remotes:FindFirstChild("Combat") then
                    Remotes.Combat:FireServer("Attack")
                end
            end)
            task.wait(0.01)
        end
    end)
end

-- 3. Auto Quest (Tự động nhận nhiệm vụ)
local function AutoQuest()
    spawn(function()
        while _G.Settings.AutoFarm do
            pcall(function()
                if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                    -- Gọi Remote nhận Quest (Bạn cần lấy tên Quest phù hợp với đảo)
                    game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("StartQuest", "Bandit", 1)
                end
            end)
            task.wait(2)
        end
    end)
end

-- Tab Cài đặt
local Tab = Window:CreateTab("Auto Farm Pro", nil)
Tab:CreateToggle({Name = "Auto Farm Active (Quest + Attack)", Callback = function(s) 
    _G.Settings.AutoFarm = s; _G.Settings.Aura = s; _G.Settings.Bring = s;
    if s then AttackLogic(); BringMobsUnderFeet(); AutoQuest() end 
end})
