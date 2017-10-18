"use strict";

function UpdateTimer( data )
{
	//$.Msg( "UpdateTimer: ", data );
	//var timerValue = Game.GetDOTATime( false, false );

	//var sec = Math.floor( timerValue % 60 );
	//var min = Math.floor( timerValue / 60 );

	//var timerText = "";
	//timerText += min;
	//timerText += ":";

	//if ( sec < 10 )
	//{
	//	timerText += "0";
	//}
	//timerText += sec;

	var timerText = "";
	timerText += data.timer_minute_10;
	timerText += data.timer_minute_01;
	timerText += ":";
	timerText += data.timer_second_10;
	timerText += data.timer_second_01;

	$( "#Timer" ).text = timerText;

	//$.Schedule( 0.1, UpdateTimer );
}


function AlertTimer( data )
{
    if(data.isTrue)
        $( "#Timer" ).AddClass( "timer_alert" );
    else
        $( "#Timer" ).RemoveClass( "timer_alert" );
}

function TimerOver(){
	$.GetContextPanel().AddClass( "timer_over" );
}
function StartTimer(){
	$.GetContextPanel().RemoveClass( "timer_over" );
}

function UpdateDay(data)
{
    var day = parseInt(data.day);
    if(day%10==1){
        $( "#Day" ).text = day+"st";
    }else if(day%10==2){
        $( "#Day" ).text = day+"nd";
    }else if(day%10==3){
        $( "#Day" ).text = day+"rd";
    }else{
        $( "#Day" ).text = day+"th";
	}
	
	TimerOver();
}

(function()
{
    GameEvents.Subscribe( "countdown", UpdateTimer );
    GameEvents.Subscribe( "timer_alert", AlertTimer );
	GameEvents.Subscribe( "update_day", UpdateDay );
	GameEvents.Subscribe( "start_timer", StartTimer );

})();

