//niveau 1

stop();
derrier.masque_boutique.buttonMode = true;
derrier.masque_boutique.addEventListener(MouseEvent.MOUSE_OVER,ouverture_portes);
derrier.masque_boutique.addEventListener(MouseEvent.MOUSE_OUT,fermeture_portes);
function ouverture_portes(event){
	derrier.portes.gotoAndPlay("ouverture");
}
function fermeture_portes(event){
	derrier.portes.gotoAndPlay("fermeture");
}

stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);

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


