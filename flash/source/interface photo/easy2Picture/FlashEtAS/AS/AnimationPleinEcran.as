package {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.StageAlign;
	public class AnimationPleinEcran extends Animation {
		//CONSTANTE D'ALIGNEMENT
		private var _sauvegardeClip:Array=new Array;
		private var _ecran:String;
		private var _tauxRedimensionnement:Number;
		
		public static const REDIM_AUTO:Number=-1; //Redimensionnement en proportion de l'agrandissement
		
		public function AnimationPleinEcran() {
			super();
			if (! GLOBAL_STAGE.hasEventListener(Event.RESIZE)) {
				GLOBAL_STAGE.addEventListener(Event.RESIZE,avertir);
				GLOBAL_STAGE.align=StageAlign.TOP_LEFT;
				GLOBAL_STAGE.scaleMode=StageScaleMode.NO_SCALE;
			}
			
			//Permet de mettre l'application en plein ecran dès son chargement si besoin
			if (GLOBAL_STAGE.displayState == StageDisplayState.FULL_SCREEN) {
				this.loaderInfo.addEventListener(Event.COMPLETE,changerFormat);
			}
			//Idem vérification de format lors de l'ajout
			addEventListener(Event.ADDED_TO_STAGE,activer);
			addEventListener(Event.REMOVED_FROM_STAGE,desactiver);
		}
		/*****************************************************************************************
		*                                       Méthodes publiques                               *
		*                                                                                        *
		******************************************************************************************/

		/* Accesseurs de lecture et d'écriture sur ecran */
		public function get ecran():String {
			return _ecran;
		}
		public function set ecran(val:String):void {
			_ecran=val;
			mettreEnNormal();

			if (GLOBAL_STAGE.displayState == StageDisplayState.FULL_SCREEN) {
				
				mettreEnPleinEcran();
			}
		}
		
		//Permet d'aligner un élément en plein écran tout en sauvegardant les informations nécessaires pour le repositionner
		// lors de la remise en état normal
		public function alignerPleinEcran(clip:DisplayObject,redimensionnement:Number=1,align:String=CENTER_CENTER,scene:Boolean=true,espacementVertical:int=0,espacementHorizontal:int=0):void {
			var element:Object=rechercheTableau(clip);
			
			if (element) {
				resetPropriete(element);
			}
			var sauvegarde:Object={objet:clip,x:clip.x,y:clip.y};

			if (redimensionnement < 0) {
				redimensionnement=_tauxRedimensionnement;
			}
			if (redimensionnement != 1) {
					sauvegarde.scaleX=clip.scaleX;
					sauvegarde.scaleY=clip.scaleY;
					clip.scaleX=redimensionnement;
					clip.scaleY=redimensionnement;
			}
			_sauvegardeClip.push(sauvegarde);

			var widthReference:Number=scene?GLOBAL_STAGE.stageWidth:clip.parent.width;
			var heightReference:Number=scene?GLOBAL_STAGE.stageHeight:clip.parent.height;
			alignerElement(clip,align,espacementVertical,espacementHorizontal,scene,widthReference,heightReference);
			

		}
		
		public function redimensionnerPleinEcran(clip:DisplayObject,redimensionnement:Number=1):void {
			var element:Object=rechercheTableau(clip);
			
			if (element) {
				resetPropriete(element);
			}
			var sauvegarde:Object={objet:clip,x:clip.x,y:clip.y};

			if (redimensionnement < 0) {
				redimensionnement=_tauxRedimensionnement;
			}
			if (redimensionnement != 1) {
					sauvegarde.scaleX=clip.scaleX;
					sauvegarde.scaleY=clip.scaleY;
					clip.scaleX=redimensionnement;
					clip.scaleY=redimensionnement;
			}
			_sauvegardeClip.push(sauvegarde);

		

		}
		/*****************************************************************************************
		*                           Méthodes pouvant être redéfinies                             *
		*                                                                                        *
		******************************************************************************************/
		/* fonction à redéfinir si vous voulez modifier l'affichage en plein écran */
		protected function mettreEnPleinEcran():void {
		}
		
		/* fonction à redéfinir si vous voulez modifier l'affichage lors du retour en normal 
		 Par défaut, remet les clips dans l'état sauvegardé  par alignementPleinEcran
		 */
		protected function mettreEnNormal():void {

			var clip:DisplayObject;
			for (var i=0; i < _sauvegardeClip.length; i++) {
				resetPropriete(_sauvegardeClip[i]);
			}
			_sauvegardeClip=new Array()  ;

		}
		
		/*****************************************************************************************
		*           Méthodes privées nécessaires au fonctionnement interne                       *
		*                                                                                        *
		******************************************************************************************/
		
		private function activer(e:Event):void {
			stage.addEventListener(Event.RESIZE,avertir);
			this.addEventListener(Event.RESIZE,changerFormat);
		}
		
		private function desactiver(e:Event):void {
			stage.removeEventListener(Event.RESIZE,avertir);
			this.removeEventListener(Event.RESIZE,changerFormat);
		}
		
		private function avertir(e:Event) {
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		private function changerFormat(e:Event=null) {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				_tauxRedimensionnement=GLOBAL_STAGE.stageWidth/_widthScene;
				mettreEnPleinEcran();
			} else {
				mettreEnNormal();
			}
		}
		
		private function rechercheTableau(clip:DisplayObject):Object {
			for (var i=0; i < _sauvegardeClip.length; i++) {
				if (_sauvegardeClip[i].objet == clip) {
					return _sauvegardeClip[i];
				}
			}
			return null;
		}
		
		private function resetPropriete(caseTab:Object) {
			var clip:DisplayObject=caseTab.objet;
			if (caseTab.x) 
				clip.x=caseTab.x;
			if (caseTab.y) 
				clip.y=caseTab.y;
			if (caseTab.scaleX) {
					clip.scaleX=caseTab.scaleX;
					clip.scaleY=caseTab.scaleY;
			}
			
		}
		
	}
}