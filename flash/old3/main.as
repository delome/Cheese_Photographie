// add these import statements
import com.greensock.*;
import com.greensock.easing.*;
import flash.ui.Keyboard;
import flash.events.Event;
import flash.events.KeyboardEvent;
var vitesse:Number = 10;
var musique = false;
var racine = root.parent.root
var piste1:SoundChannel;
 
// add the event listeners
player.addEventListener(Event.ENTER_FRAME, update);
stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
 
// this array holds references to all the keys
var keys:Array = [];
var posx = player.x;
var posy = player.y;

var mjks = new Sound();
var adresseFichierSon = new URLRequest("./son/music_s1.mp3");
mjks.load(adresseFichierSon);
   
 
// the event listeners
function update(e:Event):void
{
	if (keys[Keyboard.RIGHT])
     {
	 			
		 if (keys[Keyboard.LEFT])
		{
			player.x += 1;
			if (musique==false)
			{	
			trace ("yeah");				
			musique=true;
			 piste1 = mjks.play();
			}
		}
         	player.x += vitesse;
			MovieClip(player.content).player.gotoAndStop("marche");
			player.scaleX = 1;			
     }
 
	if (keys[Keyboard.LEFT])
	{
		player.x -= vitesse;
		MovieClip(player.content).player.gotoAndStop("marche");
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
	MovieClip(player.content).player.gotoAndStop("stop");
	musique=false;
	piste1.stop();
}


//Fonction des niveaux !!
function Deplacement_fond(event:Event){
	
	if (MovieClip(player.content).player.hit_box.hitTestObject(derrier.col1)) {
			player.x += vitesse;
	}
	else if (MovieClip(player.content).player.hit_box.hitTestObject(derrier.col2)) {
			
	}
	else{
		if (MovieClip(player.content).player.hit_box.hitTestObject(zone_a)) {
			derrier.x -= vitesse;
			
			devant.x -= vitesse;
			player.x -= vitesse;
		};
	   if (MovieClip(player.content).player.hit_box.hitTestObject(zone_b)) {
			derrier.x += vitesse;
			
			devant.x += vitesse;
			player.x += vitesse;
	   };
	}
}











