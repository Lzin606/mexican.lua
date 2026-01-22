-- Mexican UI - Nova Atualização 2.0 (Lógica Completa)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Janela Principal
local Window = Rayfield:CreateWindow({
    Name = "Mexican | Nova Atualização 2.0",
    LoadingTitle = "Mexican Script",
    LoadingSubtitle = "Ativando Funções...",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Variáveis de Controle
local InfJumpEnabled = false
local ESPEnabled = false

-- --- TABS ---
local EspTab = Window:CreateTab("ESP", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local VisualTab = Window:CreateTab("Visual", 4483362458)
local PerformanceTab = Window:CreateTab("Performance", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- --- ESP SECTION ---
EspTab:CreateSection("ESP Functions")

local function ApplyESP(plr)
    if plr.Character and not plr.Character:FindFirstChild("MexicanHighlight") then
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "MexicanHighlight"
        Highlight.Parent = plr.Character
        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    end
end

EspTab:CreateToggle({
    Name = "ESP Player",
    CurrentValue = false,
    Callback = function(Value)
        ESPEnabled = Value
        RunService.Heartbeat:Connect(function()
            if ESPEnabled then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        ApplyESP(plr)
                    end
                end
            else
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr.Character and plr.Character:FindFirstChild("MexicanHighlight") then
                        plr.Character.MexicanHighlight:Destroy()
                    end
                end
            end
        end)
    end
})

EspTab:CreateToggle({
    Name = "X-Ray Bases",
    CurrentValue = false,
    Callback = function(Value)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:find("Wall") or obj.Name:find("Floor")) then
                obj.LocalTransparencyModifier = Value and 0.5 or 0
            end
        end
    end
})

-- --- PLAYER SECTION ---
PlayerTab:CreateSection("Player Functions")

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        InfJumpEnabled = Value
    end
})

-- Lógica do Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

PlayerTab:CreateSlider({
    Name = "FOV Changer",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 70,
    Callback = function(Value)
        Camera.FieldOfView = Value
    end
})

-- --- VISUAL SECTION ---
VisualTab:CreateSection("Visual Functions")

VisualTab:CreateToggle({
    Name = "RGB Bases (Disco Mode)",
    CurrentValue = false,
    Callback = function(Value)
        _G.RGBBases = Value
        spawn(function()
            while _G.RGBBases do
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name:find("Base") then
                        part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
})

-- --- PERFORMANCE SECTION ---
PerformanceTab:CreateSection("Performance")

PerformanceTab:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                end
            end
        end
    end
})

-- --- MISC SECTION ---
MiscTab:CreateSection("Misc")

MiscTab:CreateToggle({
    Name = "Anti-AFK",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end
    end
})

MiscTab:CreateButton({
    Name = "Fechar Interface",
    Callback = function()
        Rayfield:Destroy()
    end
})

Rayfield:Notify({
    Title = "Mexican",
    Content = "Script Carregado com Sucesso!",
    Duration = 5
})
