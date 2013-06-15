//niveau 1
stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);
stage.addEventListener(Event.ENTER_FRAME, niveau_suivant);
//zone_b.addEventListener(Event.ENTER_FRAME, circleHit);

//Personnage //////////////////////////////////////
var player:Loader = new Loader();
var adressePerso:URLRequest = new URLRequest("perso/personnage_fille.swf");
player.load(adressePerso);
addChild(player);
player.y=391;
player.x=475;
setChildIndex(devant,this.numChildren-1);

//////////////////////////////////
function niveau_suivant(e) {
	if (MovieClip(player.content).player.hit_box.hitTestObject(derrier.suiv)) {					
		/*MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
	 	MovieClip(racine).boutons = true;		
		removeChild(chargeur);*/		
		derrier.suiv.y = 1194;
		MovieClip(racine).chargement.y=0;
		MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
     	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	 	MovieClip(racine).reloader(e);				
	}
	else{
		
		}
	if(MovieClip(player.content).player.zone_i.hitTestObject(derrier.btn_prise_1)) {
		  TweenLite.to(derrier.btn_prise_1, 0.3, {scaleX:2, scaleY:2, alpha:0.7, ease:Bounce.easeOut});
		  derrier.btn_prise_1.buttonMode = true;		  
	}
	else {
		 TweenLite.to(derrier.btn_prise_1, 0.3, {scaleX:1, scaleY:1, alpha:0.4, ease:Bounce.easeOut});
		 derrier.btn_prise_1.buttonMode = false;		 
	}
	
}
