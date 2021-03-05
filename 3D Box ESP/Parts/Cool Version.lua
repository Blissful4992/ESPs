-- Preview: https://gyazo.com/ab2250ff7206f3b86bc4f479d79f0644
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

local Shifter_Color = Color3.fromRGB(0, 255, 0)

local Autothickness = true -- Makes screen less encumbered

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function NewLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(1, 1)
    line.Color = Box_Color
    line.Thickness = Box_Thickness
    line.Transparency = Box_Transparency
    return line
end

--// Main Function:
--[[
    Example: 
    local Part = workspace.Part      
    ESP(Part)
]]
local function ESP(object)
    local part = object

    --// Lines for 3D box (12)

    local lines = {
        line1 = NewLine(),
        line2 = NewLine(),
        line3 = NewLine(),
        line4 = NewLine(),
        line5 = NewLine(),
        line6 = NewLine(),
        line7 = NewLine(),
        line8 = NewLine(),
        line9 = NewLine(),
        line10 = NewLine(),
        line11 = NewLine(),
        line12 = NewLine()
    }

    local Shifter = Drawing.new("Quad")
    Shifter.Visible = false
    Shifter.Color = Shifter_Color
    Shifter.Thickness = Box_Thickness
    Shifter.Filled = false
    Shifter.Transparency = Box_Transparency

    local debounce = 0
    local shifteroffset = 0

    --// Updates ESP (lines) in render loop
    local function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            local partpos, onscreen = camera:WorldToViewportPoint(part.Position)
            if on and onscreen then
                local size_X = part.Size.X/2
                local size_Y = part.Size.Y/2
                local size_Z = part.Size.Z/2
                
                local Top1 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, size_Y, -size_Z)).p)
                local Top2 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, size_Y, size_Z)).p)
                local Top3 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, size_Y, size_Z)).p)
                local Top4 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, size_Y, -size_Z)).p)

                local Bottom1 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, -size_Y, -size_Z)).p)
                local Bottom2 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, -size_Y, size_Z)).p)
                local Bottom3 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, -size_Y, size_Z)).p)
                local Bottom4 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, -size_Y, -size_Z)).p)

                --// Top:
                lines.line1.From = Vector2.new(Top1.X, Top1.Y)
                lines.line1.To = Vector2.new(Top2.X, Top2.Y)

                lines.line2.From = Vector2.new(Top2.X, Top2.Y)
                lines.line2.To = Vector2.new(Top3.X, Top3.Y)

                lines.line3.From = Vector2.new(Top3.X, Top3.Y)
                lines.line3.To = Vector2.new(Top4.X, Top4.Y)

                lines.line4.From = Vector2.new(Top4.X, Top4.Y)
                lines.line4.To = Vector2.new(Top1.X, Top1.Y)

                --//Bottom:
                lines.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                lines.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                lines.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                lines.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                lines.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                lines.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                lines.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                lines.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                --//Sides:
                lines.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                lines.line9.To = Vector2.new(Top1.X, Top1.Y)

                lines.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                lines.line10.To = Vector2.new(Top2.X, Top2.Y)

                lines.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                lines.line11.To = Vector2.new(Top3.X, Top3.Y)

                lines.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                lines.line12.To = Vector2.new(Top4.X, Top4.Y)

                --// Shifter:
                if debounce == 0 then
                    debounce = debounce + 1
                    spawn(function()
                        for i = 0, size_Y, 0.1 do
                            shifteroffset = Lerp(shifteroffset, i, 0.5)
                            wait()
                        end
                        
                        for i = shifteroffset, 0, -0.1 do
                            shifteroffset = Lerp(shifteroffset, i, 0.5)
                            wait()
                        end

                        for i = 0, -size_Y, -0.1 do
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

                local shifter1 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, shifteroffset, -size_Z)).p)
                local shifter2 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, shifteroffset, size_Z)).p)
                local shifter3 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, shifteroffset, size_Z)).p)
                local shifter4 = camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, shifteroffset, -size_Z)).p)

                Shifter.PointA = Vector2.new(shifter1.X, shifter1.Y)
                Shifter.PointB = Vector2.new(shifter2.X, shifter2.Y)
                Shifter.PointC = Vector2.new(shifter3.X, shifter3.Y)
                Shifter.PointD = Vector2.new(shifter4.X, shifter4.Y)

                if Autothickness then
                    local distance = (player.Character.HumanoidRootPart.Position - part.Position).magnitude
                    local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                    for u, x in pairs(lines) do
                        x.Thickness = value
                    end
                    Shifter.Thickness = value
                else 
                    for u, x in pairs(lines) do
                        x.Thickness = Box_Thickness
                    end
                    Shifter.Thickness = Box_Thickness
                end

                for u, x in pairs(lines) do
                    x.Visible = true
                end
                Shifter.Visible = true
            else 
                for u, x in pairs(lines) do
                    x.Visible = false
                    Shifter.Visible = false
                end
                if part == nil or not part then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

local test = workspace.Objects.Rectangle
ESP(test)
