
btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);	
var racine = root.parent.root;
var bmp:Bitmap = new  Bitmap(MovieClip(racine).maCapture1);
affichage.addChild(bmp);
///////suivant bouton ////// 
trace ("bouton ok");
function suivant_new(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = true;	
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