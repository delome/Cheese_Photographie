  stop();
  import com.greensock.*;
import com.greensock.easing.*;
   var racine = root.parent.root
	btn_new.txt_btn_nouvellePartie.text = MovieClip(racine).DialoguesXML.MenuPrincipal.Item1;
	btn_chargerPartie.txt_btn_chargerPartie.text = MovieClip(racine).DialoguesXML.MenuPrincipal.Item2;
	btn_aPropos.txt_btn_aPropos.text = MovieClip(racine).DialoguesXML.MenuPrincipal.Item3;


 	btn_new.addEventListener(MouseEvent.MOUSE_DOWN,nouvellepartie);
   function nouvellepartie(evt:MouseEvent) {
		MovieClip(racine).adresse = new URLRequest("choix_sex.swf");
		MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
		MovieClip(racine).chargement.y=0;
		MovieClip(racine).boutons = false;	
		MovieClip(racine).posFondX =810.55;
		MovieClip(racine).posFondY =300.75;
		MovieClip(racine).posDevantX =0;
		MovieClip(racine).posDevantY =0;
		MovieClip(racine).posPlayerX =450;
		MovieClip(racine).posPlayerY =360;
   }
   btn_new.buttonMode = true;
<<<<<<< HEAD
  
   MovieClip(racine).theme1 = MovieClip(racine).rock.play(0,5);
=======
>>>>>>> finish_mardi
