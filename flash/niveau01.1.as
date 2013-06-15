﻿//////////////////////////
//niveau 1////////////////
//////////////////////////

//initialisation XML//////////////////////////////////////////////////////////
var adresseFichierXML:URLRequest = new URLRequest("xml/personnages.xml");
var conteneurXML:URLLoader = new URLLoader();
conteneurXML.load(adresseFichierXML);
var arboXML:XML;
var adresseFichier = ("perso/personnage_fille.swf");
conteneurXML.addEventListener(Event.COMPLETE,chargementXMLTermine);
conteneurXML.addEventListener(IOErrorEvent.IO_ERROR, onFileError);

//var posx = MovieClip(racine).posFondX;
//var posy = MovieClip(racine).posFondY;
//trace(posx);
//trace(posy);
//derriere.X=MovieClip(racine).posFondX;
//derriere.Y=MovieClip(racine).posFondY;
//derriere.X="-785,10";
//derriere.Y="-145,85";
//devant.X=MovieClip(racine).posDevantX;
//devant.Y=MovieClip(racine).posDevantY;

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
////////////////////////////
//Personnage ///////////////
///////////////////////////
var player:Loader = new Loader();
function charger_perso() {		
	var adressePerso:URLRequest = new URLRequest(adresseFichier);
	player.load(adressePerso);
	addChild(player);
	//placement du personnage //
	player.y=391;
	player.x=475;
	setChildIndex(devant,this.numChildren-1);
	/////////////////////////////////////////////////////////////////////////////////
	stage.addEventListener(Event.ENTER_FRAME, Deplacement_fond);//fonction dans main
	stage.addEventListener(Event.ENTER_FRAME, niveau_suivant);//evenements specifique au niveau
}
/////////////////////////////////////////////////////////////
//Function niveau ///////////////////////////
function niveau_suivant(e) {
	if (MovieClip(player.content).player.hit_box.hitTestObject(derriere.suiv)) {					
		/*MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
	 	MovieClip(racine).boutons = true;		
		removeChild(chargeur);*/		
		derriere.suiv.y = 1194;
		MovieClip(racine).chargement.y=0;
		MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
     	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	 	MovieClip(racine).reloader(e);				
	}
	else{
		
		}
	if(MovieClip(player.content).player.zone_i.hitTestObject(derriere.btn_prise_1)) {
		  TweenLite.to(derriere.btn_prise_1, 0.3, {scaleX:2, scaleY:2, alpha:0.7, ease:Bounce.easeOut});
		  derriere.btn_prise_1.btn.buttonMode = true;		
		  derriere.btn_prise_1.btn.addEventListener(MouseEvent.CLICK, MovieClip(racine).afficher_interfacePhoto);
	}
	else {
		 TweenLite.to(derriere.btn_prise_1, 0.3, {scaleX:1, scaleY:1, alpha:0.4, ease:Bounce.easeOut});
		 derriere.btn_prise_1.btn.buttonMode = false; 
		 derriere.btn_prise_1.btn.removeEventListener(MouseEvent.CLICK, MovieClip(racine).afficher_interfacePhoto);
	}	
}
//saveXmlHandler (player);
////////////////////////////////////////////////////
/* test save XML ///////////////
/////////////////////////////////
 function saveXmlHandler(e):void
        {
            var designType:String = "cover or inside page";
            var pageType:String = "Hard or Soft";
            var pageSize:String= "A4 ,SL, B5, DVD, A5, A4, Lands";
            var ImageData:String = "image data";
            var designBackground:String = "Back Image";

            var TypeR:String = "Rectangle";
            var pointsR:String = "x,y,w,h";

            var TypeC:String = "Circle";
            var pointsC:String = "r,c";

            var FooterPoints:String = "x,y,w,h";
            var FooterImage:String = "image data";

            //<?xml version="1.0" encoding="UTF-8"?>
            var xm:XML =<save>
                           <derniere_ecran>
						   </derniere_ecran>
                        </save>;
            xm.xmlDecl = <?xml version="1.0" encoding="UTF-8"?>;


            //var ba:ByteArray = new ByteArray();
            //ba.writeUTFBytes(xm);

            var fr:FileReference = new FileReference();           
            fr.save(xm, "xml/save.xml");
        }