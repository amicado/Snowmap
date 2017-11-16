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

        var winSource = "file://{images}/custom_game/endscreen/gotitem.png";
        var loseSource = "file://{images}/custom_game/endscreen/gotitemnot.png";

        if(data.table.tree_radiant == 1)
            $("#BadGuysTree").SetImage(winSource);
        else
            $("#BadGuysTree").SetImage(loseSource);

        if(data.table.present_radiant == 1)
            $("#BadGuysPresent").SetImage(winSource);
        else
            $("#BadGuysPresent").SetImage(loseSource);

        if(data.table.ward_radiant == 1)
            $("#BadGuysWard").SetImage(winSource);
        else
            $("#BadGuysWard").SetImage(loseSource);

        if(data.table.tree_dire == 1)
            $("#GoodGuysTree").SetImage(winSource);
        else 
            $("#GoodGuysTree").SetImage(loseSource);
    
        if(data.table.present_dire == 1)
            $("#GoodGuysPresent").SetImage(winSource);
        else
            $("#GoodGuysPresent").SetImage(loseSource);

        if(data.table.ward_dire == 1)
            $("#GoodGuysWard").SetImage(winSource);
        else
            $("#GoodGuysWard").SetImage(loseSource);

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
            $("#GoodGuy"+radiantCounter).GetChild(1).steamid = data.table.steamid;
            $("#GoodGuy"+radiantCounter).GetChild(2).text = " "+kills+"/"+deaths+"/"+assists;

            //$( "#GoodGuy"+radiantCounter ).text = text;
            radiantCounter++;
        }else if (team == 3){
            $("#BadGuy"+direCounter).GetChild(0).heroname = data.table.heroname;
            $("#BadGuy"+direCounter).GetChild(1).steamid = data.table.steamid;
            $("#BadGuy"+direCounter).GetChild(2).text = " "+kills+"/"+deaths+"/"+assists;

            //$( "#GoodGuy"+radiantCounter ).text = text;
            direCounter++;
        }
        
        
    }
}

