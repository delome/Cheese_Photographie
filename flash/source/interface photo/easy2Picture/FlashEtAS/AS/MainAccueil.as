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
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;

	//Communication serveur
	import flash.net.URLRequest;
	
	
	public class MainAccueil extends AnimationPleinEcran {
	
		private var flouImage:BlurFilter;//pour le flou
				
		//constructeur
		public function MainAccueil(){
			
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			
			flouImage = new BlurFilter();
			FilterShortcuts.init();
			
			//pour gérer la qualité du flou
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			//gère les écouteurs du bouton jouer et le flou du bouton
			_btnJouer.addEventListener(MouseEvent.CLICK,chargementJouer);
			_btnJouer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_jouer);
			_btnJouer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_jouer);
			_btnJouer.filters = [flouImage];
			//_btnJouer.useHandCursor=false;
			Tweener.addTween(_btnJouer, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
			
			
			//gère les écouteurs du bouton aide et le flou du bouton
			_btnAide.addEventListener(MouseEvent.CLICK , chargementAide);
			_btnAide.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_aide);
			_btnAide.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_aide);
			_btnAide.filters = [flouImage];
			Tweener.addTween(_btnAide, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
			
			
			//gère les écouteurs du bouton a propos et le flou du bouton
			_btnApropos.addEventListener(MouseEvent.CLICK ,chargementAPropos);
			_btnApropos.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_propos);
			_btnApropos.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_propos);
			_btnApropos.filters = [flouImage];
			Tweener.addTween(_btnApropos, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
			
			
			//ecoute si l'animation a été déchargée
			this.addEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}
		
		
		
		//fonction chargée de supprimer les intéractions lorsque l'animation est déchargée
		private function desactiverAnim (e:Event):void{
			
			//on supprime tous les écouteurs
			_btnJouer.removeEventListener(MouseEvent.CLICK,chargementJouer);
			_btnJouer.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_jouer);
			_btnJouer.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_jouer);
			
			_btnAide.removeEventListener(MouseEvent.CLICK , chargementAide);
			_btnAide.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_aide);
			_btnAide.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_aide);
			
			_btnApropos.removeEventListener(MouseEvent.CLICK ,chargementAPropos);
			_btnApropos.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_propos);
			_btnApropos.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_propos);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}
				
				
				
		//fonctions pour le bouton Jouer
		private function chargementJouer (e:MouseEvent):void {
			//déclaration d'un nombre pour savoir quel bouton a été cliqué	
			var texte:String = "debut";
			
			//envoie un évènement avec un numéro qui indique que la vidéo est en cours de lecture
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		//fonction pour le passage de la souris sur le bouton Jouer
		private function bouton_over_jouer(e:MouseEvent):void {
			Tweener.addTween(_btnJouer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		//fonction pour la sortie de la souris du bouton Jouer
		private function bouton_out_jouer(e:MouseEvent):void {
			Tweener.addTween(_btnJouer, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
		}
		
		
		
		
		//fonctions pour le bouton aide
		public function chargementAide (e:MouseEvent):void {
			
			//déclaration d'un nombre pour savoir quel bouton a été cliqué	
			var texte:String = "aideDeb";
			
			//envoie un évènement avec un numéro qui indique que la vidéo est en cours de lecture
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		//fonction pour le passage de la souris sur le bouton Aide
		private function bouton_over_aide(e:MouseEvent):void {
			Tweener.addTween(_btnAide, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		//fonction pour la sortie de la souris du bouton Aide
		private function bouton_out_aide(e:MouseEvent):void {
			Tweener.addTween(_btnAide, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
		}
		
		
		
		
		//fonctions pour le bouton a propos
		private function chargementAPropos (e:MouseEvent):void {
			//déclaration d'un nombre pour savoir quel bouton a été cliqué			
			var texte:String = "apropos";
			
			//envoie un évènement avec un numéro qui indique que la vidéo est en cours de lecture
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		//fonction pour le passage de la souris sur le bouton APropos
		private function bouton_over_propos(e:MouseEvent):void{
			Tweener.addTween(_btnApropos, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		//fonction pour la sortie de la souris du bouton APropos
		private function bouton_out_propos(e:MouseEvent):void {
			Tweener.addTween(_btnApropos, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
		}
		
	}
	
	
}