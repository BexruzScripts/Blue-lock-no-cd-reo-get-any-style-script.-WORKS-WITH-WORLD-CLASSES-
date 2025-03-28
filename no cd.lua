local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Controllers = ReplicatedStorage:FindFirstChild("Controllers")

if Controllers then
    local AbilityController = Controllers:FindFirstChild("AbilityController") and require(Controllers.AbilityController)

    if AbilityController and AbilityController.AbilityCooldown then
        -- Store original function
        local originalCooldown = AbilityController.AbilityCooldown

        -- Override cooldown function to set cooldown to 0
        AbilityController.AbilityCooldown = function(self, abilityName, time, ...)
            return originalCooldown(self, abilityName, 0, ...) -- Force cooldown to 0
        end

        print("[SUCCESS] Ability cooldown set to 0 (instant spam)!")
    else
        print("[WARNING] AbilityController or AbilityCooldown not found!")
    end
else
    print("[WARNING] Controllers folder not found in ReplicatedStorage!")
end