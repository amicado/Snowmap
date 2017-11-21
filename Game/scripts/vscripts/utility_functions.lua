--[[ utility_functions.lua ]]

function CountdownTimer()
    if nCOUNTDOWNTIMER == COUNTDOWNTIMERVALUE then
        CustomGameEventManager:Send_ServerToAllClients( "start_timer", {} )
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
    
    if t <= 10 then
        CustomGameEventManager:Send_ServerToAllClients( "timer_alert", {isTrue=true} )
    end
    if t <= 0 then
        IncreaseDay()
        --print("CountdownTimer Changing day to "..currentDay.." in countdown")
	    nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
		CustomGameEventManager:Send_ServerToAllClients( "timer_alert", {isTrue=false} )
        CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
        CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
        return currentDay;
    end
    
    CustomGameEventManager:Send_ServerToAllClients( "countdown", broadcast_gametimer )
    return -1;
end

function IncreaseDay()
    currentDay = currentDay+1;
    
    -- give gold to all players
    GameRules:SetGoldPerTick(3*currentDay);


    if(currentDay > 1 and currentDay <= 25) then
        for nPlayerID = 0, ( DOTA_MAX_TEAM_PLAYERS - 1 ) do
            if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS or PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_BADGUYS then
                PlayerResource:GetPlayer(nPlayerID):GetAssignedHero():HeroLevelUp(true);
            end
        end
    end
    

    if(tree_dire == nil and currentDay < 25) then
        --print("Spawning Greevling on dire");
        local point1 = Entities:FindByName( nil, "santa_spawn_radiant"):GetAbsOrigin()
        CreateUnitByName("npc_dota_creature_greevil", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
        --GameRules:AddMinimapDebugPointForTeam(DOTA_TEAM_BADGUYS, unit:GetCenter(), 255, 255, 255, 1000, 2.0) -- (PlayerID, position, R, G, B, SizeofDot, Duration)
    elseif(tree_radiant == nil and currentDay < 25) then
        --print("Spawning Greevling on radiant");
        
        local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
        CreateUnitByName("npc_dota_creature_greevil", point2, true, nil, nil, DOTA_TEAM_BADGUYS)
        --GameRules:AddMinimapDebugPointForTeam(DOTA_TEAM_GOODGUYS, unit:GetCenter(), 255, 255, 255, 1000, 2.0)
    end
end

