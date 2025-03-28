local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Controllers = ReplicatedStorage:FindFirstChild("Controllers")

if Controllers then
    local AbilityController = Controllers:FindFirstChild("AbilityController") and require(Controllers.AbilityController)

    if AbilityController and AbilityController.AbilityCooldown then
        -- Store original function
        local originalCooldown = AbilityController.AbilityCooldown

        -- Override cooldown function to reduce cooldown to 1% of its original time
        AbilityController.AbilityCooldown = function(self, abilityName, time, ...)
            local newCooldown = time and math.max(time * 0.01, 0.05) or 0.05 -- Reduce cooldown to 1% of original, min 0.05s
            return originalCooldown(self, abilityName, newCooldown, ...)
        end

        print("[INFO] Ability cooldown successfully reduced to 1%!")
    else
        print("[WARNING] AbilityController or AbilityCooldown not found!")
    end
else
    print("[WARNING] Controllers folder not found in ReplicatedStorage!")
end