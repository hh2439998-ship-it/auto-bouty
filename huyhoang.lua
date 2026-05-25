-- Owner : DhuutaiScript | Gavity Hub System
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroer/Gravity-UI/main/Library.lua"))()
local Window = Library:CreateWindow("Gavity Hub", "Blox Fruits Pro")

-- 1. CÁC BIẾN QUẢN LÝ
_G.AutoFarm = false

-- 2. TÍCH HỢP LOGIC GỐC (Dán vào đây)
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function() end)
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function() end)

-- [BẠN DÁN TIẾP CÁC HÀM CheckQuest, MaterialMon VÀO DƯỚI ĐÂY]
-- (Tôi đã để trống phần này cho bạn dán vào)

-- 3. VÒNG LẶP XỬ LÝ (Trái tim của script)
spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            pcall(function()
                -- Gọi logic của bạn ở đây
                if CheckQuest then CheckQuest() end
                
                -- Gom quái và đánh (Cơ chế cơ bản)
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 100 then
                        v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Attack")
                    end
                end
            end)
        end
    end
end)

-- 4. GIAO DIỆN (Đã fix lỗi hiển thị)
local Tab = Window:AddTab("Gavity Tab")
Tab:AddToggle("Bật Auto Farm", function(state)
    _G.AutoFarm = state
end)

Tab:AddButton("Reset Character", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)
