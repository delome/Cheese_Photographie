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
	
	
	public class MainDebut extends AnimationPleinEcran {
		
		//Initialisation du flou
		private var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		public function MainDebut() {
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			aide.btn_aide.addEventListener(MouseEvent.CLICK, cliqAide);
			
			//Bouton aide flou par défaut
			aide.btn_aide.filters = [flouImage];
			Tweener.addTween(aide.btn_aide, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
			aide.btn_aide.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_aide);
			aide.btn_aide.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_aide);
			
			
			aide.btn_continuer.addEventListener(MouseEvent.CLICK, cliqContinuer);
			
			//Bouton aide flou par défaut
			aide.btn_continuer.filters = [flouImage];
			Tweener.addTween(aide.btn_continuer, {_Blur_blurX:4, _Blur_blurY:4, time:0, transition:"linear"});
			aide.btn_continuer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_continuer);
			aide.btn_continuer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_continuer);
		}
		
		private function bouton_over_aide(e:MouseEvent):void {
			//Bouton sans flou quand la souris est dessus
			Tweener.addTween(aide.btn_aide, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
			
		private function bouton_out_aide(e:MouseEvent):void {
			//Bouton avec flou quand la souris n'est pas dessus
			Tweener.addTween(aide.btn_aide, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
		}
		
		
		private function bouton_over_continuer(e:MouseEvent):void {
			//Bouton sans flou quand la souris est dessus
			Tweener.addTween(aide.btn_continuer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
			
		private function bouton_out_continuer(e:MouseEvent):void {
			//Bouton avec flou quand la souris n'est pas dessus
			Tweener.addTween(aide.btn_continuer, {_Blur_blurX:4, _Blur_blurY:4, time:0.4, transition:"linear"});
		}
		
		
		//fonction qui gère le clic sur le bouton aide
		private function cliqAide (e:Event):void{
			//déclaration d'un nombre pour savoir quel bouton a été cliqué	
			var texte:String = "aideDeb";
			
			//envoie un évènement avec un numéro qui indique que la vidéo est en cours de lecture
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			
		}
		
		//fonction qui gère le clic sur le bouton continuer
		private function cliqContinuer (e:Event):void{
			//déclaration d'un nombre pour savoir quel bouton a été cliqué	
			var texte:String = "jouer";
			
			//envoie un évènement avec un numéro qui indique que la vidéo est en cours de lecture
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
									
			//on supprime l'écouteur
			aide.btn_continuer.removeEventListener(MouseEvent.CLICK, cliqContinuer);
		}
	}
}