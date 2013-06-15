//niveau 1

stop();

stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);

var contact=false;
derrier.masque_boutique.addEventListener(Event.ENTER_FRAME, interaction_boutique);

function ouverture_portes(e){
		derrier.portes.gotoAndPlay("ouverture");
}
function fermeture_portes(e){
	derrier.portes.gotoAndPlay("fermeture");
}
function interaction_boutique (e){
	if (player.hitTestObject(derrier.masque_boutique)) {
		derrier.masque_boutique.buttonMode = true;
		if(contact==false){
			ouverture_portes(e);
			contact=true;
		}
	}else{
		if(contact==true){
			derrier.masque_boutique.buttonMode = false;
			fermeture_portes(e);
			contact=false;
		}
	}
}





