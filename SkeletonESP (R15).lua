-- Preview: https://cdn.discordapp.com/attachments/807887111667056680/817423626185343016/unknown.png
-- Made by Blissful#4992
local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

for i, v in pairs(game.Players:GetChildren()) do
    local SkeletonTorso = Drawing.new("Line")
    SkeletonTorso.Visible = false
    SkeletonTorso.From = Vector2.new(0, 0)
    SkeletonTorso.To = Vector2.new(200, 200)
    SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
    SkeletonTorso.Thickness = 2
    SkeletonTorso.Transparency = 1

    local SkeletonHead = Drawing.new("Line")
    SkeletonHead.Visible = false
    SkeletonHead.From = Vector2.new(0, 0)
    SkeletonHead.To = Vector2.new(200, 200)
    SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
    SkeletonHead.Thickness = 2
    SkeletonHead.Transparency = 1

    local SkeletonLeftLeg = Drawing.new("Line")
    SkeletonLeftLeg.Visible = false
    SkeletonLeftLeg.From = Vector2.new(0, 0)
    SkeletonLeftLeg.To = Vector2.new(200, 200)
    SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftLeg.Thickness = 2
    SkeletonLeftLeg.Transparency = 1

    local SkeletonRightLeg = Drawing.new("Line")
    SkeletonRightLeg.Visible = false
    SkeletonRightLeg.From = Vector2.new(0, 0)
    SkeletonRightLeg.To = Vector2.new(200, 200)
    SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightLeg.Thickness = 2
    SkeletonRightLeg.Transparency = 1

    local SkeletonLeftArm = Drawing.new("Line")
    SkeletonLeftArm.Visible = false
    SkeletonLeftArm.From = Vector2.new(0, 0)
    SkeletonLeftArm.To = Vector2.new(200, 200)
    SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftArm.Thickness = 2
    SkeletonLeftArm.Transparency = 1

    local SkeletonRightArm = Drawing.new("Line")
    SkeletonRightArm.Visible = false
    SkeletonRightArm.From = Vector2.new(0, 0)
    SkeletonRightArm.To = Vector2.new(200, 200)
    SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightArm.Thickness = 2
    SkeletonRightArm.Transparency = 1

    function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name  and v.Character.Humanoid.Health > 0 then 
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local UpperTorso = camera:WorldToViewportPoint(v.Character.UpperTorso.Position)
                    local LowerTorso = camera:WorldToViewportPoint(v.Character.LowerTorso.Position)

                    local LeftLeg = camera:WorldToViewportPoint(v.Character.LeftFoot.Position)
                    local RightLeg = camera:WorldToViewportPoint(v.Character.RightFoot.Position)

                    local LeftArm = camera:WorldToViewportPoint(v.Character.LeftHand.Position)
                    local RightArm = camera:WorldToViewportPoint(v.Character.RightHand.Position)

                    local Head = camera:WorldToViewportPoint(v.Character.Head.Position)

                    SkeletonTorso.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonTorso.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonHead.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonHead.To = Vector2.new(Head.X, Head.Y)

                    SkeletonLeftLeg.From = Vector2.new(LeftLeg.X, LeftLeg.Y)
                    SkeletonLeftLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonRightLeg.From = Vector2.new(RightLeg.X, RightLeg.Y)
                    SkeletonRightLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonLeftArm.From = Vector2.new(LeftArm.X, LeftArm.Y)
                    SkeletonLeftArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    SkeletonRightArm.From = Vector2.new(RightArm.X, RightArm.Y)
                    SkeletonRightArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    local distance = (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                    local humpos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

                    if v.TeamColor == plr.TeamColor then
                        SkeletonTorso.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonHead.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(0, 255, 0)
                    else 
                        SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
                    end

                    SkeletonTorso.Visible = true
                    SkeletonHead.Visible = true
                    SkeletonLeftArm.Visible = true
                    SkeletonLeftLeg.Visible = true
                    SkeletonRightArm.Visible = true
                    SkeletonRightLeg.Visible = true
                else 
                    SkeletonTorso.Visible = false
                    SkeletonHead.Visible = false
                    SkeletonLeftArm.Visible = false
                    SkeletonLeftLeg.Visible = false
                    SkeletonRightArm.Visible = false
                    SkeletonRightLeg.Visible = false
                end
            else 
                SkeletonTorso.Visible = false
                SkeletonHead.Visible = false
                SkeletonLeftArm.Visible = false
                SkeletonLeftLeg.Visible = false
                SkeletonRightArm.Visible = false
                SkeletonRightLeg.Visible = false
                if game.Players:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

game.Players.PlayerAdded:Connect(function(newplr) --Parameter gets the new player that has been added
    local SkeletonTorso = Drawing.new("Line")
    SkeletonTorso.Visible = false
    SkeletonTorso.From = Vector2.new(0, 0)
    SkeletonTorso.To = Vector2.new(200, 200)
    SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
    SkeletonTorso.Thickness = 2
    SkeletonTorso.Transparency = 1

    local SkeletonHead = Drawing.new("Line")
    SkeletonHead.Visible = false
    SkeletonHead.From = Vector2.new(0, 0)
    SkeletonHead.To = Vector2.new(200, 200)
    SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
    SkeletonHead.Thickness = 2
    SkeletonHead.Transparency = 1

    local SkeletonLeftLeg = Drawing.new("Line")
    SkeletonLeftLeg.Visible = false
    SkeletonLeftLeg.From = Vector2.new(0, 0)
    SkeletonLeftLeg.To = Vector2.new(200, 200)
    SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftLeg.Thickness = 2
    SkeletonLeftLeg.Transparency = 1

    local SkeletonRightLeg = Drawing.new("Line")
    SkeletonRightLeg.Visible = false
    SkeletonRightLeg.From = Vector2.new(0, 0)
    SkeletonRightLeg.To = Vector2.new(200, 200)
    SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightLeg.Thickness = 2
    SkeletonRightLeg.Transparency = 1

    local SkeletonLeftArm = Drawing.new("Line")
    SkeletonLeftArm.Visible = false
    SkeletonLeftArm.From = Vector2.new(0, 0)
    SkeletonLeftArm.To = Vector2.new(200, 200)
    SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonLeftArm.Thickness = 2
    SkeletonLeftArm.Transparency = 1

    local SkeletonRightArm = Drawing.new("Line")
    SkeletonRightArm.Visible = false
    SkeletonRightArm.From = Vector2.new(0, 0)
    SkeletonRightArm.To = Vector2.new(200, 200)
    SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
    SkeletonRightArm.Thickness = 2
    SkeletonRightArm.Transparency = 1

    function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name  and newplr.Character.Humanoid.Health > 0 then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local UpperTorso = camera:WorldToViewportPoint(newplr.Character.UpperTorso.Position)
                    local LowerTorso = camera:WorldToViewportPoint(newplr.Character.LowerTorso.Position)

                    local LeftLeg = camera:WorldToViewportPoint(newplr.Character.LeftFoot.Position)
                    local RightLeg = camera:WorldToViewportPoint(newplr.Character.RightFoot.Position)

                    local LeftArm = camera:WorldToViewportPoint(newplr.Character.LeftHand.Position)
                    local RightArm = camera:WorldToViewportPoint(newplr.Character.RightHand.Position)

                    local Head = camera:WorldToViewportPoint(newplr.Character.Head.Position)

                    SkeletonTorso.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonTorso.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonHead.From = Vector2.new(UpperTorso.X, UpperTorso.Y)
                    SkeletonHead.To = Vector2.new(Head.X, Head.Y)

                    SkeletonLeftLeg.From = Vector2.new(LeftLeg.X, LeftLeg.Y)
                    SkeletonLeftLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonRightLeg.From = Vector2.new(RightLeg.X, RightLeg.Y)
                    SkeletonRightLeg.To = Vector2.new(LowerTorso.X, LowerTorso.Y)

                    SkeletonLeftArm.From = Vector2.new(LeftArm.X, LeftArm.Y)
                    SkeletonLeftArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    SkeletonRightArm.From = Vector2.new(RightArm.X, RightArm.Y)
                    SkeletonRightArm.To = Vector2.new(UpperTorso.X, UpperTorso.Y)

                    local distance = (newplr.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
                    local humpos = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)

                    if newplr.TeamColor == plr.TeamColor then
                        SkeletonTorso.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonHead.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(0, 255, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(0, 255, 0)
                    else 
                        SkeletonTorso.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonHead.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonLeftLeg.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightArm.Color = Color3.fromRGB(255, 0, 0)
                        SkeletonRightLeg.Color = Color3.fromRGB(255, 0, 0)
                    end

                    SkeletonTorso.Visible = true
                    SkeletonHead.Visible = true
                    SkeletonLeftArm.Visible = true
                    SkeletonLeftLeg.Visible = true
                    SkeletonRightArm.Visible = true
                    SkeletonRightLeg.Visible = true
                else 
                    SkeletonTorso.Visible = false
                    SkeletonHead.Visible = false
                    SkeletonLeftArm.Visible = false
                    SkeletonLeftLeg.Visible = false
                    SkeletonRightArm.Visible = false
                    SkeletonRightLeg.Visible = false
                end
            else 
                SkeletonTorso.Visible = false
                SkeletonHead.Visible = false
                SkeletonLeftArm.Visible = false
                SkeletonLeftLeg.Visible = false
                SkeletonRightArm.Visible = false
                SkeletonRightLeg.Visible = false
                if game.Players:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)
