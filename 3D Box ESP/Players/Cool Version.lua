-- Preview = https://gyazo.com/ab2250ff7206f3b86bc4f479d79f0644
--// Made by Blissful#4992
--// Locals:
local workspace = game:GetService("Workspace")
local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera

--// Settings:
local on = true -- Use this if your making gui

local Box_Color = Color3.fromRGB(255, 0, 0)
local Box_Thickness = 2
local Box_Transparency = 1 -- 1 Visible, 0 Not Visible

local Tracers = true
local Tracer_Color = Color3.fromRGB(255, 0, 0)
local Tracer_Thickness = 2
local Tracer_Transparency = 1 -- 1 Visible, 0 Not Visible

local Shifter_Color = Color3.fromRGB(0, 255, 0)

local Autothickness = true -- Makes screen less encumbered

local Team_Check = true
local red = Color3.fromRGB(227, 52, 52)
local green = Color3.fromRGB(88, 217, 24)


function Lerp(a, b, t)
    return a + (b - a) * t
end

--// Main Function:
for i, v in pairs(game.Players:GetChildren()) do
    --// Lines for 3D box (12)
    local line1 = Drawing.new("Line")
    line1.Visible = false
    line1.Color = Box_Color
    line1.Thickness = Box_Thickness
    line1.Transparency = Box_Transparency

    local line2 = Drawing.new("Line")
    line2.Visible = false
    line2.Color = Box_Color
    line2.Thickness = Box_Thickness
    line2.Transparency = Box_Transparency

    local line3 = Drawing.new("Line")
    line3.Visible = false
    line3.Color = Box_Color
    line3.Thickness = Box_Thickness
    line3.Transparency = Box_Transparency

    local line4 = Drawing.new("Line")
    line4.Visible = false
    line4.Color = Box_Color
    line4.Thickness = Box_Thickness
    line4.Transparency = Box_Transparency

    local line5 = Drawing.new("Line")
    line5.Visible = false
    line5.Color = Box_Color
    line5.Thickness = Box_Thickness
    line5.Transparency = Box_Transparency

    local line6 = Drawing.new("Line")
    line6.Visible = false
    line6.Color = Box_Color
    line6.Thickness = Box_Thickness
    line6.Transparency = Box_Transparency

    local line7 = Drawing.new("Line")
    line7.Visible = false
    line7.Color = Box_Color
    line7.Thickness = Box_Thickness
    line7.Transparency = Box_Transparency

    local line8 = Drawing.new("Line")
    line8.Visible = false
    line8.Color = Box_Color
    line8.Thickness = Box_Thickness
    line8.Transparency = Box_Transparency

    local line9 = Drawing.new("Line")
    line9.Visible = false
    line9.Color = Box_Color
    line9.Thickness = Box_Thickness
    line9.Transparency = Box_Transparency

    local line10 = Drawing.new("Line")
    line10.Visible = false
    line10.Color = Box_Color
    line10.Thickness = Box_Thickness
    line10.Transparency = Box_Transparency

    local line11 = Drawing.new("Line")
    line11.Visible = false
    line11.Color = Box_Color
    line11.Thickness = Box_Thickness
    line11.Transparency = Box_Transparency

    local line12 = Drawing.new("Line")
    line12.Visible = false
    line12.Color = Box_Color
    line12.Thickness = Box_Thickness
    line12.Transparency = Box_Transparency
    
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Tracer_Color
    Tracer.Thickness = Tracer_Thickness
    Tracer.Transparency = Tracer_Transparency

    local Shifter = Drawing.new("Quad")
    Shifter.Visible = false
    Shifter.Color = Shifter_Color
    Shifter.Thickness = Box_Thickness
    Shifter.Filled = false
    Shifter.Transparency = Box_Transparency

    local debounce = 0
    local shifteroffset = 0

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= player.Name  and v.Character.Humanoid.Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if vis then
                    local Scale = v.Character.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    line1.From = Vector2.new(Top1.X, Top1.Y)
                    line1.To = Vector2.new(Top2.X, Top2.Y)

                    line2.From = Vector2.new(Top2.X, Top2.Y)
                    line2.To = Vector2.new(Top3.X, Top3.Y)

                    line3.From = Vector2.new(Top3.X, Top3.Y)
                    line3.To = Vector2.new(Top4.X, Top4.Y)

                    line4.From = Vector2.new(Top4.X, Top4.Y)
                    line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    line9.To = Vector2.new(Top1.X, Top1.Y)

                    line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    line10.To = Vector2.new(Top2.X, Top2.Y)

                    line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    line11.To = Vector2.new(Top3.X, Top3.Y)

                    line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)

                        Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Shifter:
                    if debounce == 0 then
                        debounce = debounce + 1
                        spawn(function()
                            for i = 0, Size.Y, 0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end
                            
                            for i = shifteroffset, 0, -0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end

                            for i = 0, -Size.Y, -0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end

                            for i = shifteroffset, 0, 0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end
                            debounce = 0
                        end)
                    end

                    local shifter1 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, shifteroffset, -Size.Z)).p)
                    local shifter2 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, shifteroffset, Size.Z)).p)
                    local shifter3 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, shifteroffset, Size.Z)).p)
                    local shifter4 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, shifteroffset, -Size.Z)).p)

                    Shifter.PointA = Vector2.new(shifter1.X, shifter1.Y)
                    Shifter.PointB = Vector2.new(shifter2.X, shifter2.Y)
                    Shifter.PointC = Vector2.new(shifter3.X, shifter3.Y)
                    Shifter.PointD = Vector2.new(shifter4.X, shifter4.Y)

                    --// Teamcheck:
                    if Team_Check then
                        if v.TeamColor == player.TeamColor then
                            line1.Color = green
                            line2.Color = green
                            line3.Color = green
                            line4.Color = green
                            line5.Color = green
                            line6.Color = green
                            line7.Color = green
                            line8.Color = green
                            line9.Color = green
                            line10.Color = green
                            line11.Color = green
                            line12.Color = green
                            Tracer.Color = green
                            Shifter.Color = green
                        else 
                            line1.Color = red
                            line2.Color = red
                            line3.Color = red
                            line4.Color = red
                            line5.Color = red
                            line6.Color = red
                            line7.Color = red
                            line8.Color = red
                            line9.Color = red
                            line10.Color = red
                            line11.Color = red
                            line12.Color = red
                            Tracer.Color = red
                            Shifter.Color = red
                        end
                    end

                    --// Autothickness:
                    if Autothickness then
                        local distance = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        line1.Thickness = value
                        line2.Thickness = value
                        line3.Thickness = value
                        line4.Thickness = value
                        line5.Thickness = value
                        line6.Thickness = value
                        line7.Thickness = value
                        line8.Thickness = value
                        line9.Thickness = value
                        line10.Thickness = value
                        line11.Thickness = value
                        line12.Thickness = value
                        Shifter.Thickness = value
                    else 
                        line1.Thickness = Box_Thickness
                        line2.Thickness = Box_Thickness
                        line3.Thickness = Box_Thickness
                        line4.Thickness = Box_Thickness
                        line5.Thickness = Box_Thickness
                        line6.Thickness = Box_Thickness
                        line7.Thickness = Box_Thickness
                        line8.Thickness = Box_Thickness
                        line9.Thickness = Box_Thickness
                        line10.Thickness = Box_Thickness
                        line11.Thickness = Box_Thickness
                        line12.Thickness = Box_Thickness
                        Shifter.Thickness = Box_Thickness
                    end

                    line1.Visible = true
                    line2.Visible = true
                    line3.Visible = true
                    line4.Visible = true
                    line5.Visible = true
                    line6.Visible = true
                    line7.Visible = true
                    line8.Visible = true
                    line9.Visible = true
                    line10.Visible = true
                    line11.Visible = true
                    line12.Visible = true
                    Shifter.Visible = true
                    if Tracers then
                        Tracer.Visible = true
                    end
                else 
                    line1.Visible = false
                    line2.Visible = false
                    line3.Visible = false
                    line4.Visible = false
                    line5.Visible = false
                    line6.Visible = false
                    line7.Visible = false
                    line8.Visible = false
                    line9.Visible = false
                    line10.Visible = false
                    line11.Visible = false
                    line12.Visible = false
                    Tracer.Visible = false
                    Shifter.Visible = false
                end
            else 
                line1.Visible = false
                line2.Visible = false
                line3.Visible = false
                line4.Visible = false
                line5.Visible = false
                line6.Visible = false
                line7.Visible = false
                line8.Visible = false
                line9.Visible = false
                line10.Visible = false
                line11.Visible = false
                line12.Visible = false
                Tracer.Visible = false
                Shifter.Visible = false
                if game.Players:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

game.Players.PlayerAdded:Connect(function(newplr)
    --// Lines for 3D box (12)
    local line1 = Drawing.new("Line")
    line1.Visible = false
    line1.Color = Box_Color
    line1.Thickness = Box_Thickness
    line1.Transparency = Box_Transparency

    local line2 = Drawing.new("Line")
    line2.Visible = false
    line2.Color = Box_Color
    line2.Thickness = Box_Thickness
    line2.Transparency = Box_Transparency

    local line3 = Drawing.new("Line")
    line3.Visible = false
    line3.Color = Box_Color
    line3.Thickness = Box_Thickness
    line3.Transparency = Box_Transparency

    local line4 = Drawing.new("Line")
    line4.Visible = false
    line4.Color = Box_Color
    line4.Thickness = Box_Thickness
    line4.Transparency = Box_Transparency

    local line5 = Drawing.new("Line")
    line5.Visible = false
    line5.Color = Box_Color
    line5.Thickness = Box_Thickness
    line5.Transparency = Box_Transparency

    local line6 = Drawing.new("Line")
    line6.Visible = false
    line6.Color = Box_Color
    line6.Thickness = Box_Thickness
    line6.Transparency = Box_Transparency

    local line7 = Drawing.new("Line")
    line7.Visible = false
    line7.Color = Box_Color
    line7.Thickness = Box_Thickness
    line7.Transparency = Box_Transparency

    local line8 = Drawing.new("Line")
    line8.Visible = false
    line8.Color = Box_Color
    line8.Thickness = Box_Thickness
    line8.Transparency = Box_Transparency

    local line9 = Drawing.new("Line")
    line9.Visible = false
    line9.Color = Box_Color
    line9.Thickness = Box_Thickness
    line9.Transparency = Box_Transparency

    local line10 = Drawing.new("Line")
    line10.Visible = false
    line10.Color = Box_Color
    line10.Thickness = Box_Thickness
    line10.Transparency = Box_Transparency

    local line11 = Drawing.new("Line")
    line11.Visible = false
    line11.Color = Box_Color
    line11.Thickness = Box_Thickness
    line11.Transparency = Box_Transparency

    local line12 = Drawing.new("Line")
    line12.Visible = false
    line12.Color = Box_Color
    line12.Thickness = Box_Thickness
    line12.Transparency = Box_Transparency
    
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Tracer_Color
    Tracer.Thickness = Tracer_Thickness
    Tracer.Transparency = Tracer_Transparency

    local Shifter = Drawing.new("Quad")
    Shifter.Visible = false
    Shifter.Color = Shifter_Color
    Shifter.Thickness = Box_Thickness
    Shifter.Filled = false
    Shifter.Transparency = Box_Transparency

    local debounce = 0
    local shifteroffset = 0

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= player.Name  and newplr.Character.Humanoid.Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if vis then
                    local Scale = newplr.Character.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    line1.From = Vector2.new(Top1.X, Top1.Y)
                    line1.To = Vector2.new(Top2.X, Top2.Y)

                    line2.From = Vector2.new(Top2.X, Top2.Y)
                    line2.To = Vector2.new(Top3.X, Top3.Y)

                    line3.From = Vector2.new(Top3.X, Top3.Y)
                    line3.To = Vector2.new(Top4.X, Top4.Y)

                    line4.From = Vector2.new(Top4.X, Top4.Y)
                    line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    line9.To = Vector2.new(Top1.X, Top1.Y)

                    line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    line10.To = Vector2.new(Top2.X, Top2.Y)

                    line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    line11.To = Vector2.new(Top3.X, Top3.Y)

                    line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)

                        Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Shifter:
                    if debounce == 0 then
                        debounce = debounce + 1
                        spawn(function()
                            for i = 0, Size.Y, 0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end
                            
                            for i = shifteroffset, 0, -0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end

                            for i = 0, -Size.Y, -0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end

                            for i = shifteroffset, 0, 0.1 do
                                shifteroffset = Lerp(shifteroffset, i, 0.5)
                                wait()
                            end
                            debounce = 0
                        end)
                    end

                    local shifter1 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, shifteroffset, -Size.Z)).p)
                    local shifter2 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, shifteroffset, Size.Z)).p)
                    local shifter3 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, shifteroffset, Size.Z)).p)
                    local shifter4 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, shifteroffset, -Size.Z)).p)

                    Shifter.PointA = Vector2.new(shifter1.X, shifter1.Y)
                    Shifter.PointB = Vector2.new(shifter2.X, shifter2.Y)
                    Shifter.PointC = Vector2.new(shifter3.X, shifter3.Y)
                    Shifter.PointD = Vector2.new(shifter4.X, shifter4.Y)

                    --// Teamcheck:
                    if Team_Check then
                        if newplr.TeamColor == player.TeamColor then
                            line1.Color = green
                            line2.Color = green
                            line3.Color = green
                            line4.Color = green
                            line5.Color = green
                            line6.Color = green
                            line7.Color = green
                            line8.Color = green
                            line9.Color = green
                            line10.Color = green
                            line11.Color = green
                            line12.Color = green
                            Tracer.Color = green
                            Shifter.Color = green
                        else 
                            line1.Color = red
                            line2.Color = red
                            line3.Color = red
                            line4.Color = red
                            line5.Color = red
                            line6.Color = red
                            line7.Color = red
                            line8.Color = red
                            line9.Color = red
                            line10.Color = red
                            line11.Color = red
                            line12.Color = red
                            Tracer.Color = red
                            Shifter.Color = red
                        end
                    end

                    --// Autothickness:
                    if Autothickness then
                        local distance = (player.Character.HumanoidRootPart.Position - newplr.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        line1.Thickness = value
                        line2.Thickness = value
                        line3.Thickness = value
                        line4.Thickness = value
                        line5.Thickness = value
                        line6.Thickness = value
                        line7.Thickness = value
                        line8.Thickness = value
                        line9.Thickness = value
                        line10.Thickness = value
                        line11.Thickness = value
                        line12.Thickness = value
                        Shifter.Thickness = value
                    else 
                        line1.Thickness = Box_Thickness
                        line2.Thickness = Box_Thickness
                        line3.Thickness = Box_Thickness
                        line4.Thickness = Box_Thickness
                        line5.Thickness = Box_Thickness
                        line6.Thickness = Box_Thickness
                        line7.Thickness = Box_Thickness
                        line8.Thickness = Box_Thickness
                        line9.Thickness = Box_Thickness
                        line10.Thickness = Box_Thickness
                        line11.Thickness = Box_Thickness
                        line12.Thickness = Box_Thickness
                        Shifter.Thickness = Box_Thickness
                    end

                    line1.Visible = true
                    line2.Visible = true
                    line3.Visible = true
                    line4.Visible = true
                    line5.Visible = true
                    line6.Visible = true
                    line7.Visible = true
                    line8.Visible = true
                    line9.Visible = true
                    line10.Visible = true
                    line11.Visible = true
                    line12.Visible = true
                    Shifter.Visible = true
                    if Tracers then
                        Tracer.Visible = true
                    end
                else 
                    line1.Visible = false
                    line2.Visible = false
                    line3.Visible = false
                    line4.Visible = false
                    line5.Visible = false
                    line6.Visible = false
                    line7.Visible = false
                    line8.Visible = false
                    line9.Visible = false
                    line10.Visible = false
                    line11.Visible = false
                    line12.Visible = false
                    Tracer.Visible = false
                    Shifter.Visible = false
                end
            else 
                line1.Visible = false
                line2.Visible = false
                line3.Visible = false
                line4.Visible = false
                line5.Visible = false
                line6.Visible = false
                line7.Visible = false
                line8.Visible = false
                line9.Visible = false
                line10.Visible = false
                line11.Visible = false
                line12.Visible = false
                Tracer.Visible = false
                Shifter.Visible = false
                if game.Players:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)
