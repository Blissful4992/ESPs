-- // Made by Blissful#4992 // --

local Library = {};

local Camera = workspace.CurrentCamera;
local ToScreen = Camera.WorldToViewportPoint;

local RS = game:GetService("RunService");

local nVector3 = Vector3.new;
local nVector2 = Vector2.new;
local nDrawing = Drawing.new;
local nColor   = Color3.fromRGB;
local nCFrame = CFrame.new;
local nCFAngles = CFrame.Angles;

local rad = math.rad;
local pi = math.pi;
local round = math.round;

local Insert = table.insert;
local Char = string.char;
local Random = math.random;
local Seed = math.randomseed;
local Time = os.time;

local charset = {};

for i = 48,  57 do Insert(charset, Char(i)) end;
for i = 65,  90 do Insert(charset, Char(i)) end;
for i = 97, 122 do Insert(charset, Char(i)) end;

local function random_string(length)
    Seed(Time());

    if length > 0 then
        return random_string(length - 1) .. charset[Random(1, #charset)];
    else
        return "";
    end;
end;

local function checkCamView(pos)
    return ((pos - Camera.CFrame.Position).Unit):Dot(Camera.CFrame.LookVector) > 0;
end

function Library:New3DLine()
    local _line = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        From         = nVector3(0,0,0);
        To           = nVector3(0,0,0);
    };
    local _defaults = _line;
    _line.line = nDrawing("Line");

    -- Update Step Function --
    function _line:Update()
        if not _line.Visible then
            _line.line.Visible = false;
        else
            _line.line.Visible      = _line.Visible      or _defaults.Visible;
            _line.line.ZIndex       = _line.ZIndex       or _defaults.ZIndex;
            _line.line.Transparency = _line.Transparency or _defaults.Transparency;
            _line.line.Color        = _line.Color        or _defaults.Color;
            _line.line.Thickness    = _line.Thickness    or _defaults.Thickness;

            local _from, v1 = ToScreen(Camera, _line.From);
            local _to,   v2 = ToScreen(Camera, _line.To);

            if (v1 and v2) or (checkCamView(_line.From) and checkCamView(_line.To)) then
                _line.line.From = nVector2(_from.x, _from.y);
                _line.line.To   = nVector2(_to.x, _to.y);
            else
                _line.line.Visible = false;
            end;
        end
    end;
    --------------------------

    local step_Id = "3D_Line"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _line.Update);

    -- Remove Line --
    function _line:Remove()
        RS:UnbindFromRenderStep(step_Id);

        self.line:Remove();
    end;
    -----------------

    return _line;
end;

function Library:New3DCube()
    local _cube = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        Filled       = true;
        
        Position     = nVector3(0,0,0);
        Size         = nVector3(0,0,0);
        Rotation     = nVector3(0,0,0);
    };
    local _defaults  = _cube;
    for f = 1, 6 do
        _cube["face"..tostring(f)] = nDrawing("Quad");
    end;

    -- Update Step Function --
    function _cube:Update()
        if not _cube.Visible then
            for f = 1, 6 do
                _cube["face"..tostring(f)].Visible = false;
            end;
        else
            for f = 1, 6 do
                f = "face"..tostring(f)
                _cube[f].Visible      = _cube.Visible      or _defaults.Visible;
                _cube[f].ZIndex       = _cube.ZIndex       or _defaults.ZIndex;
                _cube[f].Transparency = _cube.Transparency or _defaults.Transparency;
                _cube[f].Color        = _cube.Color        or _defaults.Color;
                _cube[f].Thickness    = _cube.Thickness    or _defaults.Thickness;
                _cube[f].Filled       = _cube.Filled       or _defaults.Filled;
            end;

            local rot = _cube.Rotation or _defaults.Rotation;
            local pos = _cube.Position or _defaults.Position;
            local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), rad(rot.Y), rad(rot.Z));

            local _size = _cube.Size or _defaults.Size;
            local _points = {
                [1] = (_rotCFrame * nCFrame(_size.X, _size.Y, _size.Z)).p;
                [2] = (_rotCFrame * nCFrame(_size.X, _size.Y, -_size.Z)).p;
                [3] = (_rotCFrame * nCFrame(_size.X, -_size.Y, _size.Z)).p;
                [4] = (_rotCFrame * nCFrame(_size.X, -_size.Y, -_size.Z)).p;
                [5] = (_rotCFrame * nCFrame(-_size.X, _size.Y, _size.Z)).p;
                [6] = (_rotCFrame * nCFrame(-_size.X, _size.Y, -_size.Z)).p;
                [7] = (_rotCFrame * nCFrame(-_size.X, -_size.Y, _size.Z)).p;
                [8] = (_rotCFrame * nCFrame(-_size.X, -_size.Y, -_size.Z)).p;
            };

            local _vis = true;

            for p = 1, #_points do
                local _p, v = ToScreen(Camera, _points[p]);
                local _stored = _points[p];
                _points[p] = nVector2(_p.x, _p.y);

                if not v and not checkCamView(_stored) then 
                    _vis = false;
                    break;
                end;
            end;

            if _vis then
                _cube.face1.PointA = _points[1]; -- Side
                _cube.face1.PointB = _points[2];
                _cube.face1.PointC = _points[4];
                _cube.face1.PointD = _points[3];

                _cube.face2.PointA = _points[5]; -- Side
                _cube.face2.PointB = _points[6];
                _cube.face2.PointC = _points[8];
                _cube.face2.PointD = _points[7];

                _cube.face3.PointA = _points[1]; -- Side
                _cube.face3.PointB = _points[5];
                _cube.face3.PointC = _points[7];
                _cube.face3.PointD = _points[3];

                _cube.face4.PointA = _points[2]; -- Side
                _cube.face4.PointB = _points[4];
                _cube.face4.PointC = _points[8];
                _cube.face4.PointD = _points[6];

                _cube.face5.PointA = _points[1]; -- Top
                _cube.face5.PointB = _points[2];
                _cube.face5.PointC = _points[6];
                _cube.face5.PointD = _points[5];

                _cube.face6.PointA = _points[3]; -- Bottom
                _cube.face6.PointB = _points[4];
                _cube.face6.PointC = _points[8];
                _cube.face6.PointD = _points[7];
            else
                for f = 1, 6 do
                    _cube["face"..tostring(f)].Visible = false;
                end;
            end;
        end;
    end;
    --------------------------

    local step_Id = "3D_Cube"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _cube.Update);

    -- Remove Cube --
    function _cube:Remove()
        RS:UnbindFromRenderStep(step_Id);

        for f = 1, 6 do
            self["face"..tostring(f)]:Remove();
        end;
    end;
    -----------------

    return _cube;
end;

function Library:New3DSquare()
    local _square = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        Filled       = true;
        
        Position     = nVector3(0,0,0);
        Size         = nVector2(0,0);
        Rotation     = nVector3(0,0,0);
    }
    local _defaults = _square;
    _square.square = nDrawing("Quad");

    -- Update Step Function --
    function _square:Update()
        if not _square.Visible then 
            _square.square.Visible = false;
        else
            _square.square.Visible      = _square.Visible      or _defaults.Visible;
            _square.square.ZIndex       = _square.ZIndex       or _defaults.ZIndex;
            _square.square.Transparency = _square.Transparency or _defaults.Transparency;
            _square.square.Color        = _square.Color        or _defaults.Color;
            _square.square.Thickness    = _square.Thickness    or _defaults.Thickness;
            _square.square.Filled       = _square.Filled       or _defaults.Filled;

            local rot = _square.Rotation or _defaults.Rotation;
            local pos = _square.Position or _defaults.Position;
            local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), rad(rot.Y), rad(rot.Z));

            local _size = _square.Size or _defaults.Size;
            local _points = {
                [1] = (_rotCFrame * nCFrame(_size.X, 0, _size.Y)).p;
                [2] = (_rotCFrame * nCFrame(_size.X, 0, -_size.Y)).p;
                [3] = (_rotCFrame * nCFrame(-_size.X, 0, _size.Y)).p;
                [4] = (_rotCFrame * nCFrame(-_size.X, 0, -_size.Y)).p;
            };

            local _vis = true;

            for p = 1, #_points do
                local _p, v = ToScreen(Camera, _points[p]);
                local _stored = _points[p];
                _points[p] = nVector2(_p.x, _p.y);

                if not v and not checkCamView(_stored) then 
                    _vis = false;
                    break;
                end;
            end;

            if _vis then
                _square.square.PointA = _points[1];
                _square.square.PointB = _points[2];
                _square.square.PointC = _points[4];
                _square.square.PointD = _points[3];
            else
                _square.square.Visible = false;
            end;
        end;
    end;
    --------------------------

    local step_Id = "3D_Square"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _square.Update);

    -- Remove Square --
    function _square:Remove()
        RS:UnbindFromRenderStep(step_Id);

        _square.square:Remove();
    end;
    -----------------

    return _square;
end;

function Library:New3DCircle()
    local _circle = {
        Visible      = false;
        ZIndex       = 1;
        Transparency = 1;
        Color        = nColor(255, 255, 255);
        Thickness    = 1;
        
        Position     = nVector3(0,0,0);
        Radius       = 10;
        Rotation     = nVector2(0,0);
    };
    local _defaults = _circle;
    local _lines = {};

    local function makeNewLines(r)
        for l = 1, #_lines do
            _lines[l]:Remove();
        end;

        _lines = {};
        
        for l = 1, 1.5*r*pi do
            _lines[l] = nDrawing("Line");
        end;
    end;

    -- Update Step Function --
    local previousR = _circle.Radius or _defaults.Radius;
    makeNewLines(previousR);

    function _circle:Update()
        local rot = _circle.Rotation or _defaults.Rotation;
        local pos = _circle.Position or _defaults.Position;
        local _rotCFrame = nCFrame(pos) * nCFAngles(rad(rot.X), 0, rad(rot.Y));

        local _radius = _circle.Radius or _defaults.Radius;
        if previousR ~= _radius then makeNewLines(_radius) end;

        local _increm = 360/#_lines;

        if not _circle.Visible then 
            for ln = 1, #_lines do
                _lines[ln].Visible = false;
            end;
        else
            for l = 1, #_lines do
                if _lines[l] then
                    _lines[l].Visible      = _circle.Visible      or _defaults.Visible;
                    _lines[l].ZIndex       = _circle.ZIndex       or _defaults.ZIndex;
                    _lines[l].Transparency = _circle.Transparency or _defaults.Transparency;
                    _lines[l].Color        = _circle.Color        or _defaults.Color;
                    _lines[l].Thickness    = _circle.Thickness    or _defaults.Thickness;

                    local p1 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _previousPosition, v1 = ToScreen(Camera, p1);

                    _rotCFrame = _rotCFrame * nCFAngles(0, rad(_increm), 0);

                    local p2 = (_rotCFrame * nCFrame(0, 0, -_radius)).p;
                    local _nextPosition, v2 = ToScreen(Camera, p2);

                    if (v1 and v2) or (checkCamView(p1) and checkCamView(p2)) then
                        _lines[l].From = nVector2(_previousPosition.x, _previousPosition.y);
                        _lines[l].To = nVector2(_nextPosition.x, _nextPosition.y);
                    else
                        _lines[l].Visible = false;
                    end;
                end;
            end;
        end;

        previousR = _circle.Radius or _defaults.Radius;
    end;
    --------------------------

    local step_Id = "3D_Circle"..random_string(10);
    RS:BindToRenderStep(step_Id, 1, _circle.Update);

    -- Remove Circle --
    function _circle:Remove()
        RS:UnbindFromRenderStep(step_Id)

        for ln = 1, #_lines do
            _lines[ln]:Remove();
        end;
    end;
    -----------------

    return _circle;
end;

return Library;
