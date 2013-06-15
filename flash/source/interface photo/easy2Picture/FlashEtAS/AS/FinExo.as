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

	
	public class FinExo extends AnimationPleinEcran
	{

		var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		public function FinExo()
		{
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			// Gestion des écouteurs
			stage.addEventListener(MouseEvent.CLICK ,FonctionExo);

		}
		
		private function FonctionExo(e:MouseEvent)
		{
			
			//sert à définir quel bouton a été cliqué
			var texte:String = "jouer";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
	
	}

}