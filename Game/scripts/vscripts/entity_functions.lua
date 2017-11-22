function Leave_Spawn(trigger)
	--print("Leave_Spawn");
    --print (trigger.activator:GetOwner():GetPlayerID())
    --EmitAnnouncerSoundForPlayer("dsadowski_01.music.battle_01",trigger.activator:GetOwner():GetPlayerID());
    --trigger.caller:EmitSoundOnClient("spawn_trigger",trigger.activator:GetOwner());
    --EmitAnnouncerSound("frostivus_awaits_you")
	--StartSoundEvent("frostivus_awaits_you",trigger.activator:GetOwner())
	--EmitSoundOn("frostivus_awaits_you",trigger.activator:GetOwner())
	--EmitSoundOnClient("frostivus_awaits_you",trigger.activator:GetPlayerOwner());
	--EmitAnnouncerSoundForPlayer("frostivus_awaits_you",trigger.activator:GetPlayerOwner():GetPlayerID())
	--CustomGameEventManager:Send_ServerToAllClients( "emit_sound", {sound = ""} );
	CustomGameEventManager:Send_ServerToPlayer(trigger.activator:GetPlayerOwner(), "emit_sound", {sound = "spawn_trigger"} );
	--EmitAnnouncerSound("spawn_trigger")
end

function PresentAutoCast()
	if present_radiant ~= nil and present_radiant:IsNull() == false then
		present_radiant:GetAbilityByIndex(0):CastAbility();
	end

	if present_dire ~= nil and present_dire:IsNull() == false then
		present_dire:GetAbilityByIndex(0):CastAbility();
	end
end