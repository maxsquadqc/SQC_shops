ESX = exports['es_extended']:getSharedObject()
local ox_inventory = exports.ox_inventory
local itemsInStash = false

RegisterServerEvent("sqc:server:register:stash")
AddEventHandler('sqc:server:register:stash', function()
        for shops , data in pairs(Config.shopsTargets) do
		 for i=1, #shops do
			ox_inventory:RegisterStash(data.id, data.shops, data.slots, data.weight, data.owner)
		 end
        end
end)

local function GetRandomReward()
    local random = math.random(#Config.rewards)
    return Config.rewards[random]
end

local function checkStash()
    for _ , data in pairs(Config.shopsTargets) do
        local shopsItems = ox_inventory:GetInventoryItems(data.id)
        if shopsItems ~= false then
            for _ , data in pairs(shopsItems) do
                if shopsItems ~= nil then
                      itemsInStash = true
                     return
                end
            end
        end
    end
    itemsInStash = false
end

local function itemHandler()
    local source = source
    local reward = GetRandomReward()

 for _ , data in pairs(Config.shopsTargets) do
    for nameItem , priceItem in pairs(Config.whiteListItems) do
       local stashItem = ox_inventory:GetInventoryItems(data.id)
        if stashItem ~= false then
            for _ , item in pairs(stashItem) do
                if item.name == nameItem then
                     ox_inventory:RemoveItem(data.id, nameItem, item.count)
                     Wait(1000)
                     ox_inventory:AddItem(data.id , reward, item.count * priceItem.price)
                end
            end
        end
    end
 end
end

Citizen.CreateThread(function()
    while true do
     checkStash()
        if itemsInStash then
            itemHandler()
        end
     Citizen.Wait(3000)
    end
end)
