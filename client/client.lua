local RSGCore = exports['rsg-core']:GetCoreObject()

-- Lockpick practice function
local function lockpickFinish(success)
    if success then
        -- Use rNotify style notification for success
        TriggerEvent('rNotify:NotifyLeft', "LOCKPICK PRACTICE SUCCESSFUL!", "NICE!", "generic_textures", "tick", 4000)
        
        -- Reward logic
        TriggerServerEvent('rsg-padlock:server:giveReward')
    else
        -- Use rNotify style notification for failure
        TriggerEvent('rNotify:NotifyLeft', "LOCKPICK PRACTICE FAILED!", "DAMN", "generic_textures", "cross", 4000)
    end
end

-- Register the padlock use event
RegisterNetEvent('rsg-padlock:client:usePadlock', function()
    local hasLockpick = RSGCore.Functions.HasItem('lockpick', 1)
    
    if hasLockpick then
        -- Remove lockpick item
        TriggerServerEvent('rsg-padlock:server:removeLockpick')
        
        -- Trigger lockpick minigame
        TriggerEvent('rsg-lockpick:client:openLockpick', lockpickFinish)
    else
        -- Use rNotify style notification for no lockpick
        TriggerEvent('rNotify:NotifyLeft', "YOU NEED A LOCKPICK!", "PREPARE FIRST", "generic_textures", "cross", 4000)
    end
end)