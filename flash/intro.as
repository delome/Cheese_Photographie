//////////////////////////
//Intro////////////////
//////////////////////////
///////suivant bouton //////
btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);	 
function suivant_new(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = true;	
MovieClip(racine).theme1.stop();
}
btn_suivant.buttonMode = true;
var racine = root.parent.root;