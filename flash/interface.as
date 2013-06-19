import com.greensock.*;
import com.greensock.easing.*;
//////////////////////////////////////////////////////////////////////////////////
//initialisation XML//////////////////////////////////////////////////////////////
	var adresseSaveXML:URLRequest = new URLRequest("xml/save.xml");
	var conteneurSaveXML:URLLoader = new URLLoader();
	conteneurSaveXML.load(adresseSaveXML);
	var SaveXML:XML;
	conteneurSaveXML.addEventListener(Event.COMPLETE,chargementSaveTermine);
	conteneurSaveXML.addEventListener(IOErrorEvent.IO_ERROR, onFileSaveError);	
//////////////////////////////////////////////////////////////////////////////////
//initialisation XML DIALOGUES//////////////////////////////////////////////////////////////
	var adresseDialoguesXML:URLRequest = new URLRequest("xml/dialogues.xml");
	var conteneurDialoguesXML:URLLoader = new URLLoader();
	conteneurDialoguesXML.load(adresseDialoguesXML);
	var DialoguesXML:XML;
	conteneurDialoguesXML.addEventListener(Event.COMPLETE,chargementDialoguesTermine);
	conteneurDialoguesXML.addEventListener(IOErrorEvent.IO_ERROR, onFileSaveError);
//////////////////////////////////////////////////////////////////////////////////
//initialisation variable niveau//////////////////////////////////////////////////
	var posFondX =810.55;
	var posFondY =300.75;
	var posDevantX =0;
	var posDevantY =0;
	var posPlayerX =450;
	var posPlayerY =360;

	
//initialisation variable photo//////////////////////////////////////////////////
var maCapture1:BitmapData = new BitmapData(1024,768);
var photoOk = false;
var best_iso = 0;
var best_wb = 0;
var best_zoom = 0;
var best_cadrage = 0;


//////////////////////////////////////////////////////////////////////////////////
//thème de musical////////////////////////////////////////////////////////////////
	var theme1:SoundChannel;
	var rock = new Sound();
	var adresseThemeRock = new URLRequest("./son/music_rock.mp3");
	rock.load(adresseThemeRock); 
	
//////////////////////////////////////////////////////////////////////////////////
////Chargement de la sauvegarde /////////////////////////////////////////////////
function chargementSaveTermine(pEvt:Event):void  {
		SaveXML = new XML(conteneurSaveXML.data);  
		trace ("Chargement XML OK");
		
	}
	function chargementDialoguesTermine(pEvt:Event):void  {
	DialoguesXML = new XML(conteneurDialoguesXML.data);  
	trace ("Chargement XML OK");
	
}
	function onFileSaveError(evt:IOErrorEvent){
		trace(this, evt);
		trace ("Chargement XML pas Ok");
}
//

TweenLite.to(inventaire, 1, {alpha:0});
inventaire.visible = false;
////////////////////////////////////////////////////////////////
// loader Accueil// // // // // // // // // // // // // // // // // // 
var chargeur:Loader = new Loader();
var adresse:URLRequest = new URLRequest("accueil.swf");
var boutons = false;
chargeur.load(adresse);
addChild(chargeur);
setChildIndex(chargement,this.numChildren-1);
//Nettoyage et rechargement/////////////////////////////////////////
function reloader (evt){
	chargement.y=0;
	removeChild(chargeur);
	chargeur.unload();	
	chargeur.load(adresse);
	addChild(chargeur);
	setChildIndex(chargement,this.numChildren-1);
}
////////////////////////////////////////////////////////////////////////
//Preloader // // // // // // // // // // // // // // // // // // 
chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE,chargementTermine)
function chargementTermine (evt:Event) {	
	trace("Chargement terminé")	
	TweenLite.to(chargement, 1, {y:-800});
	if(boutons==true) {
	//déffinition des plans
		btn_menu.visible = true;
		zone_menu1.visible = true;
		btn_sac.visible = true;
		setChildIndex(btn_menu,this.numChildren-1);
		setChildIndex(zone_menu1, this.numChildren-1);
		setChildIndex(btn_sac, this.numChildren-1);
		setChildIndex(chargement,this.numChildren-1);
		}
	else {
	//déffinition des plans
		btn_menu.visible = false;
		zone_menu1.visible = false;
		btn_sac.visible = false;
		}
	
	//remise à zero du chargeur//
	 pct=0;
	 total = 0;
	 loaded = 0;
		
};
chargeur.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,chargementEnCours)
var pct=0;
var total = 0;
var loaded = 0;
function chargementEnCours (evt:ProgressEvent) {
	trace("encours");		
    pct = loaded/total*100; 
	pct = Math.round(pct);
	total = evt.bytesTotal;
	loaded = evt.bytesLoaded;
	trace(pct);
	chargement.gotoAndStop (pct);
};
// // // // // // // // // // // // // // // // // // // // // 
// bouton Menu création  // // // // // // // // // // // // 
btn_menu.buttonMode=true;
zone_menu1.retour.buttonMode=true;
//animation
btn_menu.addEventListener(MouseEvent.MOUSE_OVER,anim_btn_menu);
btn_menu.addEventListener(MouseEvent.MOUSE_OUT,anim_btn_menu_retour);
function anim_btn_menu(evt:MouseEvent) {
     TweenLite.to(btn_menu, 1, {scaleX:1.1, scaleY:1.1, alpha:1, ease:Bounce.easeOut});
   }
function anim_btn_menu_retour(evt:MouseEvent) {
     TweenLite.to(btn_menu, 1, {scaleX:0.9, scaleY:0.9, alpha:0.7, ease:Bounce.easeOut});
   }
//au Clique ///////
var menu = false;
btn_menu.addEventListener(MouseEvent.CLICK,ouverture_menu);
zone_menu1.retour.addEventListener(MouseEvent.CLICK,ouverture_menu);
function ouverture_menu(evt:MouseEvent) {
	if (menu==false){		  		
		TweenLite.to(zone_menu1, 1, {x:519, y:381, alpha:1, ease:Bounce.easeOut});
		menu=true;
	}
	else  {
		TweenLite.to(zone_menu1, 1, {x:519, y:-290, alpha:0});
		menu=false;
	}
   }   
 // bouton quitter ////////////
zone_menu1.btn_quitter.buttonMode=true;
zone_menu1.btn_quitter.addEventListener(MouseEvent.CLICK,retour_accueil_i);
function retour_accueil_i(evt:MouseEvent) {
  adresse = new URLRequest("accueil.swf");
  chargeur.load(adresse);
  chargement.y=0;
  boutons = false;	
  TweenLite.to(zone_menu1, 1, {x:519, y:-290, alpha:0});
  menu=false;
  reloader (evt);
   }
// // // // // // // // // // // // // // // // // // // // // 

// bouton Sac création  // // // // // // // // // // // // 
btn_sac.buttonMode=true;
//animation
btn_sac.addEventListener(MouseEvent.MOUSE_OVER,anim_btn_sac);
btn_sac.addEventListener(MouseEvent.MOUSE_OUT,anim_btn_sac_retour);
function anim_btn_sac(evt:MouseEvent) {
     TweenLite.to(btn_sac, 1, {scaleX:1.1, scaleY:1.1, alpha:1, ease:Bounce.easeOut});
	 btn_sac.gotoAndStop ("ouvert");
   }
function anim_btn_sac_retour(evt:MouseEvent) {
     TweenLite.to(btn_sac, 1, {scaleX:0.9, scaleY:0.9, alpha:0.7, ease:Bounce.easeOut});
	 btn_sac.gotoAndStop ("fermer");
   }
//au Clique
var menuSac = false;
btn_sac.addEventListener(MouseEvent.CLICK,ouverture_sac);
function ouverture_sac(evt:MouseEvent) {	
	inventaire.visible = true;
	TweenLite.to(inventaire, 1, {alpha:1});
	setChildIndex(inventaire,this.numChildren-1);
   }   
inventaire.btn_fermer.buttonMode = true;
inventaire.btn_fermer.addEventListener(MouseEvent.CLICK,fermeture_sac);
function fermeture_sac(evt:MouseEvent) {	
	inventaire.visible = false;
	TweenLite.to(inventaire, 1, {alpha:0});
	setChildIndex(inventaire,this.numChildren-1);
   } 
/// drag and drop   
    inventaire.objectif.addEventListener(MouseEvent.MOUSE_DOWN,deplacerCarte);
    inventaire.objectif.addEventListener(MouseEvent.MOUSE_UP,relacherCarte);
   function deplacerCarte(evt:MouseEvent) {
        inventaire.objectif.startDrag(false);
   }
   function relacherCarte(evt:MouseEvent) {
        inventaire.objectif.stopDrag();
   }
// // // // // // // // // // // // // // // // // // // // // 
//colision du drag and drop ///



///////////////////////////////////
///////////////////////////////////


///////////////////////////////////////////
///////////curseur souris//////////////
/////////////////////////////////////////
/*
var souris:Loader = new Loader();
var adresse_souris:URLRequest = new URLRequest("pointeur_main.swf");
souris.load(adresse_souris);
Mouse.hide();
addChild(souris);
 
function suivreMouvementSouris(e:MouseEvent){
//Les coordonnées du clip curseur_souris sont celles de la souris
souris.x= mouseX;
souris.y= mouseY;
}


 
//On ajoute un écouteur d'évènement (de souris)
stage.addEventListener(MouseEvent.MOUSE_MOVE, suivreMouvementSouris);*/

//////////////////////////////////////////////////////////////////////////////////
function replace(str, find, replace) {
	return str.split(find).join(replace);
}
