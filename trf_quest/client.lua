vRPCtrf = {}
Tunnel.bindInterface("trf_quest",vRPCtrf)
Proxy.addInterface("trf_quest",vRPCtrf)
vRPStrf = Tunnel.getInterface("trf_quest","trf_quest")
vRP = Proxy.getInterface("vRP")

local pr1 = "🟥🟥🟥🟥🟥"
local pr2 = "🟩🟥🟥🟥🟥"
local pr3 = "🟩🟩🟥🟥🟥"
local pr4 = "🟩🟩🟩🟥🟥"
local pr5 = "🟩🟩🟩🟩🟥"
local pr6 = "🟩🟩🟩🟩🟩"
local loop = false
local procent = 0

RegisterNetEvent("trf:quest")
AddEventHandler("trf:quest", function(pr,on)
    procent = math.floor(pr)
    loop = on
    CreateThread(function()
        while loop do
            tick = 1000
    		ped = PlayerPedId()
    		RequestStreamedTextureDict("marker", true)
    		while not HasStreamedTextureDictLoaded("marker") do
                Wait(tick)
    		end
    		if #(GetEntityCoords(ped) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 10.0 then
                tick = 1
    			DrawMarker(9, trfConfig.position[1],trfConfig.position[2],trfConfig.position[3], 0.0, 0.0, 0.0, 60.0, 90.0, 90.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,true, false, 2, true, "marker", "marker", false)
    			if #(GetEntityCoords(ped) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 3.0 then
    				DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]+1, "🎄 Umple sacul mosului 🎅🏽~w~ cu ~y~dulciuri 🍬 \n~w~pentru a primi ~r~bani 🎁", 1.0)
                    DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.5, "[ "..procent.."% ]", 1.0)
                    if procent == 0 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr1, 1.0)
                    elseif procent > 0 and procent < 25 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr2, 1.0)
                    elseif procent >= 25 and procent < 50 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr3, 1.0)
                    elseif procent >= 50 and procent < 75 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr4, 1.0)
                    elseif procent >= 75 and procent < 100 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr5, 1.0)
                    elseif procent >= 100 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.7, pr6, 1.0)
                    end
    				if #(GetEntityCoords(ped) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 1.5 and procent < 100 then
    					DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.9, "Foloseste comanda ~y~/"..trfConfig.comandaPack.." \n ~w~pentru a pune dulciurile in sac", 1.0)
                    elseif #(GetEntityCoords(ped) - vector3(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3])) <= 1.5 and procent >= 100 then
                        DrawText3D(trfConfig.position[1],trfConfig.position[2],trfConfig.position[3]-0.9, "Foloseste comanda ~g~/"..trfConfig.comandaCollect.." \n ~w~pentru a colecta cadourile", 1.0)
    				end
    			end 
    		end
    		Wait(tick)
        end
    end)
end)

RegisterNetEvent("trf:questmission")
AddEventHandler("trf:questmission", function()
    CreateThread(function()
        locatie = trfConfig.places[math.random(1,#trfConfig.places)]
        blipcasa = AddBlipForCoord(locatie[1],locatie[2],locatie[3])
        SetBlipSprite(blipcasa, trfConfig.blipSprite)
        SetBlipScale (blipcasa, trfConfig.blipScale)
        SetBlipColour(blipcasa, trfConfig.blipColour)
        SetBlipRoute(blipcasa, trfConfig.blipRoute)
        SetBlipRouteColour(blipcasa, trfConfig.blipColourRoute)
        while true do
            ped = PlayerPedId()
            tick = 1000
            if #(GetEntityCoords(ped) - vector3(locatie[1],locatie[2],locatie[3])) <= 5.0 then
                tick = 1
                DrawMarker(0 , locatie[1],locatie[2],locatie[3],0,0,0,0,0,0, 0.3001,0.3001,0.3001 , 255,255,0,100 ,0,1,0,0)
                if #(GetEntityCoords(ped) - vector3(locatie[1],locatie[2],locatie[3])) <= 1.0 then
                    DrawText3D(locatie[1],locatie[2],locatie[3]-0.5, "Apasa ~y~E ~w~pentru a colinda 🍬", 0.9)
                    if(IsControlJustReleased(0,51) and not IsPedInAnyVehicle(ped, false))then
                        ExecuteCommand("e knock")
                        FreezeEntityPosition(ped,true)
                        Wait(3000)
                        ExecuteCommand("e c")
                        local ped_hash = GetHashKey(trfConfig.ped)
                        RequestModel(ped_hash)
                        while not HasModelLoaded(ped_hash) do
                            Wait(1)
                        end	
                        x,y,z = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -1.0)
                        h = GetEntityHeading(ped)
                        npctrf = CreatePed(1, ped_hash, x,y,z,h+180, false, true)
                        SetEntityHeading(npctrf, h+180)
                        SetBlockingOfNonTemporaryEvents(npctrf, true)
                        SetPedDiesWhenInjured(npctrf, false)
                        SetPedCanPlayAmbientAnims(npctrf, true)
                        SetPedCanRagdollFromPlayerImpact(npctrf, false)
                        SetEntityInvincible(npctrf, true)
                        FreezeEntityPosition(npctrf, true)
                        RequestAnimDict("anim@heists@box_carry@")
                        while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
                            Wait(1)
                        end
                        TaskPlayAnim(npctrf, "anim@heists@box_carry@" ,"idle", 8.0, -8.0, -1, 2, 0, false, false, false)	
                        cos = CreateObject(GetHashKey('prop_fruit_basket'), x,y,z, true, true, true)
                        SetEntityCollision(cos , false)
                        AttachEntityToEntity(cos, npctrf, GetPedBoneIndex(npctrf, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
                        Wait(500)
                        ExecuteCommand("e musician")
                        Wait(7000)
                        ExecuteCommand("e c")
                        ExecuteCommand("e mechanic")
                        Wait(2000)
                        ExecuteCommand("e c")
                        vRPStrf.primesteReward()
                        FreezeEntityPosition(ped,false)
                        Wait(2000)
                        DeletePed(npctrf)
                        DeleteEntity(cos)
                        SetBlipRoute(blipcasa, false)
                        RemoveBlip(blipcasa)
                        TriggerEvent("trf:questmission")
                        break
                    end
                end
            end
            Wait(tick)
        end
    end)
end)

function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end