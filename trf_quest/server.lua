local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","trf_quest")

vRPStrf = {}
Tunnel.bindInterface("trf_quest",vRPStrf)
Proxy.addInterface("trf_quest",vRPStrf)
vRPCtrf = Tunnel.getInterface("trf_quest","trf_quest")

--ALTER TABLE vrp_users ADD `bomboanepack` int(11) NOT NULL DEFAULT 0;   -- ASTA TREBUIE SA ADAUGATI IN BAZA DE DATE

bomboane = {}
quest = {}

vRP.defInventoryItem({trfConfig.itemCod,trfConfig.itemName,trfConfig.itemDescription,trfConfig.itemHeight})

RegisterCommand(trfConfig.comandaQuest,function(source)
  local user_id = vRP.getUserId{source}
    if not quest[user_id] then
      local user_id = vRP.getUserId{source}
      bomboane[user_id] = exports.ghmattimysql:scalarSync('SELECT bomboanepack from vrp_users where id = @user_id',{user_id = user_id})
      TriggerClientEvent("trf:quest",source,bomboane[user_id]*100/trfConfig.bombaneMax,true)
      TriggerClientEvent("trf:questmission",source)
      vRPclient.notify(source,{"Quest ACTIVAT, du-te si colinda casele pentru a umple sacul de la primarie cu "..trfConfig.itemName.."!"})
      quest[user_id] = true
    else
      vRPclient.notify(source,{"Quest-ul deja este activ!"})
    end
end)
RegisterCommand(trfConfig.comandaPack,function(source)
    local user_id = vRP.getUserId{source}
    if quest[user_id] then
      if #(GetEntityCoords(GetPlayerPed(source)) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 1.5 then
          local a = vRP.getInventoryItemAmount{user_id,trfConfig.itemCod} or 0
          if vRP.tryGetInventoryItem{user_id, trfConfig.itemCod, a, true} then
              bomboane[user_id] = bomboane[user_id]+a
              exports.ghmattimysql:execute("UPDATE vrp_users SET bomboanepack = @bomboanepack WHERE id = @user_id", {bomboanepack = bomboane[user_id], user_id = user_id}, function()end)
              TriggerClientEvent("trf:quest",source,math.floor((bomboane[user_id])*100/trfConfig.bombaneMax),false)
              TriggerClientEvent("trf:quest",source,math.floor((bomboane[user_id])*100/trfConfig.bombaneMax),true)
              vRPclient.notify(source,{"Felicitari ! Ai pus "..a.." "..trfConfig.itemName.." in sac, du-te si mai aduna "..trfConfig.itemName.." si umple sacul!"})
          else
              vRPclient.notify(source,{"Nu ai bomboane!"})
          end
      end
    end
end)
RegisterCommand(trfConfig.comandaCollect,function(source)
    local user_id = vRP.getUserId{source}
    if quest[user_id] then
      if #(GetEntityCoords(GetPlayerPed(source)) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 1.5 then
          if bomboane[user_id]>= 100 then
              exports.ghmattimysql:execute("UPDATE vrp_users SET bomboanepack = @a WHERE id = @user_id", {a = 0, user_id = user_id}, function()end)
              bomboane[user_id] = 0
              TriggerClientEvent("trf:quest",source,math.floor((bomboane[user_id])*100/trfConfig.bombaneMax),false)
              TriggerClientEvent("trf:quest",source,math.floor((bomboane[user_id])*100/trfConfig.bombaneMax),true)
              vRP.giveMoney{user_id,trfConfig.rewardBani}
              vRPclient.notify(source,{"Felicitari ! Ai umplut sacul si ai primit "..trfConfig.rewardBani.." bani"})
          else
              vRPclient.notify(source,{"Sacul nu este plin, mai trebuie sa aduci ~y~"..trfConfig.bombaneMax-bomboane[user_id].." ~w~de "..trfConfig.itemName.." pentru a-l putea colecta"})
          end
      end
    end
end)
timeout = {}
function vRPStrf.primesteReward()
  local user_id = vRP.getUserId{source}
  local new_weight = vRP.getInventoryWeight{user_id}+vRP.getItemWeight{trfConfig.itemCod}
  if not timeout[user_id] then
    timeout[user_id] = true
    if new_weight <= vRP.getInventoryMaxWeight{user_id} then
      vRP.giveInventoryItem{user_id,trfConfig.itemCod,trfConfig.rewardBomboane,true}
    end
    SetTimeout(15000, function()
      timeout[user_id] = false
    end)
  else
    DropPlayer(source,"Nice try.")
  end
end
AddEventHandler('vRP:playerLeave',function(user_id)
  if quest[user_id] then
    quest[user_id] = false
  end
end)

