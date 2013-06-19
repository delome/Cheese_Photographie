stop();
var racine = root.parent.root;
btn_fin.addEventListener(MouseEvent.MOUSE_DOWN,fin);
btn_fin.buttonMode = true;
function fin(e) {
  MovieClip(racine).adresse = new URLRequest("accueil.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = false;	
  MovieClip(racine).theme1.play(0,5);
}