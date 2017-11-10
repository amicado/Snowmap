"use strict";

(function()
{
    GameEvents.Subscribe( "end_screen", EndScreen );
    GameEvents.SendCustomGameEventToServer("endscreen_request_data", {});
})();

function EndScreen(data){
    $.Msg("Calling EndScreen");
    $.Msg(data);
}

