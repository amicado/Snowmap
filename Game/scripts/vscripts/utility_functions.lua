--[[ utility_functions.lua ]]

function CountdownTimer()
    if currentDay == 0 then
		currentDay = 1
		print("Changing day to "..currentDay)
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
        CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
	end
    nCOUNTDOWNTIMER = nCOUNTDOWNTIMER - 1
    local t = nCOUNTDOWNTIMER
    --print( t )
    local minutes = math.floor(t / 60)
    local seconds = t - (minutes * 60)
    local m10 = math.floor(minutes / 10)
    local m01 = minutes - (m10 * 10)
    local s10 = math.floor(seconds / 10)
    local s01 = seconds - (s10 * 10)
    local broadcast_gametimer = 
        {
            timer_minute_10 = m10,
            timer_minute_01 = m01,
            timer_second_10 = s10,
            timer_second_01 = s01,
        }
    
    if t == 15 then
        CustomGameEventManager:Send_ServerToAllClients( "timer_alert", {isTrue=true} )
    end
    if t <= 0 then
        currentDay = currentDay+1;
        print("Changing day to "..currentDay.." in countdown")
        if currentDay == 2 then
            spawnRoshan() 
        end
	    nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
		CustomGameEventManager:Send_ServerToAllClients( "timer_alert", {isTrue=false} )
        CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
    end
    CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
end

function spawnRoshan()
    local point1 = Entities:FindByName( nil, "santa_spawn_radiant"):GetAbsOrigin()
    local unit1 = CreateUnitByName("npc_dota_roshan", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
    

    local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
    local unit2 = CreateUnitByName("npc_dota_roshan", point2, true, nil, nil, DOTA_TEAM_BADGUYS)

    ClearTeamCustomHealthbarColor(2)
    ClearTeamCustomHealthbarColor(3)
    ClearTeamCustomHealthbarColor(0)
    ClearTeamCustomHealthbarColor(1)
end
