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

	
	public class MainAideDebutant extends AnimationPleinEcran {
	
		
		var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
			
		//constructeur
		public function MainAideDebutant(){
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			_btnContinuer.addEventListener(MouseEvent.CLICK , chargementContinuer);
			_btnContinuer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_continuer);
			_btnContinuer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_continuer);
			
			Tweener.addTween(_btnContinuer, {_Blur_blurX:4, _Blur_blurY:4, time:0, transition:"linear"});
			
		}
		
		
		private function chargementContinuer (e:MouseEvent):void {
			
			//sert à définir quel bouton a été cliqué
			var texte:String = "aideExp";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		private function bouton_over_continuer(e:MouseEvent):void 
		{
			Tweener.addTween(_btnContinuer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_continuer(e:MouseEvent):void 
		{
			Tweener.addTween(_btnContinuer, {_Blur_blurX:4, _Blur_blurY:4, time:0.4, transition:"linear"});
		}
	}
	
	
}