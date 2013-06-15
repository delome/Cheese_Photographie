package {
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.SimpleButton;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.net.navigateToURL;
	
	import caurina.transitions.Tweener;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import caurina.transitions.properties.FilterShortcuts;
	import flash.filters.*;
	
	
	public class MainAideExpert extends AnimationPleinEcran {
		
		//Initialisation du flou
		var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		public function MainAideExpert():void {
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			//Bouton Retour flou par défaut
			_btnRetour.filters = [flouImage]
			Tweener.addTween(_btnRetour, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			
			//Evenements sur le bouton Retour
			_btnRetour.addEventListener(MouseEvent.CLICK ,chargementRetour);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OVER, bouton_over);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OUT, bouton_out);
			
			//ecoute si l'animation a été déchargée
			this.addEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}
		
		//fonction chargée de supprimer les intéractions lorsque l'animation est déchargée
		private function desactiverAnim (e:Event):void{
			
			//on supprime tous les écouteurs
			_btnRetour.removeEventListener(MouseEvent.CLICK ,chargementRetour);
			_btnRetour.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over);
			_btnRetour.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}
		
		
		private function chargementRetour (e:MouseEvent):void {
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