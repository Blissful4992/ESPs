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
	DoSubsteps = true;
}
Skeleton.__index = Skeleton;

function Skeleton:UpdateStructure()
    if not self.Player.Character then return end

    self:DestroyLines();

    for _, part in next, self.Player.Character:GetChildren() do		
        if not part:IsA("BasePart") then
			continue;
        end

		for _, link in next, part:GetChildren() do			
			if not link:IsA("Motor6D") then
				continue;
			end
			
			TBINSERT(
				self.Lines,
				{
					Library:NewLine({
						Visible = self.Visible;
						Color = self.Color;
						Transparency = self.Alpha;
						Thickness = self.Thickness;
					}),
					Library:NewLine({
						Visible = self.Visible;
						Color = self.Color;
						Transparency = self.Alpha;
						Thickness = self.Thickness;
					}),
					link
				}
			);
		end
    end
end

function Skeleton:SetVisible(State)
    for _,l in pairs(self.Lines) do
        l[1].Visible = State;
		l[2].Visible = State;
    end
end

function Skeleton:SetColor(Color)
	self.Color = Color;
    for _,l in pairs(self.Lines) do
        l[1].Color = Color;
		l[2].Color = Color;
    end
end

function Skeleton:SetAlpha(Alpha)
	self.Alpha = Alpha;
    for _,l in pairs(self.Lines) do
        l[1].Transparency = Alpha;
		l[2].Transparency = Alpha;
    end
end

function Skeleton:SetThickness(Thickness)
	self.Thickness = Thickness;
    for _,l in pairs(self.Lines) do
        l[1].Thickness = Thickness;
		l[2].Thickness = Thickness;
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

	for _, l in pairs(self.Lines) do
		local link = l[3]
		if not link then
			continue;
		end
		
		local part0 = link.Part0;
		local c0 = link.C0;
		
		if part0 and c0 then
		
			local part1 = link.Part1;
			local c1 = link.C1;
			
			if part1 and c1 then
				
				if self.DoSubsteps then
					-- Center of part0 to c0
					local part0p, v1 = To2D(Camera, part0.CFrame.p);
					local part0cp, v2 = To2D(Camera, (part0.CFrame * c0).p);
					
					if v1 and v2 then
						l[1].From = V2(part0p.x, part0p.y);
						l[1].To = V2(part0cp.x, part0cp.y);

						l[1].Visible = true;
					else 
						l[1].Visible = false;
					end
					
					-- Center of part1 to c1
					local part1p, v3 = To2D(Camera, part1.CFrame.p);
					local part1cp, v4 = To2D(Camera, (part1.CFrame * c1).p);
				
					if v3 and v4 then
						l[2].From = V2(part1p.x, part1p.y);
						l[2].To = V2(part1cp.x, part1cp.y);

						l[2].Visible = true;
					else 
						l[2].Visible = false;
					end
				else					
					local part0p, v1 = To2D(Camera, part0.CFrame.p);
					local part1p, v2 = To2D(Camera, part1.CFrame.p);
					
					if v1 and v2 then
						l[1].From = V2(part0p.x, part0p.y);
						l[1].To = V2(part1p.x, part1p.y);

						l[1].Visible = true;
					else 
						l[1].Visible = false;
					end
					
					l[2].Visible = false;
				end
			else 
				l[1].Visible = false;
				l[2].Visible = false;
			end
		else 
			l[1].Visible = false;
			l[2].Visible = false;
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
		l[2]:Remove();
    end
    self.Lines = {};
end

function Skeleton:Destroy()
    self.Destroyed = true;
    self:DestroyLines();
end

-- Create Skeleton Function
function Library:NewSkeleton(Player, Visible, Color, Alpha, Thickness, DoSubsteps)
	if not Player then
		error("Missing Player argument (#1)")
	end
	
    local s = setmetatable({}, Skeleton);

    s.Player = Player;
    s.Bind = Player.UserId;
	
	if DoSubsteps ~= nil then
		s.DoSubsteps = DoSubsteps;
	end
	
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
if true then
    return Library;
end

-- TEST
if false then
	-- local Library = loadstring(game:HttpGet("https://github.com/Blissful4992/ESPs/blob/main/UniversalSkeleton.lua"))()

	local Skeletons = {}
	for _, Player in next, game.Players:GetChildren() do
		table.insert(Skeletons, Library:NewSkeleton(Player, true));
	end
	game.Players.PlayerAdded:Connect(function(Player)
		table.insert(Skeletons, Library:NewSkeleton(Player, true));
	end)

	while true do
		for _, s in next, Skeletons do
			s:SetColor(Color3.fromRGB(math.random(255),math.random(255),math.random(255)))
			s:SetAlpha(math.random())
			s:SetThickness(math.random(10))
		end

		task.wait(1)
	end
end
