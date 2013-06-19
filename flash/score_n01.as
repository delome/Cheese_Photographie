stop();
var racine = root.parent.root;
var bmp:Bitmap = new  Bitmap(MovieClip(racine).maCapture1);
affi.affichage.addChild(bmp);
btn_com.addEventListener(MouseEvent.MOUSE_DOWN,suivant_com);	 
function suivant_com(evt:MouseEvent) {
<<<<<<< HEAD
	MovieClip(racine).adresse = new URLRequest("carte.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).boutons = false;	
	//MovieClip(racine).theme1 = MovieClip(racine).rock.play();
	MovieClip(racine).reloader (evt);
=======
	MovieClip(racine).boutons = true;
	MovieClip(racine).chargement.y=0;
	MovieClip(racine).adresse = new URLRequest("accueil.swf");
	MovieClip(racine).chargeur.load(MovieClip(racine).adresse);	  	
	MovieClip(racine).reloader();
>>>>>>> finish_mardi
}
btn_com.buttonMode = true;

trace ("Chargement_affichage_OK");

<<<<<<< HEAD



=======
>>>>>>> finish_mardi
///final
trace("Note_ISO "+MovieClip(racine).best_iso);
trace("Note_WB "+MovieClip(racine).best_wb);
trace("Note_Zoom "+MovieClip(racine).best_zoom);
trace("Note_Cadrage "+MovieClip(racine).best_cadrage);
var score_final = MovieClip(racine).best_cadrage+MovieClip(racine).best_zoom+MovieClip(racine).best_wb+MovieClip(racine).best_iso;
trace("Votre score est de "+score_final+" %");

<<<<<<< HEAD
scroring.affichage_score.text = score_final;

if(score_final<100&&score_final>60){
	gold.alpha = 1;
}
else if (score_final<60&&score_final>30){
	argent.alpha = 1;
}
else if (score_final<30&&score_final>0){
	bronze.alpha = 1;
}


=======
scroring.affichage_score.text = score_final;
>>>>>>> finish_mardi
