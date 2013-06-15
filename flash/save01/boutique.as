stop();
stage.addEventListener(KeyboardEvent.KEY_DOWN,deplacement);
caisse.addEventListener(MouseEvent.CLICK,anim_caisse);
function deplacement (evt:KeyboardEvent):void
{
	switch (evt.keyCode)
	{
		case Keyboard.LEFT:
			gotoAndStop("base");
			break;
		case Keyboard.RIGHT:
			gotoAndStop("parler");
			break;
		case Keyboard.UP:
			gotoAndStop("pointer");
			break;
		case Keyboard.DOWN:
			gotoAndStop("base");
			caisse.gotoAndStop("caisse");
			break;
		default:gotoAndStop("base");
	}
}
function anim_caisse(event){
	gotoAndStop("pointer");
	
}