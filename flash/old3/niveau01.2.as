//niveau 1
stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);

//Personnage //////////////////////////////////////
var player:Loader = new Loader();
var adressePerso:URLRequest = new URLRequest("perso/personnage_fille.swf");
player.load(adressePerso);
addChild(player);
player.y=351;
player.x=500;
setChildIndex(devant,this.numChildren-1);

derrier.masque_boutique.addEventListener(Event.ENTER_FRAME, interaction_boutique);

var contact=false;

function ouverture_portes(e){
		derrier.portes.gotoAndPlay("ouverture");
}
function fermeture_portes(e){
	derrier.portes.gotoAndPlay("fermeture");
}
function interaction_boutique (e){
	if (MovieClip(player.content).player.hit_box.hitTestObject(derrier.masque_boutique)) {
		derrier.masque_boutique.buttonMode = true;
		derrier.masque_boutique.addEventListener(MouseEvent.CLICK,boutique);
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

//Fonction des niveaux !!
function boutique(e) {
	MovieClip(racine).boutons = false;
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).adresse = new URLRequest("boutique.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	MovieClip(racine).reloader(e);
}


