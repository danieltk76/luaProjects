local arenaEvent = game.Workspace.Events:WaitForChild("Arena")
local joinArena = game.Workspace.Events:WaitForChild("JoinArena")
local joinedPlayers = {}
local countdownFinished = game.Workspace.Events:WaitForChild("CountdownFinished")
local startMsg = game.Workspace.Events:WaitForChild("StartArenaMsg")
local gameStatus = game.ReplicatedStorage:WaitForChild("GameStatus")
local roundLength = 120
local downTime = 60
local promptTime = 15
local collectionService = game:GetService("CollectionService")

joinArena.OnServerEvent:Connect(function(player)
	table.insert(joinedPlayers, player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local index = table.find(joinedPlayers, player)
	if index then
		table.remove(joinedPlayers, index)
	end
end)

while wait() do
	wait(downTime)
	arenaEvent:FireAllClients()
	for i = promptTime, 0, -1 do
		game.ReplicatedStorage:WaitForChild("GameStatus").Value = "Battle starting in "..i
		wait(1)
	end

	countdownFinished:FireAllClients()
	gameStatus.Value = "Teleporting Players..."
	local gameSpawn = workspace.Map.Arena.ArenaSpawn

	for i, player in pairs(joinedPlayers) do
		startMsg:FireClient(player)
		wait(.1) -- This wait can stay, but consider dynamic waits based on character load state if needed.
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
			-- Ensure the character is fully loaded
			repeat wait() until player.Character and player.Character.Humanoid.Health > 0
			-- Adjust the teleportation position to ensure it's above the ground. Add a safety Y-axis offset.
			local yOffset = 5 -- Adjust based on your arena's floor height to ensure players don't spawn below it.
			local teleportCFrame = gameSpawn.CFrame * CFrame.new(0, yOffset + player.Character.HumanoidRootPart.Size.Y/2, 0)
			player.Character.HumanoidRootPart.CFrame = teleportCFrame
		end
	end

	wait(6)
	gameStatus.Value = "Giving Tools..."
	wait(3)
	for i, player in pairs(joinedPlayers) do
		local punch = game.ReplicatedStorage:WaitForChild("Punch"):Clone()
		punch.Parent = player.Backpack
		if player.Character then
			player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChildOfClass("Tool"))
		end
	end

	for i, player in pairs(joinedPlayers) do
		player.Character.Humanoid.Died:Connect(function()
			local index = table.find(joinedPlayers, player)
			if index then
				table.remove(joinedPlayers, index)
			end
		end)
	end

	for i = roundLength, 0, -1 do
		gameStatus.Value = "Time Left: "..i
		if #joinedPlayers == 1 then
			break
		end
		if #joinedPlayers == 0 then
			break
		end
		wait(1)
	end

	local winners = "Winner(s): "
	if #joinedPlayers >= 1 then
		local spawns = workspace.Spawns:GetChildren()
		for i, player in pairs(joinedPlayers) do
			local mapSpawn = spawns[math.random(#spawns)]
			player.Character.HumanoidRootPart.CFrame = mapSpawn.CFrame * CFrame.new(0, player.Character.Humanoid:WaitForChild("BodyHeightScale"), 0)
			player.Character.Humanoid:UnequipTools()
			player.Backpack:ClearAllChildren()
			if player.Character then
				player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
			end
			if table.find(collectionService:GetTags(player), "DoublePoints") ~= nil then
				player.leaderstats.Growth.Value += (player.leaderstats.Prestige.Value*1000 + 500)*2
			else
				player.leaderstats.Growth.Value += player.leaderstats.Prestige.Value*1000 + 500
			end

			if i == 1 then
				winners = winners..player.Name
			else
				winners = winners..", "..player.Name
			end
		end
	else
		winners = winners.."No one!"
	end
end


	
