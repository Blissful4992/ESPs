-- Preview: https://cdn.discordapp.com/attachments/807887111667056680/817423626185343016/unknown.png
--// Made by Blissful#4992 - R15 Skeleton ESP
--//Options:
local Settings = {
    Color = Color3.fromRGB(255, 0, 0), -- Color of the lines of the skeleton
    Thickness = 2, -- Thickness of the lines of the Skeleton
    Transparency = 1, -- 1 Visible - 0 Not Visible
    AutoThickness = true -- Makes Thickness above futile, scales according to distance, good for less encumbered screen
}

--//Locals, etc:
local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local function NewLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = Settings.Color
    line.Thickness = Settings.Thickness
    line.Transparency = Settings.Transparency
    return line
end

--//Separation: Main Function

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    local R15
    spawn(function()
        repeat wait() until v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil
        R15 = (v.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false
    end)

    local Spine = {}
    local SpineNames = {}
    local connecthead = NewLine()

    local LLeg = {}
    local LLegNames = {}
    local connectlegleft = NewLine()

    local RLeg = {}
    local RLegNames = {}
    local connectlegright = NewLine()

    local LArm = {}
    local LArmNames = {}
    local connectarmleft = NewLine()

    local RArm = {}
    local RArmNames = {}
    local connectarmright = NewLine()
    
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            if v.Name == "UpperTorso" or v.Name == "Torso" or v.Name == "HumanoidRootPart" or v.Name == "LowerTorso" then
                table.insert(SpineNames, v.Name)
                Spine[v.Name] = NewLine()
            end
            if v.Name == "LeftLeg" or v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "LeftFoot" then
                table.insert(LLegNames, v.Name)
                LLeg[v.Name] = NewLine()
            end
            if v.Name == "RightLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "RightFoot" then
                table.insert(RLegNames, v.Name)
                RLeg[v.Name] = NewLine()
            end
            if v.Name == "LeftArm" or v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
                table.insert(LArmNames, v.Name)
                LArm[v.Name] = NewLine()
            end
            if v.Name == "RightArm" or v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "RightHand" then
                table.insert(RArmNames, v.Name)
                RArm[v.Name] = NewLine()
            end
        end
    end 

    local function ESP()
        local function ConnectLimbs(limb, root, connector)
            if v.Character:FindFirstChild(root) ~= nil and v.Character:FindFirstChild(limb) ~= nil then
                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(root).Position)
                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(limb).Position)
                connector.From = Vector2.new(pos1.X, pos1.Y)
                connector.To = Vector2.new(pos2.X, pos2.Y)
            end
        end
        local function Visibility(state)
            connecthead.Visible = state
            connectarmleft.Visible = state
            connectarmright.Visible = state
            connectlegleft.Visible = state
            connectlegright.Visible = state
            for u, x in pairs(Spine) do
                x.Visible = state
            end
            for u, x in pairs(LLeg) do
                x.Visible = state
            end
            for u, x in pairs(RLeg) do
                x.Visible = state
            end
            for u, x in pairs(LArm) do
                x.Visible = state
            end
            for u, x in pairs(RArm) do
                x.Visible = state
            end
        end
        local function Thickness(state)
            connecthead.Thickness = state
            connectarmleft.Thickness = state
            connectarmright.Thickness = state
            connectlegleft.Thickness = state
            connectlegright.Thickness = state
            for u, x in pairs(Spine) do
                x.Thickness = state
            end
            for u, x in pairs(LLeg) do
                x.Thickness = state
            end
            for u, x in pairs(RLeg) do
                x.Thickness = state
            end
            for u, x in pairs(LArm) do
                x.Thickness = state
            end
            for u, x in pairs(RArm) do
                x.Thickness = state
            end
        end
        local function Color(color)
            connecthead.Color = color
            connectarmleft.Color = color
            connectarmright.Color = color
            connectlegleft.Color = color
            connectlegright.Color = color
            for u, x in pairs(Spine) do
                x.Color = color
            end
            for u, x in pairs(LLeg) do
                x.Color = color
            end
            for u, x in pairs(RLeg) do
                x.Color = color
            end
            for u, x in pairs(LArm) do
                x.Color = color
            end
            for u, x in pairs(RArm) do
                x.Color = color
            end
        end

        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name and v.Character.Humanoid.Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if vis then 
                    if R15 then
                        local a = 0
                        for u, x in pairs(Spine) do
                            a=a+1
                            if SpineNames[a+1] ~= nil and v.Character:FindFirstChild(SpineNames[a+1]) ~= nil and v.Character:FindFirstChild(SpineNames[a+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(SpineNames[a]).Position)
                                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(SpineNames[a+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local b = 0
                        for u, x in pairs(LArm) do
                            b=b+1
                            if LArmNames[b+1] ~= nil and v.Character:FindFirstChild(LArmNames[b+1]) ~= nil and v.Character:FindFirstChild(LArmNames[b+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(LArmNames[b]).Position)
                                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(LArmNames[b+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local c = 0
                        for u, x in pairs(RArm) do
                            c=c+1
                            if RArmNames[c+1] ~= nil and v.Character:FindFirstChild(RArmNames[c+1]) ~= nil and v.Character:FindFirstChild(RArmNames[c+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(RArmNames[c]).Position)
                                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(RArmNames[c+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local d = 0
                        for u, x in pairs(LLeg) do
                            d=d+1
                            if LLegNames[d+1] ~= nil and v.Character:FindFirstChild(LLegNames[d+1]) ~= nil and v.Character:FindFirstChild(LLegNames[d+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(LLegNames[d]).Position)
                                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(LLegNames[d+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local e = 0
                        for u, x in pairs(RLeg) do
                            e=e+1
                            if RLegNames[e+1] ~= nil and v.Character:FindFirstChild(RLegNames[e+1]) ~= nil and v.Character:FindFirstChild(RLegNames[e+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(v.Character:FindFirstChild(RLegNames[e]).Position)
                                local pos2 = camera:WorldToViewportPoint(v.Character:FindFirstChild(RLegNames[e+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        
                        ConnectLimbs("LeftUpperArm", "UpperTorso", connectarmleft)
                        ConnectLimbs("RightUpperArm", "UpperTorso", connectarmright)
                        ConnectLimbs("LeftUpperLeg", "LowerTorso", connectlegleft)
                        ConnectLimbs("RightUpperLeg", "LowerTorso", connectlegright)
                        ConnectLimbs("UpperTorso", "Head", connecthead)
                    end

                    if Settings.AutoThickness then
                        local distance = (plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 3) --0.1 is min thickness, 4 is max
                        Thickness(value)
                    else 
                        Thickness(Settings.Thickness)
                    end

                    Visibility(true)
                else 
                    Visibility(false)
                end
            else 
                Visibility(false)
                if game.Players:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

--// Made by Blissful#4992

-- For when a player gets added:
game.Players.PlayerAdded:Connect(function(newplr)
    repeat wait() until newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil
    local R15 = (newplr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false

    local Spine = {}
    local SpineNames = {}
    local connecthead = NewLine()

    local LLeg = {}
    local LLegNames = {}
    local connectlegleft = NewLine()

    local RLeg = {}
    local RLegNames = {}
    local connectlegright = NewLine()

    local LArm = {}
    local LArmNames = {}
    local connectarmleft = NewLine()

    local RArm = {}
    local RArmNames = {}
    local connectarmright = NewLine()
    
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= 1 then
            if v.Name == "UpperTorso" or v.Name == "Torso" or v.Name == "HumanoidRootPart" or v.Name == "LowerTorso" then
                table.insert(SpineNames, v.Name)
                Spine[v.Name] = NewLine()
            end
            if v.Name == "LeftLeg" or v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "LeftFoot" then
                table.insert(LLegNames, v.Name)
                LLeg[v.Name] = NewLine()
            end
            if v.Name == "RightLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "RightFoot" then
                table.insert(RLegNames, v.Name)
                RLeg[v.Name] = NewLine()
            end
            if v.Name == "LeftArm" or v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
                table.insert(LArmNames, v.Name)
                LArm[v.Name] = NewLine()
            end
            if v.Name == "RightArm" or v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "RightHand" then
                table.insert(RArmNames, v.Name)
                RArm[v.Name] = NewLine()
            end
        end
    end
    

    local function ESP()
        local function ConnectLimbs(limb, root, connector)
            if newplr.Character:FindFirstChild(root) ~= nil and newplr.Character:FindFirstChild(limb) ~= nil then
                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(root).Position)
                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(limb).Position)
                connector.From = Vector2.new(pos1.X, pos1.Y)
                connector.To = Vector2.new(pos2.X, pos2.Y)
            end
        end
        local function Visibility(state)
            connecthead.Visible = state
            connectarmleft.Visible = state
            connectarmright.Visible = state
            connectlegleft.Visible = state
            connectlegright.Visible = state
            for u, x in pairs(Spine) do
                x.Visible = state
            end
            for u, x in pairs(LLeg) do
                x.Visible = state
            end
            for u, x in pairs(RLeg) do
                x.Visible = state
            end
            for u, x in pairs(LArm) do
                x.Visible = state
            end
            for u, x in pairs(RArm) do
                x.Visible = state
            end
        end
        local function Thickness(state)
            connecthead.Thickness = state
            connectarmleft.Thickness = state
            connectarmright.Thickness = state
            connectlegleft.Thickness = state
            connectlegright.Thickness = state
            for u, x in pairs(Spine) do
                x.Thickness = state
            end
            for u, x in pairs(LLeg) do
                x.Thickness = state
            end
            for u, x in pairs(RLeg) do
                x.Thickness = state
            end
            for u, x in pairs(LArm) do
                x.Thickness = state
            end
            for u, x in pairs(RArm) do
                x.Thickness = state
            end
        end
        local function Color(color)
            connecthead.Color = color
            connectarmleft.Color = color
            connectarmright.Color = color
            connectlegleft.Color = color
            connectlegright.Color = color
            for u, x in pairs(Spine) do
                x.Color = color
            end
            for u, x in pairs(LLeg) do
                x.Color = color
            end
            for u, x in pairs(RLeg) do
                x.Color = color
            end
            for u, x in pairs(LArm) do
                x.Color = color
            end
            for u, x in pairs(RArm) do
                x.Color = color
            end
        end

        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name  and newplr.Character.Humanoid.Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if vis then 
                    if R15 then
                        local a = 0
                        for u, x in pairs(Spine) do
                            a=a+1
                            if SpineNames[a+1] ~= nil and newplr.Character:FindFirstChild(SpineNames[a+1]) ~= nil and newplr.Character:FindFirstChild(SpineNames[a+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(SpineNames[a]).Position)
                                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(SpineNames[a+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local b = 0
                        for u, x in pairs(LArm) do
                            b=b+1
                            if LArmNames[b+1] ~= nil and newplr.Character:FindFirstChild(LArmNames[b+1]) ~= nil and newplr.Character:FindFirstChild(LArmNames[b+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(LArmNames[b]).Position)
                                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(LArmNames[b+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local c = 0
                        for u, x in pairs(RArm) do
                            c=c+1
                            if RArmNames[c+1] ~= nil and newplr.Character:FindFirstChild(RArmNames[c+1]) ~= nil and newplr.Character:FindFirstChild(RArmNames[c+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(RArmNames[c]).Position)
                                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(RArmNames[c+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local d = 0
                        for u, x in pairs(LLeg) do
                            d=d+1
                            if LLegNames[d+1] ~= nil and newplr.Character:FindFirstChild(LLegNames[d+1]) ~= nil and newplr.Character:FindFirstChild(LLegNames[d+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(LLegNames[d]).Position)
                                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(LLegNames[d+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        local e = 0
                        for u, x in pairs(RLeg) do
                            e=e+1
                            if RLegNames[e+1] ~= nil and newplr.Character:FindFirstChild(RLegNames[e+1]) ~= nil and newplr.Character:FindFirstChild(RLegNames[e+1]).Position ~= nil then
                                local pos1 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(RLegNames[e]).Position)
                                local pos2 = camera:WorldToViewportPoint(newplr.Character:FindFirstChild(RLegNames[e+1]).Position)
                                x.From = Vector2.new(pos1.X, pos1.Y)
                                x.To = Vector2.new(pos2.X, pos2.Y)
                            end
                        end
                        
                        ConnectLimbs("LeftUpperArm", "UpperTorso", connectarmleft)
                        ConnectLimbs("RightUpperArm", "UpperTorso", connectarmright)
                        ConnectLimbs("LeftUpperLeg", "LowerTorso", connectlegleft)
                        ConnectLimbs("RightUpperLeg", "LowerTorso", connectlegright)
                        ConnectLimbs("UpperTorso", "Head", connecthead)
                    end

                    if Settings.AutoThickness then
                        local distance = (plr.Character.HumanoidRootPart.Position - newplr.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 3) --0.1 is min thickness, 4 is max
                        Thickness(value)
                    else 
                        Thickness(Settings.Thickness)
                    end

                    Visibility(true)
                else 
                    Visibility(false)
                end
            else 
                Visibility(false)
                if game.Players:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)
--// Made by Blissful#4992
