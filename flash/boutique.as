stop();
var racine = root.parent.root;

bulle.alpha = 0;

txt_pupitre.text = MovieClip(racine).replace(MovieClip(racine).DialoguesXML.PerfectPhoto.Comptoir,'\n','');
bulle.txt_bulle.text = MovieClip(racine).DialoguesXML.PerfectPhoto.Bulle;
caisse.buttonMode = true;
retour.buttonMode = true;

stage.addEventListener(KeyboardEvent.KEY_DOWN,deplacement);
caisse.addEventListener(MouseEvent.CLICK,anim_caisse);
retour.addEventListener(MouseEvent.CLICK,niveau012);
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
	bulle.alpha = 1;
}

function niveau012(e) {
	MovieClip(racine).boutons = true;
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	MovieClip(racine).reloader(e);
	MovieClip(racine).posFondX=99.55;				
	MovieClip(racine).posFondY=300.75;
	MovieClip(racine).posPlayerX=450;
	MovieClip(racine).posPlayerY=360;
}