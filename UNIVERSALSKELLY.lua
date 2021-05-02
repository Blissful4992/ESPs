-- Made by Blissful#4992
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")

local Settings = {
    Color = Color3.fromRGB(255, 0, 0),
    Thickness = 1,
    Transparency = 0.75
}

local function NewLine(color, thickness, transparency)
    local l = Drawing.new("Line")
    l.Visible = false
    l.Color = color
    l.Transparency = transparency
    l.Thickness = thickness
    l.From = Vector2.new(0, 0)
    l.To = Vector2.new(0, 0)
    return l
end
local function Visibility(table, state)
    for _,v in pairs(table) do
        v[1].Visible = state
    end
end

local function SKELETON(plr)
    local library = {}
    local c = 0
    for _,v in pairs(plr.Character:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            c = c + 1
            library[c] = {NewLine(Settings.Color, Settings.Thickness, Settings.Transparency), v.Name}
        end
    end
    local function UPDATE()
        local c 
        c = RS.RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                for _,v in pairs(library) do
                    if plr.Character:FindFirstChild(v[2]) ~= nil then
                        local Part = plr.Character[v[2]]
                        local Connected = Part:FindFirstChildOfClass("Motor6D").Part0
                        if Connected.Name ~= "HumanoidRootPart" then
                            local p1, v1 = Camera:WorldToViewportPoint(Part.Position)
                            local p2, v2 = Camera:WorldToViewportPoint(Connected.Position)
                            if v1 and v2 then
                                v[1].From = Vector2.new(p1.X, p1.Y)
                                v[1].To = Vector2.new(p2.X, p2.Y)
                                v[1].Visible = true
                            else 
                                v[1].Visible = false
                            end
                        else 
                            v[1].Visible = false
                        end
                    else 
                        v[1].Visible = false
                    end
                end
            else 
                Visibility(library, false)
                if Players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(UPDATE)()
end

for _,v in pairs(Players:GetPlayers()) do
    if v.Name ~= Player.Name then
        SKELETON(v)
    end
end

Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        SKELETON(v)
    end
end)
