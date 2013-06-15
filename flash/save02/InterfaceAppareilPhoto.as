import com.greensock.*;
import com.greensock.easing.*;

import flash.display.*;
import flash.events.*;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.*;
	
//_________________________________________○○○--Variable instanciés
var taille:String = "0.05";
var loader:Loader = new Loader();
var url:URLRequest = new URLRequest("../exploit/img/photos/IMG_3198.jpg");
var image:MovieClip = new MovieClip();
var centreX:Number=-50;
var centreY:Number=-50;

var empreinte:BitmapData;
var monImageBrute:ByteArray;
var zoneTravail:Sprite = new Sprite();

InterfaceAppareilPhoto();

function InterfaceAppareilPhoto() {
	// constructor code
	loader.load(url);
	addChild(image);
	image.addChild(loader);
	setChildIndex(ligne_cadrage,this.numChildren-1);
	var imgX:int=(stage.stageWidth-image.width)/2;
	var imgY:int=(stage.stageHeight-image.height)/2;
	trace(imgX);
	image.y=98;
	image.x=100;
	image.scaleX=0.18;
	image.scaleY=0.18;
	
}

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

//---------------------------------------------○○○--Declencheur
/*function click_declencheur(e:Event):void{
   	empreinte=new BitmapData(600,400)
    empreinte.draw(image);// ou this au lieu de zoneTravail pour prendre la scène entière
    monImageBrute=encode(empreinte);
    fluxDonnees = new FileStream();
    imageEnregistree=dossier.resolvePath("images/"+nomFichier.text+".png");
}
declencheur.addEventListener(MouseEvent.CLICK,click_declencheur);*/

//___________________________________________________○○○--Zoom
function zoom(e:MouseEvent){
   //TweenMax.to(image,1,{x:(image.x-contour.x)/2, y:(image.y-contour.y)/2,ease:Sine.easeIn});
   TweenMax.to(image,0.2,{scaleX:taille, ease:Sine.easeOut});
   TweenMax.to(image,0.2,{scaleY:taille, ease:Sine.easeOut});
}
btn_zoom_plus.addEventListener(MouseEvent.MOUSE_DOWN, zoom);
function dezoom(e:MouseEvent){
   TweenMax.to(image,0.1,{scaleX:0.18, ease:Sine.easeOut});
   TweenMax.to(image,0.1,{scaleY:0.18, ease:Sine.easeOut});
   TweenMax.to(image,0.1,{x:100, y:100, ease:Sine.easeIn});
}
btn_zoom_moins.addEventListener(MouseEvent.MOUSE_DOWN, dezoom);