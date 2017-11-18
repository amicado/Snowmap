var days = [1,9,17,25]; //present, tree, ward, roshan
var objectives = ["present","tree","ward","roshan"];
function UpdateNotification(data)
{
    //$.Msg( "UpdateNotification: ", data);
    var newDay = data.day;
    var newObjective = "";
    var event = "";
    for(var i = 0; i<days.length; i++){
        if(days[i+1] == null){ //its roshan
            newObjective = objectives[i];
            event = " arrived";
            break;
        }else if(newDay == days[i]){ //its some exact date
            newObjective = objectives[i];
            event = " available";
            break;
        }else if(newDay > days[i] && newDay < days[i+1]){
            newObjective = objectives[i+1];
            var dayDiff = days[i+1]-newDay;
            event = " in "+dayDiff+(dayDiff==1?" day":" days");
            break;
        }
    }
    SetNotification(newDay, newObjective, event);
    
}

function SetNotification(day, newObjective, event){
    $( "#NotificationDay" ).text = "Day "+day;
    $( "#TextImage").SetImage("file://{images}/custom_game/endscreen/"+newObjective+".png");
    $( "#NotificationText" ).text = $.Localize(event);

    $.GetContextPanel().AddClass( "NotificationShow" );
        
    $.Schedule( 3, ClearNotification );
}
function ClearNotification(){
    $.GetContextPanel().RemoveClass( "NotificationShow" );
}

function PingLocation(msg){
    $.Msg( "PingLocation: ", msg );
    GameUI.PingMinimapAtLocation( msg.spawn_location );
}

(function()
{
    GameEvents.Subscribe( "update_notification", UpdateNotification );
    GameEvents.Subscribe( "ping_location", PingLocation );
})();