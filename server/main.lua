local KGCore = exports['kg-core']:GetCoreObject()
local Bail = {}

-- Callbacks

KGCore.Functions.CreateCallback('kg-hotdogjob:server:HasMoney', function(source, cb)
    local Player = KGCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.bank >= Config.StandDeposit then
        Player.Functions.RemoveMoney('bank', Config.StandDeposit, 'hot dog deposit')
        Bail[Player.PlayerData.citizenid] = true
        cb(true)
    else
        Bail[Player.PlayerData.citizenid] = false
        cb(false)
    end
end)

KGCore.Functions.CreateCallback('kg-hotdogjob:server:BringBack', function(source, cb)
    local Player = KGCore.Functions.GetPlayer(source)

    if Bail[Player.PlayerData.citizenid] then
        Player.Functions.AddMoney('bank', Config.StandDeposit, 'hot dog deposit')
        cb(true)
    else
        cb(false)
    end
end)

-- Events

RegisterNetEvent('kg-hotdogjob:server:Sell', function(coords, amount, price)
    local src = source
    local pCoords = GetEntityCoords(GetPlayerPed(src))
    local Player = KGCore.Functions.GetPlayer(src)
    if not Player then return end
    if #(pCoords - coords) > 4 then exports['kg-core']:ExploitBan(src, 'hotdog job') end
    Player.Functions.AddMoney('cash', tonumber(amount * price), 'sold hotdog')
end)

RegisterNetEvent('kg-hotdogjob:server:UpdateReputation', function(quality)
    local src = source
    local Player = KGCore.Functions.GetPlayer(src)
    if quality == 'exotic' then
        if Player.Functions.GetRep('hotdog') + 3 > Config.MaxReputation then
            Player.Functions.AddRep('hotdog', Config.MaxReputation - Player.Functions.GetRep('hotdog'))
        else
            Player.Functions.AddRep('hotdog', 3)
        end
    elseif quality == 'rare' then
        if Player.Functions.GetRep('hotdog') + 2 > Config.MaxReputation then
            Player.Functions.AddRep('hotdog', Config.MaxReputation - Player.Functions.GetRep('hotdog'))
        else
            Player.Functions.AddRep('hotdog', 2)
        end
    elseif quality == 'common' then
        if Player.Functions.GetRep('hotdog') + 1 > Config.MaxReputation then
            Player.Functions.AddRep('hotdog', Config.MaxReputation - Player.Functions.GetRep('hotdog'))
        else
            Player.Functions.AddRep('hotdog', 1)
        end
    end

    TriggerClientEvent('kg-hotdogjob:client:UpdateReputation', src, Player.PlayerData.metadata['rep'])
end)

-- Commands

KGCore.Commands.Add('removestand', Lang:t('info.command'), {}, false, function(source, _)
    TriggerClientEvent('kg-hotdogjob:staff:DeletStand', source)
end, 'admin')
