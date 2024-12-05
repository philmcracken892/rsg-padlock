local RSGCore = exports['rsg-core']:GetCoreObject()

-- Register the padlock as a useable item
RSGCore.Functions.CreateUseableItem('padlock', function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    
    -- Trigger client-side padlock use
    TriggerClientEvent('rsg-padlock:client:usePadlock', source)
end)

-- Server event to remove lockpick
RegisterServerEvent('rsg-padlock:server:removeLockpick')
AddEventHandler('rsg-padlock:server:removeLockpick', function()
    local Player = RSGCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('lockpick', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, RSGCore.Shared.Items['lockpick'], "remove")
end)

-- Server event to give reward
RegisterServerEvent('rsg-padlock:server:giveReward')
AddEventHandler('rsg-padlock:server:giveReward', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    -- Reward options (adjust as needed)
    local rewardOptions = {
        {item = 'cash', amount = math.random(5, 20)},
        {item = 'lockpick', amount = 1},
        {item = 'fieldbandage', amount = 1}
    }

    -- Randomly select a reward
    local reward = rewardOptions[math.random(#rewardOptions)]

    -- Give reward based on type
    if reward.item == 'cash' then
        Player.Functions.AddMoney('cash', reward.amount)
        TriggerClientEvent('rNotify:NotifyLeft', src, "PRACTICE REWARD!", "+" .. reward.amount .. " CASH", "generic_textures", "tick", 4000)
    else
        Player.Functions.AddItem(reward.item, reward.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[reward.item], "add")
        TriggerClientEvent('rNotify:NotifyLeft', src, "PRACTICE REWARD!", "+" .. reward.amount .. " " .. reward.item:upper(), "generic_textures", "tick", 4000)
    end
end)