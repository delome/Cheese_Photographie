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

	
	public class Exposition extends AnimationPleinEcran{
		

		private var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		//constructeur
		public function Exposition(){
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			// Gestion des écouteurs
			_btnJouer.addEventListener(MouseEvent.CLICK ,FonctionExposition);
			_btnJouer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over);
			_btnJouer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out);
			
			//gestion du flou
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			_btnJouer.filters = [flouImage];
			Tweener.addTween(_btnJouer, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
		}
		
		
		private function FonctionExposition(e:MouseEvent){

			//sert à définir quel bouton a été cliqué
			var texte:String = "exo31deb";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		private function bouton_over(e:MouseEvent):void	{
			Tweener.addTween(_btnJouer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out(e:MouseEvent):void {
			Tweener.addTween(_btnJouer, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}
	
	}

}