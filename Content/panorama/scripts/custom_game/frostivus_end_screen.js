"use strict";
var radiantCounter = 0;
var direCounter = 0;
(function()
{
    GameEvents.Subscribe( "end_screen", EndScreen );
    GameEvents.SendCustomGameEventToServer("endscreen_request_data", {});
})();

function EndScreen(data){
    $.Msg(data);
    if(data.key == "gameData"){
        var winner = data.table.winner;
        if(winner == 2)
            $( "#GoodGuyName" ).AddClass( "TeamWon" );
        else
            $( "#BadGuyName" ).AddClass( "TeamWon" );
    }else{
        var kills = data.table.kills;
        var deaths = data.table.deaths;
        var assists = data.table.assists;
        var KDA = deaths == 0? kills+deaths:(kills+assists)/deaths;
        //var text = data.table.name+" as "+data.table.heroname+": "+kills+"/"+deaths+"/"+assists+" KDA: "+KDA;

        //DOTA_TEAM_GOODGUYS = 2
        //DOTA_TEAM_BADGUYS	= 3
        var team = data.table.team;

       
  
        if(team == 2){
            $.Msg("Calling EndScreen");
            $("#GoodGuy"+radiantCounter).GetChild(0).heroname = data.table.heroname;
            $("#GoodGuy"+radiantCounter).GetChild(1).text = data.table.name;
            $("#GoodGuy"+radiantCounter).GetChild(2).text = " "+kills+"/"+deaths+"/"+assists;
            $("#GoodGuy"+radiantCounter).GetChild(3).steamid = data.table.steamid;

            //$( "#GoodGuy"+radiantCounter ).text = text;
            radiantCounter++;
        }else if (team == 3){
            $("#BadGuy"+direCounter).GetChild(0).heroname = data.table.heroname;
            $("#BadGuy"+direCounter).GetChild(1).text = data.table.name;
            $("#BadGuy"+direCounter).GetChild(2).text = " "+kills+"/"+deaths+"/"+assists;
            $("#BadGuy"+direCounter).GetChild(3).steamid = data.table.steamid;

            //$( "#GoodGuy"+radiantCounter ).text = text;
            direCounter++;
        }
        
        
    }
}

