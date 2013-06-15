import com.greensock.*;
import com.greensock.easing.*;

//loader // // // // // // // // // // // // // // // // // // 
var chargeur:Loader = new Loader();
var adresse:URLRequest = new URLRequest("accueil.swf");
var boutons = false;
chargeur.load(adresse);
addChild(chargeur);
setChildIndex(chargement,this.numChildren-1);
//Netoyage et chargement/////////////////////////////////////////
function reloader (evt){
	chargement.y=0;
	removeChild(chargeur);
	chargeur.load(adresse);	
	addChild(chargeur);
	setChildIndex(chargement,this.numChildren-1);
}
////
//Preloader // // // // // // // // // // // // // // // // // // 
chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE,chargementTermine)
function chargementTermine (evt:Event) {	
	trace("Chargement terminé")	
	TweenLite.to(chargement, 1, {y:-800});
	if(boutons==true) {
	//déffinition des plans
		setChildIndex(btn_menu,this.numChildren-1);
		setChildIndex(zone_menu1, this.numChildren-1);
		setChildIndex(btn_sac, this.numChildren-1);
		setChildIndex(chargement,this.numChildren-1);
		}
};
chargeur.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,chargementEnCours)
function chargementEnCours (evt:ProgressEvent) {
	trace("encours");	
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
//au Clique
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
btn_sac.addEventListener(MouseEvent.CLICK,ouverture_menu);
function ouverture_sac(evt:MouseEvent) {	
   }   
// // // // // // // // // // // // // // // // // // // // // 
   



