ESX = exports['es_extended']:getSharedObject()
local ox_inventory = exports.ox_inventory
local ox_target = exports.ox_target

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)


Citizen.CreateThread(function()
    local spawnedPed = {}
    
   for shop, data in pairs(Config.shopsTargets) do
        local hashPed = GetHashKey(data.hash)
        while not HasModelLoaded(hashPed) do
            Wait(0)
            RequestModel(hashPed)
        end
        local pedExists = DoesEntityExist(spawnedPed[shop])

        if not pedExists then
    ped = CreatePed("PED_TYPE_CIVFEMALE", data.hash, data.coords.x, data.coords.y, data.coords.z, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityCanBeDamaged(ped, false)
	ox_target:addLocalEntity(ped, {
		{
			name = 'ped_target',
			icon = data.icons,
			label = data.shops,
			distance = data.distance,
			onSelect = function()
               -- TriggerServerEvent('sqc_shops:server:openStash', data.id)
                if ox_inventory:openInventory('stash', data.id) == false then
                   -- Print('trigger client')
                    TriggerServerEvent('sqc:server:register:stash')
                    ox_inventory:openInventory('stash', data.id)
                end
			end,
		}
	})
    spawnedPed[shop] = ped
end
   end

   for _, ped in pairs(spawnedPed) do
    SetModelAsNoLongerNeeded(ped)
   end
end)
