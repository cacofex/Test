local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local janitor = require(ReplicatedStorage.Packages.janitor)

local Camera = {} :: {
    Player: Player,
    Target: Model,
    Janitor: janitor
}

Camera.__index = Camera

function Camera.new(player)
    local self = setmetatable(Camera, {})
    self.Player = player
    self.Target = nil
    self.Janitor = janitor.new()

    return self
end

function Camera:Change(mode: string, ...)
    local camera = workspace.CurrentCamera
    if mode == "Lock" then
        camera.CameraType = Enum.CameraType.Scriptable
        local target = select(1, ...)
        self:LockOn(target)
    elseif mode == "Free" then
        camera.CameraType = Enum.CameraType.Custom
        self.Janitor:Clean()
        self:Free()
    end
end

function Camera:LockOn(target)
    local camera = workspace.CurrentCamera
    local character = self.Player.Character
    local mouse = self.Player:GetMouse()
    self.Target = target
    
    self.Janitor:GiveChore(RunService.RenderStepped:Connect(function(dt)
        local humanoid = character:FindFirstChild("Humanoid")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local targetHrp = self.Target:FindFirstChild("HumanoidRootPart") :: BasePart

        if not hrp or not targetHrp then self:Change("Free") end

        local offset = CFrame.new(1.5, 1, 3)
        local pointOfView = hrp.CFrame * offset
        local lookAt = CFrame.lookAt(pointOfView.Position, targetHrp.CFrame.Position)
        local characterLookAt = CFrame.lookAt(hrp.CFrame.Position, Vector3.new(
            targetHrp.CFrame.Position.X,
            hrp.CFrame.Position.Y,
            targetHrp.CFrame.Position.Z
        ))
   
        hrp.CFrame = characterLookAt
        camera.CFrame = camera.CFrame:Lerp(lookAt, 0.2)
    end))
end

function Camera:Free()
    
end

return Camera