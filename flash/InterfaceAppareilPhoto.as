﻿import flash.display.*;
import flash.events.*;
import com.greensock.easing.*;
import com.greensock.TweenMax;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.*;
import flash.geom.Rectangle;
	
//_________________________________________○○○--Variable instanciés
var taille:String = "0.1";
//var loader:Loader = new Loader();
//var url:URLRequest = new URLRequest("../exploit/img/photos/photo01.jpg");
//var image:MovieClip = new MovieClip();
var centreX:Number=-50;
var centreY:Number=-50;
var racine = root.parent.root;
var empreinte:BitmapData;
var monImageBrute:ByteArray;
var zoneTravail:Sprite = new Sprite();

	// constructor code
	//loader.load(url);
	//addChild(image);
	//image.addChild(loader);
	setChildIndex(ligne_cadrage,this.numChildren-1);
	var imgX:int=(stage.stageWidth-image.width)/2;
	var imgY:int=(stage.stageHeight-image.height)/2;
	trace(imgX);
	//image.y=98;
	//image.x=100;
	//image.scaleX=0.2;
	//image.scaleY=0.2;	

//---------------------------------------------○○○--Drag
function dragg(e:Event):void{
   	image.startDrag(false);
   	trace(image.y);
	trace(image.x);
}
image.addEventListener(MouseEvent.MOUSE_DOWN,dragg);

function noDragg(e:Event):void{
   image.stopDrag();
}
stage.addEventListener(MouseEvent.MOUSE_UP,noDragg);
<<<<<<< HEAD
//son declancheur //
	var son_declencheur:SoundChannel;
	var clack = new Sound();
	var adresseClack= new URLRequest("./son/declencheur.mp3");
	clack.load(adresseClack); 
=======

>>>>>>> finish_mardi
//---------------------------------------------○○○--Declencheur
function click_declencheur(e:Event):void{
	trace ("photo");	
	masque.gotoAndStop (2);
	//On désactive les autres éléments
	ligne_cadrage.visible = false;
	appareil.btn_zoom_plus.visible = false;
	appareil.btn_zoom_moins.visible = false;
	appareil.visible = false;
	declencheur.visible = false;
<<<<<<< HEAD
	son_declencheur = clack.play();
=======
	
>>>>>>> finish_mardi
	if (image.x>300&&image.x<350&&image.y>280&&image.y<330){
	MovieClip(racine).best_cadrage = 70;
	}
	else if (image.x>260&&image.x<390&&image.y>240&&image.y<370){
	MovieClip(racine).best_cadrage = 50;
	}
	else if (image.x>220&&image.x<430&&image.y>200&&image.y<410){
	MovieClip(racine).best_cadrage = 30;
	}
	else {
	MovieClip(racine).best_cadrage = 1;
	}

	
	//On fait le flash
	//addChild(flash_lumiere);
	
	//On crée l'image
	//var imagefinale;
	MovieClip(racine).maCapture1.draw(this,null,null,null,new Rectangle(186,137,837,630));
		image.removeEventListener(MouseEvent.MOUSE_DOWN,dragg);
	//affichage photo ///
		MovieClip(racine).adresse = new URLRequest("affichage_photo_01.swf");
     	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	 	//MovieClip(racine).reloader(e);
		MovieClip(racine).boutons = false;		
}
declencheur.addEventListener(MouseEvent.CLICK,click_declencheur);
/// scrore de base ///
MovieClip(racine).best_wb = 10;
MovieClip(racine).best_iso = 15;
MovieClip(racine).best_zoom = 5;
/// btn_soleil /////////////////////
var wb_orange = false;
var wb_bleu = false;
function click_wb(e:Event):void{
	trace ("changement_wb");	
	
	if(wb_orange==false){
		MovieClip(racine).best_wb = 15;		
		wb_orange = true;
		image.wb_soleil.alpha=0.7;
		wb_bleu = true;
		ecran.txt_wb.text = "NUAGEUX";
	}
	else if(wb_bleu==true){
		image.wb_soleil.alpha=0;
		MovieClip(racine).best_wb = 5;
		image.wb_soleil_bleu.alpha=0.7;
		wb_bleu = false;
		ecran.txt_wb.text = "SOLEIL";
	}
	else {
		wb_orange = false;		
		MovieClip(racine).best_wb = 10;
		image.wb_soleil.alpha= 0;	
		image.wb_soleil_bleu.alpha=0;
		trace ("wb_off");	
		ecran.txt_wb.text = "AUTO";
	}

}
appareil.btn_wb_soleil.buttonMode = true;
appareil.btn_wb_soleil.addEventListener(MouseEvent.CLICK,click_wb);
////////////////////////////////////////////////////////
/// btn_Iso ///////////////////
var iso01 = false;
var iso02 = false;
function click_iso(e:Event):void{
	trace ("iso changement");	
	
	if(iso01==false){
		iso01 = true;
		MovieClip(racine).best_iso = 10;
		image.grain.alpha=0.2;
		iso02 = true;
		ecran.txt_iso.text = "200";
	}
	else if(iso02==true){
		MovieClip(racine).best_iso = 5;
		image.grain.alpha=0.5;
		iso02 = false;
		ecran.txt_iso.text = "400";
	}
	else {
		iso01 = false;	
		image.grain.alpha=0;
		trace ("iso_off");	
		MovieClip(racine).best_iso = 15;
		ecran.txt_iso.text = "100";
	}	

}
appareil.btn_iso.buttonMode = true;
appareil.btn_iso.addEventListener(MouseEvent.CLICK,click_iso);
////////////////////////////////////////////////////////
//___________________________________________________○○○--Zoom
var zoom_photo=0;
function zoom(e:MouseEvent):void{
   //TweenMax.to(image,1,{x:(image.x-contour.x)/2, y:(image.y-contour.y)/2,ease:Sine.easeIn});
   TweenMax.to(image,0.2,{scaleX:taille, ease:Sine.easeOut});
   TweenMax.to(image,0.2,{scaleY:taille, ease:Sine.easeOut});
   zoom_photo=zoom_photo+1;
  	if(zoom_photo==1){
		MovieClip(racine).best_zoom = 5;
	}else if (zoom_photo==2){
		MovieClip(racine).best_zoom = 10;
		
	}else if (zoom_photo==3){
		MovieClip(racine).best_zoom = 15;
		
	}else if (zoom_photo==4){
		MovieClip(racine).best_zoom = 10;
		
	}else {
		 MovieClip(racine).best_zoom = 0;
	}
   trace(zoom_photo);
   trace(MovieClip(racine).best_zoom);
}
appareil.btn_zoom_plus.addEventListener(MouseEvent.MOUSE_DOWN, zoom);
function dezoom(e:MouseEvent):void{
 	  zoom_photo=0;
	  TweenMax.to(image,0.1,{scaleX:0.25, ease:Sine.easeOut});
   TweenMax.to(image,0.1,{scaleY:0.25, ease:Sine.easeOut});
   TweenMax.to(image,0.1,{x:543, y:312, ease:Sine.easeIn});
}
appareil.btn_zoom_moins.addEventListener(MouseEvent.MOUSE_DOWN, dezoom);