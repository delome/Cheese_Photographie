//////////////////////////
//niveau 1.2////////////////
//////////////////////////

//initialisation XML//////////////////////////////////////////////////////////
var adresseFichierXML:URLRequest = new URLRequest("xml/personnages.xml");
var conteneurXML:URLLoader = new URLLoader();
conteneurXML.load(adresseFichierXML);
var arboXML:XML;
var adresseFichier = ("perso/personnage_fille.swf");
conteneurXML.addEventListener(Event.COMPLETE,chargementXMLTermine);
conteneurXML.addEventListener(IOErrorEvent.IO_ERROR, onFileError);

var racine = root.parent.root;

derriere.x=MovieClip(racine).posFondX;
derriere.y=MovieClip(racine).posFondY;

function chargementXMLTermine(pEvt:Event):void  {
 	arboXML = new XML(conteneurXML.data);  
   	trace ("Chargement XML OK");
	var sex = MovieClip(racine).SaveXML.Personnage[0].Type[0];
	trace (sex);
	if (sex=="F"){
		adresseFichier = arboXML.personnage[0].nom; 
		   trace (sex+"fémi");
	}else{
		adresseFichier = arboXML.personnage[1].nom; 
		   trace (sex+"maki");
		  
		
	}
	trace (adresseFichier);
	charger_perso();
}
function onFileError(evt:IOErrorEvent){
	trace(this, evt);
	 trace ("Chargement XML pas Ok");
}
/////////////////////////////////////////////////////////////
//Function niveau ///////////////////////////
/////////////////////////////////////////////////////////////
function niveau_suivant(e) {
	if (MovieClip(player.content).player.hit_box.hitTestObject(derriere.suiv)) {						
		derriere.suiv.y = 1194;
		MovieClip(racine).chargement.y=0;
		MovieClip(racine).adresse = new URLRequest("niveau01.3.swf");
     	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);  	
	 	MovieClip(racine).reloader(e);				
	}
	else{
		
		}
	if(MovieClip(player.content).player.zone_i.hitTestObject(derriere.btn_prise_1)) {
		  TweenLite.to(derriere.btn_prise_1, 0.3, {scaleX:2, scaleY:2, alpha:0.7, ease:Bounce.easeOut});
		  derriere.btn_prise_1.buttonMode = true;		
	}
	else {
		 TweenLite.to(derriere.btn_prise_1, 0.3, {scaleX:1, scaleY:1, alpha:0.4, ease:Bounce.easeOut});
		 derriere.btn_prise_1.buttonMode = false;		 
	}	
}
////////////////////////////
//Personnage ///////////////
///////////////////////////
var player:Loader = new Loader();
function charger_perso() {		
	var adressePerso:URLRequest = new URLRequest(adresseFichier);
	player.load(adressePerso);
	addChild(player);
	//placement du personnage //
	player.x=MovieClip(racine).posPlayerX;
	player.y=MovieClip(racine).posPlayerY;
	setChildIndex(devant,this.numChildren-1);	
	stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);//fonction dans main
	stage.addEventListener(Event.ENTER_FRAME, niveau_suivant);//evenements specifique au niveau
}

derriere.masque_boutique.addEventListener(Event.ENTER_FRAME, interaction_boutique);
derriere.masque_grille.addEventListener(Event.ENTER_FRAME, interaction_grille);
var contactBoutique=false;
var contactGrille=true;

function ouverture_portes(e){
		derriere.portes.gotoAndPlay("ouverture");
}
function fermeture_portes(e){
	derriere.portes.gotoAndPlay("fermeture");
}
function ouverture_grille(e){
	derriere.grille.gotoAndPlay("ouverture");
}
function fermeture_grille(e){
	derriere.grille.gotoAndPlay("fermeture");
}
function interaction_boutique (e){
	if (MovieClip(player.content).player.hit_box.hitTestObject(derriere.masque_boutique)) {
		derriere.masque_boutique.buttonMode = true;
		derriere.masque_boutique.addEventListener(MouseEvent.CLICK,boutique);
		if(contactBoutique==false){
			ouverture_portes(e);
			contactBoutique=true;
		}
	}else{
		if(contactBoutique==true){
			derriere.masque_boutique.buttonMode = false;
			fermeture_portes(e);
			contactBoutique=false;
			derriere.grille.gotoAndStop("ferme");
		}
	}
}
function interaction_grille (e){
	contactGrille==false;
	if (MovieClip(player.content).player.hit_box.hitTestObject(derriere.masque_grille)) {
		derriere.masque_grille.buttonMode = true;
		derriere.masque_grille.addEventListener(MouseEvent.CLICK,niveau011);
		if(contactGrille==false){
			ouverture_grille(e);
			contactGrille=true;
		}
	}else{
		if(contactGrille==true){
			derriere.masque_grille.buttonMode = false;
			fermeture_grille(e);
			contactGrille=false;
		}
	}
}
//Fonction des niveaux !!
function boutique(e) {
	stage.removeEventListener(Event.ENTER_FRAME, Deplacement_fond);//fonction dans main
	stage.removeEventListener(Event.ENTER_FRAME, niveau_suivant);//evenements specifique au niveau
	MovieClip(racine).boutons = false;
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).adresse = new URLRequest("boutique.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	MovieClip(racine).reloader(e);
}
function niveau011(e) {
	stage.removeEventListener(Event.ENTER_FRAME, Deplacement_fond);//fonction dans main
	stage.removeEventListener(Event.ENTER_FRAME, niveau_suivant);//evenements specifique au niveau
	MovieClip(racine).boutons = true;
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	MovieClip(racine).reloader(e);
	MovieClip(racine).posFondX=-2610;				
	MovieClip(racine).posFondY=-145.85;
	MovieClip(racine).posDevantX=-2600;
	MovieClip(racine).posDevantY=-144.65;
	MovieClip(racine).posPlayerX=500;
	MovieClip(racine).posPlayerY=391;
}


