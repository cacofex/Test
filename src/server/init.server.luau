local ReplicatedStorage = game:GetService("ReplicatedStorage")
local signal = require(ReplicatedStorage.Packages.signal)

local remote = ReplicatedStorage.RemoteEvent :: RemoteEvent

local hitbox = require(ReplicatedStorage.Shared.Hitbox)

remote.OnServerEvent:Connect(function(player)
    hitbox:Fire(player.Character)
end)