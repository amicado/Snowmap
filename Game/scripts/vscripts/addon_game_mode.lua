-- Generated from template

_G.COUNTDOWNTIMERVALUE = 16
_G.nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
_G.currentDay = 0

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
	GameRules:GetGameModeEntity():SetCameraDistanceOverride(1500);
	GameRules:SetCustomGameEndDelay( 0 )
	GameRules:SetCustomVictoryMessageDuration( 10 )
	GameRules:SetPreGameTime( 10 )
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
			FrostivusGameMode:EndGame(DOTA_TEAM_BADGUYS)
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			--radiant won
			FrostivusGameMode:EndGame(DOTA_TEAM_GOODGUYS)
		end
		--self:_AwardPoints( self._currentRound:GetPointReward() )
		--self:_Victory()
	end
end

function FrostivusGameMode:EndGame( victoryTeam )
	local roshan = Entities:FindByName( nil, "npc_dota_creature_mini_roshan" )
	if roshan then
		local celebrate = roshan:FindAbilityByName( 'dota_ability_celebrate' )
		if celebrate then
			roshan:CastAbilityNoTarget( celebrate, -1 )
		end
	end
	print( "SetGameWinner "..victoryTeam )

	GameRules:SetGameWinner( victoryTeam )
end

function FrostivusGameMode:OnGameRulesStateChange()
	local nNewState = GameRules:State_Get()
	--print( "OnGameRulesStateChange: " .. nNewState )
	if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "OnGameRulesStateChange: Game In Progress" )
		currentDay = 1
		print("Changing day to "..currentDay)
		CustomGameEventManager:Send_ServerToAllClients( "update_day", {day = currentDay} )
        CustomGameEventManager:Send_ServerToAllClients( "update_notification", {day = currentDay} )
	end
end
