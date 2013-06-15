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
	import caurina.transitions.properties.FilterShortcuts;
	import flash.filters.*;

	//évènements
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;

	//Communication serveur
	import flash.net.URLRequest;

	public class SolutionExo41deb extends AnimationPleinEcran {
	
		
		var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
			
		public function SolutionExo41deb(){
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			_btnRetour.addEventListener(MouseEvent.CLICK , chargementRetour);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_retour);
			_btnRetour.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_retour);
			
			Tweener.addTween(_btnRetour, {_Blur_blurX:4, _Blur_blurY:4, time:0, transition:"linear"});
			
		}
		
		
		private function chargementRetour (e:MouseEvent):void {
			//sert à définir quel bouton a été cliqué
			var texte:String = "exo42deb";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));

		}
		
		private function bouton_over_retour(e:MouseEvent):void {
			Tweener.addTween(_btnRetour, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_retour(e:MouseEvent):void {
			Tweener.addTween(_btnRetour, {_Blur_blurX:4, _Blur_blurY:4, time:0.4, transition:"linear"});
		}
	}
	
	
}