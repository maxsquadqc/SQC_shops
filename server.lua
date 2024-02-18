ESX = exports['es_extended']:getSharedObject()
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory

local response = MySQL.query.await('SELECT * FROM `ox_inventory`', {}, function(result)
    stashes = result
end)

RegisterServerEvent("sqc:server:register:stash")
AddEventHandler('sqc:server:register:stash', function()
        for shops , data in pairs(Config.shopsTargets) do
		 for i=1, #shops do
			ox_inventory:RegisterStash(data.id, data.shops, data.slots, data.weight, data.owner)
		 end
        end
    print("success")
end)

local function GetRandomReward()
    local random = math.random(#Config.rewards)
    return Config.rewards[random]
end

local function getStash(shop)
    local source   = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local stashItem = ox_inventory:GetInventoryItems(shop)
    print('1', json.encode(stashItem, {indent = true}))

    for _ , v in pairs(response) do
        local reward = GetRandomReward()
        print('1', v.name)
        if shop == v.name then
            for slot , item in pairs(stashItem) do
                Wait(5000)
                ox_inventory:RemoveItem(shop, item.name, item.count)
                Wait(2500)
                ox_inventory:AddItem(source , reward, math.random(1, item.count))
            end
        end
    end
end

RegisterNetEvent('sqc_shops:server:openStash')
AddEventHandler('sqc_shops:server:openStash', function(shop)
    print(shop)
    getStash(shop)
end)