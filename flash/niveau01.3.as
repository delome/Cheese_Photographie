//////////////////////////
//niveau 1.3//////////////
//////////////////////////

// Importation
import com.greensock.*;
import com.greensock.easing.*;
<<<<<<< HEAD
=======
import flash.ui.Keyboard;
import flash.events.Event;
import flash.events.KeyboardEvent;
>>>>>>> finish_mardi

//initialisation XML//////////////////////////////////////////////////////////
var adresseFichierXML:URLRequest = new URLRequest("xml/personnages.xml");
var conteneurXML:URLLoader = new URLLoader();
conteneurXML.load(adresseFichierXML);
var arboXML:XML;
var adresseFichier = ("perso/personnage_fille.swf");
conteneurXML.addEventListener(Event.COMPLETE,chargementXMLTermine);
conteneurXML.addEventListener(IOErrorEvent.IO_ERROR, onFileError);

var racine = root.parent.root;

//btn_new.txt_btn_nouvellePartie.text = MovieClip(racine).DialoguesXML.Niveau1.Gare;
//btn_retour.txt_retour.text = MovieClip(racine).DialoguesXML.Gen.BtnRetour;


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
var player2:Loader = new Loader();
function charger_perso() {		
	var adressePerso:URLRequest = new URLRequest(adresseFichier);
	player2.load(adressePerso);
	addChild(player2);
	//placement du personnage //
	player2.x=MovieClip(racine).posPlayerX;
	player2.y=MovieClip(racine).posPlayerY;
	setChildIndex(devant,this.numChildren-1);
}
/////////////////////////////////////////////////////////////
//Function niveau ///////////////////////////
function niveau_retour(evt:MouseEvent) {
	MovieClip(racine).adresse = new URLRequest("niveau01.2.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).boutons = true;
	MovieClip(racine).reloader(evt);
	MovieClip(racine).posFondX=-305;				
	MovieClip(racine).posFondY=300.75;
	MovieClip(racine).posPlayerX=700;
	MovieClip(racine).posPlayerY=360;
	trace ("retour ok"+MovieClip(racine).posFondX);
<<<<<<< HEAD
=======
	//stage.removeEventListener(Event.ENTER_FRAME, Deplacement_fond);
	//stage.removeEventListener(Event.ENTER_FRAME, niveau_retour);
>>>>>>> finish_mardi
}

////////////////////////////////////////////////////
// test save XML ///////////////
/*////////////////////////////////*
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
                           <derniere_ecran></derniere_ecran>
                        </save>;
            xm.xmlDecl = <?xml version="1.0" encoding="UTF-8"?>;


            //var ba:ByteArray = new ByteArray();
            //ba.writeUTFBytes(xm);

            var fr:FileReference = new FileReference();           
            fr.save(xm, "xml/save.xml");
        }*/