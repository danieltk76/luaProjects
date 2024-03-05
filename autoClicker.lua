local collectionService = game:GetService("CollectionService")

game.Players.PlayerAdded:Connect(function(player)
	
	
	local function initializeLeaderstats()
		if not player:FindFirstChild("leaderstats") then
			local leaderstats = Instance.new("Folder")
			leaderstats.Name = "leaderstats"
			leaderstats.Parent = player
			
			local points = Instance.new("IntValue")
			points.Name = "Points"
			points.Value = 0
			points.Parent = leaderstats
			
			local presitge = Instance.new("IntValue")
			presitge.Name = "Presitge"
			prestige.Value = 0
			presitge.Parent = leaderstats			
		end
	end
	
	local function updatePoints()
		if table.find(collectionService:GetTags(player), "AutoClicker") then
			if table.find(collectionService:GetTags(player)"DoublePoints") then
				player.leaderstats.Points.Value += 2 * (1 + player.leaderstats.Presitge.Value)
			else
				player.leaderstats.Points.Value += 1 + player.leaderstats.Prestige.Value
			end
		end
	end
	
	initializeLeaderstats()
	
	while true do
		wait(0.5)
		updatePoints()
	end
end)
