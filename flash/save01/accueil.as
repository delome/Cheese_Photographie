   import com.greensock.*;
import com.greensock.easing.*;

   var racine = root.parent.root
 	btn_new.addEventListener(MouseEvent.MOUSE_DOWN,nouvellepartie);
   function nouvellepartie(evt:MouseEvent) {
	  MovieClip(racine).adresse = new URLRequest("choix_sex.swf");
      MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
	  MovieClip(racine).chargement.y=0;
	  MovieClip(racine).boutons = false;	  
   }
   btn_new.buttonMode = true;
   