-- Generated from template

_G.COUNTDOWNTIMERVALUE = 5
_G.nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
_G.currentDay = 0
_G.roshan_radiant = nil;
_G.roshan_dire = nil;

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
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetStartingGold(10000)

	CustomGameEventManager:RegisterListener( "endscreen_request_data", Dynamic_Wrap(FrostivusGameMode, "EndScreenRequestData"))
	ListenToGameEvent( "entity_killed", Dynamic_Wrap( FrostivusGameMode, 'OnEntityKilled' ), self )
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( FrostivusGameMode, 'OnGameRulesStateChange' ), self )
end

-- Evaluate the state of the game
function FrostivusGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		CountdownTimer()
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
		
	end
end

function FrostivusGameMode:EndGame( victoryTeam )
	if victoryTeam == DOTA_TEAM_GOODGUYS then
		GameRules:SetCustomVictoryMessage( "Team Snowleopard won!");
	else
		GameRules:SetCustomVictoryMessage( "Team Owl won!");
	end	
	--FrostivusGameMode:UpdateScoreboard();
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
	elseif nNewState == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		--Add Instruction Panel call here
		FrostivusGameMode:ForceAssignHeroes()
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
    _G.roshan_radiant = CreateUnitByName("npc_dota_creature_mini_roshan", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
    

    local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
    _G.roshan_dire = CreateUnitByName("npc_dota_creature_mini_roshan", point2, true, nil, nil, DOTA_TEAM_BADGUYS)
	
end
