-- Generated from template

_G.COUNTDOWNTIMERVALUE = 5
_G.nCOUNTDOWNTIMER = COUNTDOWNTIMERVALUE
_G.currentDay = 0

_G.present_radiant = nil;
_G.present_dire = nil;

_G.ward_radiant = nil;
_G.ward_dire = nil;

_G.tree_radiant = nil;
_G.tree_dire = nil;

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
require( "entity_functions" )
require ( "scores" )
require( "timers" )
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
	GameRules:SetPreGameTime( 10 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetStartingGold(1000)
	GameRules:SetUseCustomHeroXPValues(true)		
	GameRules:SetGoldPerTick(3)		
	GameRules:SetGoldTickTime(1)
	GameRules:SetUseUniversalShopMode(true)
	GameRules:SetRuneSpawnTime(-1)

	GameRules:GetGameModeEntity():SetAnnouncerDisabled(true);

	_G.present_radiant = Entities:FindByName(nil,"npc_dota_frostivus_present_radiant")
	_G.present_dire = Entities:FindByName(nil,"npc_dota_frostivus_present_dire")
	--Enable autocast
	present_radiant:GetAbilityByIndex(0):ToggleAutoCast();
	present_dire:GetAbilityByIndex(0):ToggleAutoCast();

	_G.ward_radiant = Entities:FindByName(nil,"npc_dota_frostivus_ward_radiant")
	_G.ward_dire = Entities:FindByName(nil,"npc_dota_frostivus_ward_dire")

	_G.tree_radiant = Entities:FindByName(nil,"npc_dota_frostivus_tree_radiant")
	_G.tree_dire = Entities:FindByName(nil,"npc_dota_frostivus_tree_dire")
	
	CustomGameEventManager:RegisterListener( "endscreen_request_data", Dynamic_Wrap(FrostivusGameMode, "EndScreenRequestData"))
	ListenToGameEvent( "entity_killed", Dynamic_Wrap( FrostivusGameMode, 'OnEntityKilled' ), self )
	ListenToGameEvent( "entity_hurt", Dynamic_Wrap( FrostivusGameMode, 'OnEntityHurt' ), self )
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( FrostivusGameMode, 'OnGameRulesStateChange' ), self )
end

-- Evaluate the state of the game
function FrostivusGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and GameRules:IsGamePaused() == false then

		local currentDay = CountdownTimer()

		FrostivusGameMode:GiveGold()

		if currentDay == 17 then
			ward_radiant:RemoveModifierByName("modifier_invulnerable");
			ward_dire:RemoveModifierByName("modifier_invulnerable");

			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_GOODGUYS, "ping_location", { spawn_location = ward_dire:GetAbsOrigin() } )
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_BADGUYS, "ping_location", { spawn_location = ward_radiant:GetAbsOrigin() } )

			CustomGameEventManager:Send_ServerToAllClients( "emit_sound", {sound = "objective_lakes"} );
		elseif currentDay == 9 then
			tree_radiant:RemoveModifierByName("modifier_invulnerable");
			tree_dire:RemoveModifierByName("modifier_invulnerable");

			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_GOODGUYS, "ping_location", { spawn_location = tree_dire:GetAbsOrigin() } )
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_BADGUYS, "ping_location", { spawn_location = tree_radiant:GetAbsOrigin() } )

			CustomGameEventManager:Send_ServerToAllClients( "emit_sound", {sound = "objective_forest"} );
        elseif currentDay == 25 then
			FrostivusGameMode:SpawnRoshan()
			--GameRules:AddMinimapDebugPoint(1, roshan_radiant:GetCenter(), 255, 255, 255, 500, 3.0)
			--GameRules:AddMinimapDebugPointForTeam(1, roshan_radiant:GetCenter(), 255, 255, 255, 1000, 3.0, DOTA_TEAM_BADGUYS)
			--print(roshan_radiant:GetAbsOrigin())
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_GOODGUYS, "ping_location", { spawn_location = roshan_dire:GetAbsOrigin() } )
			CustomGameEventManager:Send_ServerToTeam(DOTA_TEAM_BADGUYS, "ping_location", { spawn_location = roshan_radiant:GetAbsOrigin() } )

			CustomGameEventManager:Send_ServerToAllClients( "emit_sound", {sound = "frostivus_awaits_you"} );
			--(nTeamID, hEntity, nXCoord, nYCoord, nEventType, nEventDuration)
        end
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function FrostivusGameMode:GiveGold()
	for playerID = 0, ( DOTA_MAX_TEAM_PLAYERS-1 ) do
		if PlayerResource:GetTeam( playerID ) == DOTA_TEAM_GOODGUYS and present_radiant ~= nil then
			PlayerResource:ModifyGold(playerID,2*currentDay,true,DOTA_ModifyGold_GameTick)
		elseif PlayerResource:GetTeam( playerID ) == DOTA_TEAM_BADGUYS and present_dire ~= nil then
			PlayerResource:ModifyGold(playerID,2*currentDay,true,DOTA_ModifyGold_GameTick)
		end
	end
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

function FrostivusGameMode:OnEntityHurt( event )
	--DeepPrintTable(event.entindex_killed)
	if present_dire ~= nil and EntIndexToHScript(event.entindex_killed) == present_dire then
		present_dire:GetAbilityByIndex(1):CastAbility();
	elseif present_radiant ~= nil and EntIndexToHScript(event.entindex_killed) == present_radiant then
		present_radiant:GetAbilityByIndex(1):CastAbility();
	end
end

function FrostivusGameMode:OnEntityKilled( event )
	--FrostivusGameMode:UpdateScoreboard();
	local attackerUnit = EntIndexToHScript( event.entindex_attacker or -1 )
	local killedUnit = EntIndexToHScript( event.entindex_killed )

	local playerID = nil;
	if attackerUnit:GetPlayerOwner() ~= nil then
		playerID = attackerUnit:GetPlayerOwner():GetPlayerID()
	end
	print(playerID);
	
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
		
	elseif killedUnit:GetUnitName() == "npc_dota_frostivus_present" then
		if playerID ~= nil then
			GameRules:SendCustomMessage("#presentKill", playerID, 0)
		else
			GameRules:SendCustomMessage("<font color='#40E0D0'> A present has been destroyed! It no longer provides its abilities. </font>", 0, 0)
		end
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			_G.present_radiant = nil;
			
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			_G.present_dire = nil;			
		end
		killedUnit:Destroy();
	elseif killedUnit:GetUnitName() == "npc_dota_frostivus_ward" then
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			-- spawn greevlings on radiant side
			_G.ward_radiant = nil;
			AddFOWViewer(DOTA_TEAM_BADGUYS, Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin(),2000,60*30,false);
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			-- spawn greevlings on dire side
			_G.ward_dire = nil;
			AddFOWViewer(DOTA_TEAM_GOODGUYS, Entities:FindByName( nil, "santa_spawn_radiant"):GetAbsOrigin(),2000,60*30,false);
		end
		if playerID ~= nil then
			GameRules:SendCustomMessage("#wardKill", playerID, 0)
		else
			GameRules:SendCustomMessage("<font color='#D8BFD8'> A ward has been destroyed! Vision is now granted over the center. </font>", 0, 0)
		end
		killedUnit:Destroy();

	elseif killedUnit:GetUnitName() == "npc_dota_frostivus_tree" then
		local baublesToDestroy;
		if killedUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
			-- spawn greevlings on radiant side
			baublesToDestroy = Entities:FindAllByName("dota_frostivus_bauble_radiant");
			
			_G.tree_radiant = nil;
		elseif killedUnit:GetTeam() == DOTA_TEAM_BADGUYS then
			-- spawn greevlings on dire side
			baublesToDestroy = Entities:FindAllByName("dota_frostivus_bauble_dire");
			
			_G.tree_dire = nil;
		end
		
		local timer = 0;
		for k,v in pairs(baublesToDestroy) do
			Timers:CreateTimer( timer , function()
				ParticleManager:CreateParticle("particles/econ/items/effigies/status_fx_effigies/frosty_base_statue_destruction_radiant.vpcf",PATTACH_ABSORIGIN,v);
				Timers:CreateTimer( 1 , function()
					v:Kill();
				end)
			end)
			timer = timer + 0.05;
		 end
		 
		Timers:CreateTimer( 1.25 , function()
			killedUnit:Destroy();
		end)

		if playerID ~= nil then
			GameRules:SendCustomMessage("#treeKill", playerID, 2)
		else
			GameRules:SendCustomMessage("<font color='#228B22'> A tree has been destroyed! Greevlings are now spawning at the center. </font>", 0, 0)
		end
	end
end

function FrostivusGameMode:EndGame( victoryTeam )
	if victoryTeam == DOTA_TEAM_GOODGUYS then
		GameRules:SetCustomVictoryMessage( "Team Snowleopard won!");
	else
		GameRules:SetCustomVictoryMessage( "Team Snowowl won!");
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
		
		ward_radiant:StartGestureWithPlaybackRate(ACT_DOTA_IDLE,0.8)
		ward_dire:StartGestureWithPlaybackRate(ACT_DOTA_IDLE,0.9)

		tree_radiant:AddNewModifier(ward_radiant, nil, "modifier_invulnerable", nil)
		tree_dire:AddNewModifier(ward_dire, nil, "modifier_invulnerable", nil)
		GameRules:SetRuneSpawnTime(COUNTDOWNTIMERVALUE)

		for nPlayerID = 0, ( DOTA_MAX_TEAM_PLAYERS - 1 ) do		
			if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS or PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_BADGUYS then		
				PlayerResource:GetPlayer(nPlayerID):GetAssignedHero():SetCustomDeathXP(0)		
			end		
		end

		CustomGameEventManager:Send_ServerToAllClients( "emit_sound", {sound = "objective_mountains"} );
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
    roshan_radiant = CreateUnitByName("npc_dota_creature_mini_roshan", point1, true, nil, nil, DOTA_TEAM_GOODGUYS)
    

    local point2 = Entities:FindByName( nil, "santa_spawn_dire"):GetAbsOrigin()
	roshan_dire = CreateUnitByName("npc_dota_creature_mini_roshan", point2, true, nil, nil, DOTA_TEAM_BADGUYS)
	
	roshan_radiant:SetForceAttackTarget(roshan_dire)
	roshan_dire:SetForceAttackTarget(roshan_radiant)
	
end
