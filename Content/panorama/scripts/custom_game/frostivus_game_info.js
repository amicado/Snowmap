function EmitSound( data )
{
    $.Msg("Emit Sound");
    Game.EmitSound(data.sound);
}

(function()
{
    GameEvents.Subscribe( "emit_sound", EmitSound );

})();

