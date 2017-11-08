function Leave_Spawn(trigger)
    print (trigger.activator:GetOwner():GetPlayerID())
    --EmitAnnouncerSoundForPlayer("dsadowski_01.music.battle_01",trigger.activator:GetOwner():GetPlayerID());
    --trigger.caller:EmitSound("Courier.Spawn");
    --EmitAnnouncerSound("frostivus_awaits_you")
	--StartSoundEvent("frostivus_awaits_you",trigger.activator:GetOwner())
	--EmitSoundOn("frostivus_awaits_you",trigger.activator:GetOwner())
	EmitSoundOnClient("frostivus_awaits_you",trigger.activator:GetPlayerOwner());
	--EmitAnnouncerSoundForPlayer("frostivus_awaits_you",trigger.activator:GetPlayerOwner():GetPlayerID())
	--CustomGameEventManager:Send_ServerToAllClients( "emit_client_sound", {sound = "General.Coins"} )
	--EmitAnnouncerSound("announcer_announcer_roshan_fallen_dire")
end