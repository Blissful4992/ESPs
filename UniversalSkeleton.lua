local WAIT = task.wait
local TBINSERT = table.insert
local TBFIND = table.find
local TBREMOVE = table.remove
local V2 = Vector2.new
local ROUND = math.round

local RS = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local To2D = Camera.WorldToViewportPoint

local Library = { Players = {} }

function Library:NewLine()
    local l = Drawing.new("Line")
    l.Visible = false
    l.Color = Color3.fromRGB(0,255,0)
    l.Transparency = 1
    l.Thickness = 1
    return l
end

function Library:Smoothen(v)
    return V2(ROUND(v.X), ROUND(v.Y))
end

function Library:NewSkeleton(Player)
    local Player_Name = Player.Name
    local Skeleton = { Destroyed = false; Visible = false; Lines = {}; Bind = Player_Name }

    TBINSERT(self.Players, Player_Name)

    function Skeleton.UpdateStructure()
        if not Player.Character then return end

        Skeleton.DestroyLines()

        local Body = Player.Character:GetChildren()
        for n = 1, #Body do
            local root = Body[n]
            if root:IsA("BasePart") then
                local next = root:FindFirstChildOfClass("Motor6D")
                if next then
                    TBINSERT(Skeleton.Lines, {self:NewLine(), root.Name, next.Part0.Name})
                end
            end
        end
    end

    function Skeleton.LineVis(state)
        for _,l in pairs(Skeleton.Lines) do
            l[1].Visible = state
        end
    end

    function Skeleton.Update()
        if (Skeleton.Destroyed) then
            RS:UnbindFromRenderStep(Skeleton.Bind)
        end

        local Character = Player.Character
        local Humanoid = (Character and Character:FindFirstChildOfClass("Humanoid"))

        if (Character) then
            if not Humanoid or Humanoid.Health == 0 then Skeleton.LineVis(false) end

            for _,l in pairs(Skeleton.Lines) do
                local root = Character:FindFirstChild(l[2])
                if root then

                    local next = Character:FindFirstChild(l[3])
                    if next  and next ~= Character.PrimaryPart then

                        local rootp, rootv = To2D(Camera, root.Position)
                        local nextp, nextv = To2D(Camera, next.Position)
                    
                        if rootv and nextv then
                            l[1].From = V2(rootp.X, rootp.Y)
                            l[1].To = V2(nextp.X, nextp.Y)

                            l[1].Visible = true
                        else 
                            l[1].Visible = false
                        end
                    else 
                        l[1].Visible = false
                    end
                else 
                    l[1].Visible = false
                end
            end

        else
            if not Player.Parent then
                Skeleton.Destroy()
                RS:UnbindFromRenderStep(Skeleton.Bind)
            end
            Skeleton.LineVis(false)
        end
    end
    
    function Skeleton.Toggle()
        Skeleton.Visible = not Skeleton.Visible

        if Skeleton.Visible then 
            Skeleton.DestroyLines()
            Skeleton.UpdateStructure()
            RS:BindToRenderStep(Skeleton.Bind, 1, Skeleton.Update)
        else
            RS:UnbindFromRenderStep(Skeleton.Bind)
            Skeleton.LineVis(false)
        end
    end

    function Skeleton.DestroyLines()
        for _,l in pairs(Skeleton.Lines) do
            l[1]:Remove()
        end
        Skeleton.Lines = {}
    end

    function Skeleton.Destroy()
        Skeleton.Destroyed = true
        Skeleton.DestroyLines()
        Skeleton = {}
        TBREMOVE(self.Players, TBFIND(self.Players, Player_Name))
    end

    --
    Skeleton.Toggle()
    --

    return Skeleton
end

-- _G.LocalSkel = Library:NewSkeleton(game.Players.LocalPlayer)

return Library;
