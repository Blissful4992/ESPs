local WAIT = task.wait
local TBINSERT = table.insert
local TBFIND = table.find
local TBREMOVE = table.remove
local V2 = Vector2.new
local ROUND = math.round

local RS = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local To2D = Camera.WorldToViewportPoint

-- Only thing for now is Skeleton
local Library = {};
Library.__index = Library;

-- Functions
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

-- Skeleton Object
local Skeleton = {
    Destroyed = false;
    Visible = false;
    Lines = {};
    Player = nil;
}
Skeleton.__index = Skeleton;

function Skeleton:UpdateStructure()
    if not self.Player.Character then return end

    self:DestroyLines()

    local Body = self.Player.Character:GetChildren()
    for n = 1, #Body do
        local root = Body[n]
        if root:IsA("BasePart") then
            local next = root:FindFirstChildOfClass("Motor6D")
            if next then
                TBINSERT(self.Lines, {Library:NewLine(), root.Name, next.Part0.Name})
            end
        end
    end
end

function Skeleton:SetVisible(state)
    for _,l in pairs(self.Lines) do
        l[1].Visible = state
    end
end

-- Main Update Loop
function Skeleton:Update()
    if self.Destroyed then
        RS:UnbindFromRenderStep(self.Bind)
    end

    local Character = self.Player.Character
    local Humanoid = (Character and Character:FindFirstChildOfClass("Humanoid"))

    if (Character) then
        if not Humanoid or Humanoid.Health == 0 then self:SetVisible(false) end

        for _,l in pairs(self.Lines) do
            local root = Character:FindFirstChild(l[2])
            if root then

                local next = Character:FindFirstChild(l[3])
                if next and next ~= Character.PrimaryPart then

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
        if not self.Player.Parent then
            self:Destroy()
            RS:UnbindFromRenderStep(self.Bind)
        end
        self:SetVisible(false)
    end
end

function Skeleton:Toggle()
    self.Visible = not self.Visible

    if self.Visible then 
        self:DestroyLines()
        self:UpdateStructure()
        
        local c;c = RS.Heartbeat:Connect(function()
            if not self.Visible then
                self:SetVisible(false)
                c:Disconnect()
                return;
            end

            self:Update()
        end)
    end
end

function Skeleton:DestroyLines()
    for _,l in pairs(self.Lines) do
        l[1]:Remove()
    end
    self.Lines = {}
end

function Skeleton:Destroy()
    self.Destroyed = true
    self:DestroyLines()
end

-- Create Skeleton Function
function Library:NewSkeleton(Player, Visible)
    local s = setmetatable({}, Skeleton);

    s.Player = Player;
    s.Bind = Player.UserId;

    if Visible then
        s:Toggle();
    end

    return s;
end

-- LIBRARY FORMAT
if true then
    return Library;
end

-- TEST
if false then
    local Players = {}
    for _, Player in next, game.Players:GetChildren() do
        TBINSERT(Players, Library:NewSkeleton(Player, true))
    end
    
    while true do
        local i = math.random(#Players)
        print(Players[i].Player)
        Players[i]:Toggle()
    
        task.wait(1)
    end
end
