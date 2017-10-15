function UpdateNotification(data)
{
    if(data.day == 1){
        SetNotification("#frostivus_game_objective_mountain");
    }else if(data.day == 9){
        SetNotification("#frostivus_game_objective_forest");
    }else if(data.day == 17){
        SetNotification("#frostivus_game_objective_lake");
    }else if(data.day == 25){
        SetNotification("#frostivus_game_rosha_claus");  
    }
    
}

function SetNotification(text){
    $( "#Notification" ).text = $.Localize(text);
    $.Schedule( 3, ClearNotification );
}
function ClearNotification(){
    $( "#Notification" ).text = "";
}

(function()
{
    GameEvents.Subscribe( "update_notification", UpdateNotification );
})();