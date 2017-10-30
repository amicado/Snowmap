function Trigger_Sound(trigger)
    print (trigger.activator:GetOwner():GetPlayerID())
    --EmitAnnouncerSoundForPlayer("dsadowski_01.music.battle_01",trigger.activator:GetOwner():GetPlayerID());
    EmitGlobalSound("frostivus_awaits_you");
    EmitAnnouncerSound("frostivus_awaits_you")
    StartSoundEvent("frostivus_awaits_you",trigger.activator:GetOwner())
end