///////suivant bouton //////
function suivant_new(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("Interface_photo.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = false;	
}
var racine = root.parent.root;
btn_suivant.buttonMode = true;
btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);
stop();