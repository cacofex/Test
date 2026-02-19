local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EzHitbox = require(ReplicatedStorage.Packages.hitbox)
local maid = require(ReplicatedStorage.Packages.maid)
local janitor = require(ReplicatedStorage.Packages.janitor)
local zonePlus = require(ReplicatedStorage.Packages.zoneplus)
local signal = require(ReplicatedStorage.Packages.signal)

local Hitbox = {}

function Hitbox:Fire(character)
    local hitboxObjeect = EzHitbox.new({
        SizeOrPart = Vector3.new(5, 5, 5),
        InitialCFrame = character.HumanoidRootPart.CFrame * CFrame.new(0,0,-4),
        Debug = true
    })

    

    hitboxObjeect:Start()
end

return Hitbox