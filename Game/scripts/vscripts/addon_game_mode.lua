-- Generated from template

_G.COUNTDOWNTIMERVALUE = 10
_G.nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
_G.currentDay = 0

roshan_radiant = nil;
roshan_dire = nil;

ward_radiant = nil;
ward_dire = nil;

_G.spawn_radiant = false;
_G.spawn_dire = false;

if FrostivusGameMode == nil then
	FrostivusGameMode = class({})
	_G.FrostivusGameMode = FrostivusGameMode
end

---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require( "utility_functions" )
require( "entity_functions" )
require ( "scores")
--require( "events" )

function Precache( context )

	--Precache things we know we'll use.  Possible file types include (but not limited to):
	--PrecacheResource( "model", "*.vmdl", context )
	--PrecacheResource( "particle", "*.vpcf", context )
	--PrecacheResource( "particle_folder", "particles/folder", context )
	PrecacheResource("soundfile", "soundevents/custom_sounds.vsndevts", context)

end

-- Create the game mode when we activate
function Activate()
	GameRules.frostivus = FrostivusGameMode()
	GameRules.frostivus:InitGameMode()
end

function FrostivusGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	--Here we code
	GameRules:SetCustomGameEndDelay( 0 )
	GameRules:SetCustomVictoryMessageDuration( 10 )
	GameRules:GetGameModeEntity():SetCameraDistanceOverride(1500);
	GameRules:SetPreGameTime( 5 )
	GameRules:SetStrategyTime( 5.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetStartingGold(10000)

	ward_radiant = Entities:FindByName(nil,"npc_dota_frostivus_ward_radiant")
	ward_dire = Entities:FindByName(nil,"npc_dota_frostivus_ward_dire")
	
	CustomGameEventManager:RegisterListener( "endscreen_request_data", Dynamic_Wrap(FrostivusGameMode, "EndScreenRequestData"))
	ListenToGameEvent( "entity_killed", Dynamic_Wrap( FrostivusGameMode, 'OnEntityKilled' ), self )
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( FrostivusGameMode, 'OnGameRulesStateChange' ), self )
end

-- Evaluate the state of the game
function FrostivusGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		local currentDay = CountdownTimer()

		if currentDay == 3 then
			ward_radiant:RemoveModifierByName("modifier_invulnerable");
			ward_dire:RemoveModifierByName("modifier_invulnerable");
		elseif currentDay == 10 then
			FrostivusGameMode:SpawnRoshan()
			--GameRules:AddMinimapDebugPoint(1, roshan_radiant:GetCenter(), 255, 255, 255, 500, 3.0)
			--GameRules:AddMinimapDebugPointForTeam(1, roshan_radiant:GetCenter(), 255, 255, 255, 1000, 3.0, DOTA_TEAM_BADGUYS)
			--print(roshan_radiant:GetAbsOrigin())
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_GOODGUYS, "ping_location", { spawn_location = roshan_dire:GetAbsOrigin() } )
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_BADGUYS, "ping_location", { spawn_location = roshan_radiant:GetAbsOrigin() } )
			--(nTeamID, hEntity, nXCoord, nYCoord, nEventType, nEventDuration)
        end
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end


function FrostivusGameMode:EndScreenRequestData()
	print("EndScreenRequestData");
	for playerID = 0, ( DOTA_MAX_TEAM_PLAYERS-1 ) do
		if PlayerResource:GetTeam( playerID ) == DOTA_TEAM_GOODGUYS or PlayerResource:GetTeam( playerID ) == DOTA_TEAM_BADGUYS then
			local info_table = GetPlayerScores( playerID )
			CustomGameEventManager:Send_ServerToAllClients("end_screen", {key=playerID, table=info_table})
		end
	end
	CustomGameEventManager:Send_ServerToAllClients("end_screen", {key="gameData", table=GetGameScores()})
end


function FrostivusGameMode:OnEntityKilled( event )
	--FrostivusGameMode:UpdateScoreboard();
	local attackerUnit = EntIndexToHScript( event.entindex_attacker or -1 )
	local killedUnit = EntIndexToHScript( event.entindex_killed )

	
	if killedUnit:GetUnitName() == "npc_dota_creature_mini_roshan" then
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			-- dire won
			roshan_dire:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL,3)
			FrostivusGameMode:EndGame(DOTA_TEAM_BADGUYS)
			
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			--radiant won
			roshan_radiant:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL,3)
			FrostivusGameMode:EndGame(DOTA_TEAM_GOODGUYS)
			
		end
		--self:_AwardPoints( self._currentRound:GetPointReward() )
		--self:_Victory()	
		
	elseif killedUnit:GetUnitName() == "npc_dota_frostivus_ward" then
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			-- spawn greevlings on radiant side
			_G.spawn_radiant = true;
			
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			-- spawn greevlings on dire side
			_G.spawn_dire = true;
			
		end
	end
end

function FrostivusGameMode:EndGame( victoryTeam )
	if victoryTeam == DOTA_TEAM_GOODGUYS then
		GameRules:SetCustomVictoryMessage( "Team Snowleopard won!");
	else
		GameRules:SetCustomVictoryMessage( "Team Owl won!");
	end	
	--FrostivusGameMode:UpdateScoreboard();
	_G.WINNER = victoryTeam;
	GameRules:SetGameWinner( victoryTeam )
	
	
end

function FrostivusGameMode:OnGameRulesStateChange()
	local nNewState = GameRules:State_Get()
	--print( "OnGameRulesStateChange: " .. nNewState )
	if (nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and currentDay == 0) then
		--print( "OnGameRulesStateChange: Game In Progress" )
		IncreaseDay()
		print("OnGameRulesStateChange Changing day to "..currentDay)
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
		CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
		ward_radiant:AddNewModifier(ward_radiant, nil, "modifier_invulnerable", nil)
		ward_dire:AddNewModifier(ward_dire, nil, "modifier_invulnerable", nil)
	elseif nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		--Add Instruction Panel call here
		FrostivusGameMode:ForceAssignHeroes()
		for nPlayerID = 0, ( DOTA_MAX_TEAM_PLAYERS - 1 ) do
			if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS or PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_BADGUYS then
				--local hPlayer = PlayerResource:GetPlayer( nPlayerID )
				--print(hPlayer:GetOwner());
				--hPlayer:GetOwner():AddItemByName("item_phase_boots")
			end
		end
	end
end

function FrostivusGameMode:ForceAssignHeroes()
	print( "ForceAssignHeroes()" )
	for nPlayerID = 0, ( DOTA_MAX_TEAM_PLAYERS - 1 ) do
		if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS or PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_BADGUYS then
			local hPlayer = PlayerResource:GetPlayer( nPlayerID )
			if hPlayer and not PlayerResource:HasSelectedHero( nPlayerID ) then
				print( "  Hero selection time is over: forcing nPlayerID " .. nPlayerID .. " to random a hero." )
				hPlayer:MakeRandomHeroSelection()
			end
		end
	end
end

function FrostivusGameMode:SpawnRoshan()
    local point1 = Entities:FindByName( nil, "santa_spawn_radiant"):GetAbsOrigin()
    roshan_radiant = CreateUnitByName("npc_dota_creature_mini_roshan", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
    

    local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
    roshan_dire = CreateUnitByName("npc_dota_creature_mini_roshan", point2, true, nil, nil, DOTA_TEAM_BADGUYS)
	
end
