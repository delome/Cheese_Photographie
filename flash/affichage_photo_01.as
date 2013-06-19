
btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);	
var racine = root.parent.root;
var bmp:Bitmap = new  Bitmap(MovieClip(racine).maCapture1);
affichage.addChild(bmp);
trace("Note_ISO "+MovieClip(racine).best_iso);
trace("Note_WB "+MovieClip(racine).best_wb);
trace("Note_Zoom "+MovieClip(racine).best_zoom);
trace("Note_Cadrage "+MovieClip(racine).best_cadrage);
var score = MovieClip(racine).best_cadrage+MovieClip(racine).best_zoom+MovieClip(racine).best_wb+MovieClip(racine).best_iso;
trace("Votre score est de "+score+" %");


///////suivant bouton ////// 
trace ("chargement Affichage OK");
function suivant_new(evt:MouseEvent) {
<<<<<<< HEAD
	MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).boutons = true;	
	MovieClip(racine).photoOk = true;	
	MovieClip(racine).posFondX=-1151,1;				
	MovieClip(racine).posFondY=-145.85;
	MovieClip(racine).posDevantX=-1136,2;
	MovieClip(racine).posDevantY=-144.65;
	MovieClip(racine).posPlayerX=400;
	MovieClip(racine).posPlayerY=391;
=======
  MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = true;	
  MovieClip(racine).photoOk = true;	
>>>>>>> finish_mardi
}
btn_suivant.buttonMode = true;
btn_retour.addEventListener(MouseEvent.MOUSE_DOWN,retour_photo);	 
function retour_photo(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("interface_photo.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
 // MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = false;	
}
btn_retour.buttonMode = true;

setChildIndex(btn_suivant.masque,this.numChildren-1);
setChildIndex(btn_retour.masque,this.numChildren-1);

