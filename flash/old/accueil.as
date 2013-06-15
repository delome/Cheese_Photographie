   import com.greensock.*;
import com.greensock.easing.*;

   var racine = root.parent.root
 	btn_new.addEventListener(MouseEvent.MOUSE_DOWN,tourner);
   function tourner(evt:MouseEvent) {
	  MovieClip(racine).adresse = new URLRequest("niveau01.1.swf");
      MovieClip(racine).chargeur.load(MovieClip(racine).adresse);
	  MovieClip(racine).chargement.y=0;
	  MovieClip(racine).boutons = true;
	  
   }
   btn_new.buttonMode = true;
   