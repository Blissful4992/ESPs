-- Preview: https://cdn.discordapp.com/attachments/807887111667056680/817712853519695892/Screenshot_1.png
-- Made by Blissful#4992
--// Settings:
local Box_Color = Color3.fromRGB(255, 0, 0)
local Tracer_Color = Color3.fromRGB(255, 0, 0)
local HealthBar_Color = Color3.fromRGB(0, 255, 0)

local Tracer_Thickness = 1
local Box_Thickness = 2

local teamcheck = {
    teamcheck = true,
    green = Color3.fromRGB(161, 242, 19),
    red = Color3.fromRGB(245, 69, 5)
}

--//Locals
local plr = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local function NewQuad(thickness, color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = false
    quad.Thickness = thickness
    quad.Transparency = 1
    return quad
end

local function NewLine(thickness, color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color
    line.Thickness = thickness
    line.Transparency = 1
    return line
end

local black = Color3.fromRGB(0, 0, 0)

for i, v in pairs(game.Players:GetChildren()) do
    local library = {
        --//Tracer and Black Tracer(black border)
        blacktracer = NewLine(Tracer_Thickness*2, black),
        tracer = NewLine(Tracer_Thickness, Tracer_Color),
        --//Box and Black Box(black border)
        black = NewQuad(Box_Thickness*2, black),
        box = NewQuad(Box_Thickness, Box_Color),
        --//Bar and Green Health Bar (part that moves up/down)
        healthbar = NewLine(8, black),
        greenhealth = NewLine(4, HealthBar_Color)
    }

    local function Visibility(state)
        for u, x in pairs(library) do
            x.Visible = state
        end
    end

    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= plr.Name and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") ~= nil then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(v.Character.Head.Position)
                    local rootpos = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

                    local ratio = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude, 2, math.huge)

                    local head2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.Head.Position.Y + 2, v.Character.Head.Position.Z))

                    local root2 = camera:WorldToViewportPoint(Vector3.new(v.Character.Head.Position.X, v.Character.HumanoidRootPart.Position.Y - 3, v.Character.Head.Position.Z))

                    library.black.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                    library.black.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                    library.black.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                    library.black.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)

                    library.box.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                    library.box.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                    library.box.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                    library.box.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)

                    library.tracer.To = Vector2.new(root2.X, root2.Y + ratio*0.5)
                    library.tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    library.blacktracer.To = Vector2.new(root2.X, root2.Y + ratio*0.5)
                    library.blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    local d = (Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05) - Vector2.new(root2.X - ratio*1.8, root2.Y + ratio*0.5)).magnitude
                    local green = (100-v.Character.Humanoid.Health) *d /100

                    library.greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                    library.healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)

                    library.healthbar.To = Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05)
                    library.healthbar.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)

                    library.greenhealth.To = Vector2.new(head2.X - ratio*1.8, head2.Y + green - ratio*0.05)
                    library.greenhealth.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)

                    if teamcheck.teamcheck == true then
                        if v.TeamColor == plr.TeamColor then
                            library.box.Color = teamcheck.green
                            library.tracer.Color = teamcheck.green
                        else 
                            library.box.Color = teamcheck.red
                            library.tracer.Color = teamcheck.red
                        end
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

game.Players.PlayerAdded:Connect(function(newplr) --Parameter gets the new player that has been added
    local library = {
        --//Tracer and Black Tracer(black border)
        blacktracer = NewLine(Tracer_Thickness*2, black),
        tracer = NewLine(Tracer_Thickness, Tracer_Color),
        --//Box and Black Box(black border)
        black = NewQuad(Box_Thickness*2, black),
        box = NewQuad(Box_Thickness, Box_Color),
        --//Bar and Green Health Bar (part that moves up/down)
        healthbar = NewLine(8, black),
        greenhealth = NewLine(4, HealthBar_Color)
    }

    local function Visibility(state)
        for u, x in pairs(library) do
            x.Visible = state
        end
    end

    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= plr.Name and newplr.Character.Humanoid.Health > 0 and newplr.Character:FindFirstChild("Head") ~= nil then
                local ScreenPos, OnScreen = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(newplr.Character.Head.Position)
                    local rootpos = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)

                    local ratio = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(rootpos.X, rootpos.Y)).magnitude, 2, math.huge)

                    local head2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.Head.Position.Y + 2, newplr.Character.Head.Position.Z))

                    local root2 = camera:WorldToViewportPoint(Vector3.new(newplr.Character.Head.Position.X, newplr.Character.HumanoidRootPart.Position.Y - 3, newplr.Character.Head.Position.Z))

                    library.black.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                    library.black.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                    library.black.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                    library.black.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)

                    library.box.PointA = Vector2.new(head2.X + ratio*1.6, head2.Y - ratio*0.05)
                    library.box.PointB = Vector2.new(head2.X - ratio*1.6, head2.Y - ratio*0.05)
                    library.box.PointC = Vector2.new(head2.X - ratio*1.6, root2.Y + ratio*0.5)
                    library.box.PointD = Vector2.new(head2.X + ratio*1.6, root2.Y + ratio*0.5)

                    library.tracer.To = Vector2.new(root2.X, root2.Y + ratio*0.5)
                    library.tracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    library.blacktracer.To = Vector2.new(root2.X, root2.Y + ratio*0.5)
                    library.blacktracer.From = Vector2.new(camera.ViewportSize.X*0.5, camera.ViewportSize.Y)

                    local d = (Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05) - Vector2.new(root2.X - ratio*1.8, root2.Y + ratio*0.5)).magnitude
                    local green = (100-newplr.Character.Humanoid.Health) *d /100

                    library.greenhealth.Thickness = math.clamp(ratio/4, 1, 4)
                    library.healthbar.Thickness = math.clamp(ratio * 1.2 / 4, 1.5, 6)

                    library.healthbar.To = Vector2.new(head2.X - ratio*1.8, head2.Y - ratio*0.05)
                    library.healthbar.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)

                    library.greenhealth.To = Vector2.new(head2.X - ratio*1.8, head2.Y + green - ratio*0.05)
                    library.greenhealth.From = Vector2.new(head2.X - ratio*1.8, root2.Y + ratio*0.5)

                    if teamcheck.teamcheck == true then
                        if newplr.TeamColor == plr.TeamColor then
                            library.box.Color = teamcheck.green
                            library.tracer.Color = teamcheck.green
                        else 
                            library.box.Color = teamcheck.red
                            library.tracer.Color = teamcheck.red
                        end
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
