function Trigger_Sound(trigger)
    print (trigger.activator:GetOwner():GetPlayerID())
    --EmitAnnouncerSoundForPlayer("dsadowski_01.music.battle_01",trigger.activator:GetOwner():GetPlayerID());
    --trigger.caller:EmitSound("Courier.Spawn");
    --EmitAnnouncerSound("frostivus_awaits_you")
	--StartSoundEvent("frostivus_awaits_you",trigger.activator:GetOwner())
	--EmitSoundOn("frostivus_awaits_you",trigger.activator:GetOwner())
	EmitSoundOnClient("frostivus_awaits_you",trigger.activator:GetPlayerOwner());
	--EmitAnnouncerSoundForPlayer("test",0)
	--CustomGameEventManager:Send_ServerToAllClients( "emit_client_sound", {sound = "General.Coins"} )
	--EmitAnnouncerSound("announcer_announcer_roshan_fallen_dire")
end