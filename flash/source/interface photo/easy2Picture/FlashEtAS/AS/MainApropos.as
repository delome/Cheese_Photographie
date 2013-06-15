package {
	//elements graphiques
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.SimpleButton;
	import flash.display.StageDisplayState;
	import caurina.transitions.Tweener;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import caurina.transitions.properties.FilterShortcuts;
	import flash.filters.*;

	//évènements
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;

	//Communication serveur
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	import flash.net.navigateToURL;

	
	public class MainApropos extends AnimationPleinEcran {
		
		//Initialisation du flou
		var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		public function MainApropos(){
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			//Ecouteurs sur les noms
			_btnEdna.addEventListener(MouseEvent.CLICK , sendEmailEdna);
			_btnJulien.addEventListener(MouseEvent.CLICK , Julien);
			_btnLyly.addEventListener(MouseEvent.CLICK , sendEmailLydwine);
			_btnThomas.addEventListener(MouseEvent.CLICK , Thomas);
			_btnNathan.addEventListener(MouseEvent.CLICK , Nathan);
			
			//Bouton Retour flou par défaut
			_btnRetour.filters = [flouImage]
			Tweener.addTween(_btnRetour, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			
			//Evenements sur le bouton Retour
			_btnRetour.addEventListener(MouseEvent.CLICK ,retourAccueil);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OVER, bouton_over);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OUT, bouton_out);
			
			//ecoute si l'animation a été déchargée
			this.addEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
			
		}
		
		//fonction chargée de supprimer les intéractions lorsque l'animation est déchargée
		private function desactiverAnim (e:Event):void{
			
			//on supprime tous les écouteurs
			_btnEdna.removeEventListener(MouseEvent.CLICK , sendEmailEdna);
			_btnJulien.removeEventListener(MouseEvent.CLICK , Julien);
			_btnLyly.removeEventListener(MouseEvent.CLICK , sendEmailLydwine);
			_btnThomas.removeEventListener(MouseEvent.CLICK , Thomas);
			_btnNathan.removeEventListener(MouseEvent.CLICK , Nathan);
			
			_btnRetour.removeEventListener(MouseEvent.CLICK ,retourAccueil);
			_btnRetour.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over);
			_btnRetour.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}

		private function sendEmailEdna(e:MouseEvent):void
		{
			//Ouvre la messagerie avec l'adresse e-mail de Edna
     		navigateToURL(new URLRequest("mailto:eazizet@yahoo.fr"), "_blank");
		}
		
		private function Julien(e:MouseEvent):void
		{
			//Ouvre un nouvelle onglet vers le site de julien
     		navigateToURL(new URLRequest("http://wadjus.free.fr"),"_blank");
		}
	
		private function sendEmailLydwine(e:MouseEvent):void
		{
			//Ouvre la messagerie avec l'adresse e-mail de Lydwine
     		navigateToURL(new URLRequest("mailto:lydwine_27@hotmail.fr"),"_blank");
		}
		
		private function Thomas(e:MouseEvent):void
		{
			//Ouvre un nouvelle onglet vers le site de Thomas
     		navigateToURL(new URLRequest("http://www.thomas-bodin.com"),"_blank");
		}
		
		private function Nathan(e:MouseEvent):void
		{
			//Ouvre un nouvelle onglet vers le site de Nathan
     		navigateToURL(new URLRequest("http://nathan_peronne.ultra-book.com/"),"_blank");
		}
		
		private function retourAccueil(epv:MouseEvent):void{
			//sert à définir quel bouton a été cliqué
			var texte:String = "accueil";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		private function bouton_over(e:MouseEvent):void 
		{
			//Bouton Retour sans flou quand la souris est dessus
			Tweener.addTween(_btnRetour, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out(e:MouseEvent):void 
		{
			//Bouton Retour avec flou quand la souris n'est pas dessus
			Tweener.addTween(_btnRetour, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}

	}
	
}