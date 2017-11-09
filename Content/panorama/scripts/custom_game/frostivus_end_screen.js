"use strict";

(function()
{
    $.Msg("Subscribing for Endscreen");
    if ( ScoreboardUpdater_InitializeScoreboard === null ) { $.Msg( "WARNING: This file requires shared_scoreboard_updater.js to be included." ); }
    var scoreboardConfig =
	{
		"screenXmlName" : "file://{resources}/layout/custom_game/frostivus_end_screen.xml"
	};
	GameEvents.Subscribe( "end_screen", EndScreen );
})();

function EndScreen(){
    $.Msg("JS for end screen is called");
}

