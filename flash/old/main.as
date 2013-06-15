// add these import statements
import flash.ui.Keyboard;
import flash.events.Event;
import flash.events.KeyboardEvent;
var vitesse:Number = 10;
 
// add the event listeners
player.addEventListener(Event.ENTER_FRAME, update);
stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
 
// this array holds references to all the keys
var keys:Array = [];
var posx = player.x;
var posy = player.y;
 
// the event listeners
function update(e:Event):void
{
	if (keys[Keyboard.RIGHT])
     {		
         	player.x += vitesse;
			player.gotoAndStop("marche");
			player.scaleX = 1;
     }
 
	if (keys[Keyboard.LEFT])
	{
		player.x -= vitesse;
		player.gotoAndStop("marche");
		player.scaleX = -1;
	}
	/*if (keys[Keyboard.UP]) 
	{
		player.y -= 10;
	}
	if (keys[Keyboard.DOWN])
	{
		player.y += 10;
	}*/
}
 
function onKeyDown(e:KeyboardEvent):void
{
	keys[e.keyCode] = true;
}
 
function onKeyUp(e:KeyboardEvent):void
{
	keys[e.keyCode] = false;
	player.gotoAndStop("stop");
}


stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);
//zone_b.addEventListener(Event.ENTER_FRAME, circleHit);


function Deplacement_fond(event:Event){
	
if (player.hitTestObject(derrier.col1)) {
		player.x += vitesse;
}
else if (player.hitTestObject(derrier.col2)) {
		
}
else{
	if (player.hitTestObject(zone_a)) {
    	derrier.x -= vitesse;
		devant.x -= vitesse;
		player.x -= vitesse;
  	};
   if (player.hitTestObject(zone_b)) {
    	derrier.x += vitesse;
		devant.x += vitesse;
		player.x += vitesse;
   };
}

}







