-- Generated from template

_G.COUNTDOWNTIMERVALUE = 30
_G.nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
_G.currentDay = 0
roshan_radiant = nil;
roshan_dire = nil;

if FrostivusGameMode == nil then
	FrostivusGameMode = class({})
	_G.FrostivusGameMode = FrostivusGameMode
end

---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require( "utility_functions" )
--require( "events" )

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
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
	GameRules:SetCustomGameEndDelay( 0 )
	GameRules:SetCustomVictoryMessageDuration( 10 )
	GameRules:SetPreGameTime( 5 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetStartingGold(10000)

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

function FrostivusGameMode:OnEntityKilled( event )
	local attackerUnit = EntIndexToHScript( event.entindex_attacker or -1 )
	local killedUnit = EntIndexToHScript( event.entindex_killed )

	
	if killedUnit:GetUnitName() == "npc_dota_creature_mini_roshan" then
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			-- dire won
			self.roshan_dire:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL,3)
			FrostivusGameMode:EndGame(DOTA_TEAM_BADGUYS)
			
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			--radiant won
			self.roshan_radiant:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL,3)
			FrostivusGameMode:EndGame(DOTA_TEAM_GOODGUYS)
			
		end
		--self:_AwardPoints( self._currentRound:GetPointReward() )
		--self:_Victory()	
		
	end
end

function FrostivusGameMode:EndGame( victoryTeam )
	GameRules:SetGameWinner( victoryTeam )
end

function FrostivusGameMode:OnGameRulesStateChange()
	local nNewState = GameRules:State_Get()
	--print( "OnGameRulesStateChange: " .. nNewState )
	if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "OnGameRulesStateChange: Game In Progress" )
		IncreaseDay()
		print("Changing day to "..currentDay)
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
        CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
	end
end

function FrostivusGameMode:SpawnRoshan()
    local point1 = Entities:FindByName( nil, "santa_spawn_radiant"):GetAbsOrigin()
    self.roshan_radiant = CreateUnitByName("npc_dota_creature_mini_roshan", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
    

    local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
    self.roshan_dire = CreateUnitByName("npc_dota_creature_mini_roshan", point2, true, nil, nil, DOTA_TEAM_BADGUYS)
	
end
