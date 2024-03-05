local STEP_SIZE: number = 1/1_200
local GROWTH_INCREMENT: number = 0.05 -- 5% growth
local POINTS_FOR_GROWTH: number = 2000
local MAXIMUM_SIZE_MULTIPLIER: number = 4
local INITIAL_SPEED: number = 16

game.Players.PlayerAdded:Connect(function(Plr)
	Plr.CharacterAdded:Connect(function(Char)
	
		local leaderstats = Plr:WaitForChild("leaderstats")
		local Growth = leaderstats:WaitForChild("Growth")
		local previousPoints = Growth.Value

	
		local function applyGrowthAndSpeed(hum, growthMultiplier)
			local newSizeMultiplier = math.min(growthMultiplier, MAXIMUM_SIZE_MULTIPLIER)
			hum:WaitForChild("HeadScale").Value = newSizeMultiplier
			hum:FindFirstChild("BodyHeightScale").Value = newSizeMultiplier
			hum:FindFirstChild("BodyWidthScale").Value = newSizeMultiplier
			hum:FindFirstChild("BodyDepthScale").Value = newSizeMultiplier

	
			hum.WalkSpeed = INITIAL_SPEED * newSizeMultiplier
		end

		
		local justLoaded = true
		while true do
			wait(1) 
			local currentPoints = Growth.Value
			if currentPoints - previousPoints >= POINTS_FOR_GROWTH then
				local increments = math.floor((currentPoints - previousPoints) / POINTS_FOR_GROWTH)
				for i = 1, increments do
					if Growth.Value < MAXIMUM_SIZE_MULTIPLIER then
						Growth.Value = Growth.Value * (1 + GROWTH_INCREMENT)
					end
				end
				previousPoints = currentPoints 

				local hum = Char.Humanoid
				applyGrowthAndSpeed(hum, Growth.Value / 100) -

				if justLoaded then
					task.wait(1)
					hum.Health = hum.MaxHealth
					justLoaded = false
				end

				Plr.CameraMaxZoomDistance = hum.HeadScale.Value * 60
			end
		end
	end)
end)
