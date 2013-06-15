//niveau 1
stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);
stage.addEventListener(Event.ENTER_FRAME, niveau_suivant);
//zone_b.addEventListener(Event.ENTER_FRAME, circleHit);

//Fonction des niveaux !!
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
function niveau_suivant(e) {
	if (player.hitTestObject(derrier.suiv)) {					
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
}
