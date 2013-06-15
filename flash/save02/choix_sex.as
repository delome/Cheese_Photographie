////// Choix Du Sex ////////////
stop();
var racine = root.parent.root;
btn_femme.addEventListener(MouseEvent.MOUSE_DOWN,choixSexF);
btn_femme.buttonMode = true;
btn_homme.addEventListener(MouseEvent.MOUSE_DOWN,choixSexM);
btn_homme.buttonMode = true;

btn_suivant.alpha = 0.3;

var sex = ("garçon");
function choixSexF(e) {
	  sex=("fille");
	  trace("clique fille");
	  btn_homme.alpha = 0.2;
	  btn_femme.alpha = 1;
	  enregister("F");
	  btn_suivant.alpha = 1;
	  btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);	 
}
function choixSexM(e) {
	  sex=("garçon");
	  trace("clique garçon");
	  btn_homme.alpha = 1;
	  btn_femme.alpha = 0.2;
	  enregister("M");
	  btn_suivant.alpha = 1;
	  btn_suivant.addEventListener(MouseEvent.MOUSE_DOWN,suivant_new);
}

//// Roll over out //////////////////////////////////////////////
btn_femme.addEventListener(MouseEvent.MOUSE_OVER,anim_btn_femme);
btn_femme.addEventListener(MouseEvent.MOUSE_OUT,anim_btn_femme_retour);
btn_homme.addEventListener(MouseEvent.MOUSE_OVER,anim_btn_homme);
btn_homme.addEventListener(MouseEvent.MOUSE_OUT,anim_btn_homme_retour);

function anim_btn_femme (e){
	btn_femme.gotoAndStop("on");
}
function anim_btn_femme_retour (e) {
	btn_femme.gotoAndStop("off");
}
function anim_btn_homme (e){
	btn_homme.gotoAndStop("on");
}
function anim_btn_homme_retour (e) {
	btn_homme.gotoAndStop("off");
}
///////////////////////Enregistrement dans le XMl //////////////

function enregister (choix_sex:String){
	trace("enregistrement "+ sex);
	trace (choix_sex);
	MovieClip(racine).SaveXML.Personnage[0].Type[0] = (choix_sex);
	trace ("enregistrement réussit ?");
	trace(MovieClip(racine).SaveXML.Personnage[0].Type[0]);
	//var file:FileReference = new FileReference;
	//file.save( SaveXML, "save.xml" ); 
	//var file:File = File.userDirectory.resolvePath("test.txt");
	//var xmlStream:FileStream = new FileStream();
	//xmlStream.open(file, FileMode.WRITE);
	//fileStream.writeUTFBytes("text to save");
	//xmlStream.close();
}


///////suivant bouton //////
function suivant_new(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
  MovieClip(racine).boutons = true;	
MovieClip(racine).theme1.stop();
}
btn_suivant.buttonMode = true;

///////annuler bouton //////
btn_annuler.addEventListener(MouseEvent.MOUSE_DOWN,retour_accueil);
function retour_accueil(evt:MouseEvent) {
  MovieClip(racine).adresse = new URLRequest("accueil.swf");
  MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
  MovieClip(racine).chargement.y=0;
// MovieClip(racine).boutons = true;	
//MovieClip(racine).theme1.stop();
}
btn_annuler.buttonMode = true;