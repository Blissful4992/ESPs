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
function Library:NewLine(info)
    local l = Drawing.new("Line")
    l.Visible = info.Visible or true;
    l.Color = info.Color or Color3.fromRGB(0,255,0);
    l.Transparency = info.Transparency or 1;
    l.Thickness = info.Thickness or 1;
    return l
end

function Library:Smoothen(v)
    return V2(ROUND(v.X), ROUND(v.Y))
end

-- Skeleton Object
local Skeleton = {
    Destroyed = false;
	Player = nil;
    Visible = false;
    Lines = {};
	Color = Color3.fromRGB(0,255,0);
	Alpha = 1;
	Thickness = 1;
}
Skeleton.__index = Skeleton;

function Skeleton:UpdateStructure()
    if not self.Player.Character then return end

    self:DestroyLines();

    local Body = self.Player.Character:GetChildren()
    for n = 1, #Body do
        local root = Body[n];
        if root:IsA("BasePart") then
            local next = root:FindFirstChildOfClass("Motor6D")
            if next then
                TBINSERT(self.Lines, {Library:NewLine({
					Visible = self.Visible;
					Color = self.Color;
					Transparency = self.Alpha;
					Thickness = self.Thickness;
				}), root.Name, next.Part0.Name});
            end
        end
    end
end

function Skeleton:SetVisible(State)
	self.Visible = State;
    for _,l in pairs(self.Lines) do
        l[1].Visible = State;
    end
end

function Skeleton:SetColor(Color)
	self.Color = Color;
    for _,l in pairs(self.Lines) do
        l[1].Color = Color;
    end
end

function Skeleton:SetAlpha(Alpha)
	self.Alpha = Alpha;
    for _,l in pairs(self.Lines) do
        l[1].Transparency = Alpha;
    end
end

function Skeleton:SetThickness(Thickness)
	self.Thickness = Thickness;
    for _,l in pairs(self.Lines) do
        l[1].Thickness = Thickness;
    end
end

-- Main Update Loop
function Skeleton:Update()
    if self.Destroyed then
		return;
    end

    local Character = self.Player.Character;
    local Humanoid = (Character and Character:FindFirstChildOfClass("Humanoid"));

    if not Character then
		if self.Player.Parent then
			self:SetVisible(false);
		else
            self:Destroy();
        end
		return;
    end
	
	if not Humanoid or Humanoid.Health == 0 then
		self:SetVisible(false);
		return;
	end
	
	self:SetColor(self.Color);
	self:SetAlpha(self.Alpha);
	self:SetThickness(self.Thickness);

	for _,l in pairs(self.Lines) do
		local root = Character:FindFirstChild(l[2]);
		if root then

			local next = Character:FindFirstChild(l[3])
			if next and next ~= Character.PrimaryPart then

				local rootp, rootv = To2D(Camera, root.Position);
				local nextp, nextv = To2D(Camera, next.Position);
			
				if rootv and nextv then
					l[1].From = V2(rootp.X, rootp.Y);
					l[1].To = V2(nextp.X, nextp.Y);

					l[1].Visible = true;
				else 
					l[1].Visible = false;
				end
			else 
				l[1].Visible = false;
			end
		else 
			l[1].Visible = false;
		end
	end
end

function Skeleton:Toggle()
    self.Visible = not self.Visible;

    if self.Visible then 
        self:DestroyLines();
        self:UpdateStructure();
        
        local c;c = RS.Heartbeat:Connect(function()
            if not self.Visible then
                self:SetVisible(false);
                c:Disconnect();
                return;
            end

            self:Update();
        end)
    end
end

function Skeleton:DestroyLines()
    for _,l in pairs(self.Lines) do
        l[1]:Remove();
    end
    self.Lines = {};
end

function Skeleton:Destroy()
    self.Destroyed = true;
    self:DestroyLines();
end

-- Create Skeleton Function
function Library:NewSkeleton(Player, Visible, Color, Alpha, Thickness)
    local s = setmetatable({}, Skeleton);

    s.Player = Player;
    s.Bind = Player.UserId;
	
	if Color then
		s:SetColor(Color)
	end
	
	if Alpha then
		s:SetAlpha(Alpha)
	end
	
	if Thickness then
		s:SetThickness(Thickness)
	end

    if Visible then
        s:Toggle();
    end

    return s;
end

-- LIBRARY FORMAT
if false then
    return Library;
end

-- TEST
if true then
    local Players = {}
    for _, Player in next, game.Players:GetChildren() do
        TBINSERT(Players, Library:NewSkeleton(Player, true));
    end
    
    while true do
        local i = math.random(#Players)
		
        print(Players[i].Player)
		
        Players[i]:Toggle()
		Players[i]:SetColor(Color3.fromRGB(math.random(255),math.random(255),math.random(255)))
		Players[i]:SetAlpha(math.random())
		Players[i]:SetThickness(math.random(10))
    
        task.wait()
    end
end
