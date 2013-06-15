package {

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.Stage;
	public class Animation extends MovieClip {
		//CONSTANTE D'ALIGNEMENT
		public static  const TOP_LEFT:String="topLeft";
		public static  const TOP_RIGHT:String="topRight";
		public static  const TOP_CENTER:String="topCenter";
		public static  const BOTTOM_LEFT:String="bottomLeft";
		public static  const BOTTOM_RIGHT:String="bottomRight";
		public static  const BOTTOM_CENTER:String="bottomCenter";
		public static  const CENTER_LEFT:String="centerLeft";
		public static  const CENTER_RIGHT:String="centerRight";
		public static  const CENTER_CENTER:String="centerCenter";

		// point d'accès à l'objet Stage 
		public static  var GLOBAL_STAGE:Stage;
		protected static  var _widthScene:Number;
		protected static  var _heightScene:Number;
		// propriété permettant l’exécution de la fonction de rappel
		private var rappel:Function;
		private var imageStop;

		public function Animation() {
			// affecte une référence à l'objet Stage
			if (!GLOBAL_STAGE && stage) {
				GLOBAL_STAGE=stage;
				_widthScene=GLOBAL_STAGE.stageWidth;
				_heightScene=GLOBAL_STAGE.stageHeight;
			}
		}
		
		
		/***********************************************************************************
		*                FONCTIONS PUBLIQUES                                               *
		***********************************************************************************/

		/* Fonction permettant de placer plus facilement les éléments sur scène.
		Parametres :
		l'objet à placer (obligatoires)
		l'alignement souhaité : voir les constantes (par défaut centrage horizontal et vertical
		espacement vertical souhaité avec le bord haut(top) ou bas (bottom) (ne sert pas si l'alignement vertical est centré). Par défaut 0
		espacement horizontal souhaité avec le bord gauche(left) ou bas (right) (ne sert pas si l'alignement horizontal est centré). Par défaut 0
		scene : booléen.Si il a pour valeur true l'alignement se fait par rapport à la scène(par défaut), si false se fait par rapport au parent
		*/
		public static function aligner(clip:DisplayObject,align:String=CENTER_CENTER,espacementVertical:int=0,espacementHorizontal:int=0,scene:Boolean=true):void {
			if (!clip.parent) {
				throw new Error("Votre objet " + clip + " doit être ajouté à la liste d'affichage avant de pouvoir être aligné");
			}
			var widthReference:Number=scene? _widthScene:clip.parent.width;
			var heightReference:Number=scene? _heightScene:clip.parent.height;
			alignerElement(clip,align,espacementVertical,espacementHorizontal,scene,widthReference,heightReference);
		}
		// méthode de déplacement de la tête de lecture personnalisée permettant d'exécuter une fonction à un point précis du scénario
		//En parametre 
		//l'image de destination soit le n° de l'image (int) , soit son étiquette (String)
		//La fonction à executer lorsque cette image est atteinte
		public function allerA(pImage:*,pFonction:Function):void {
			// écoute de l'événement Event.RENDER
			addEventListener(Event.RENDER,miseAJour);
			// déplacement de la tête de lecture
			gotoAndStop(pImage);
			rappel=pFonction;
			// force la diffusion de l'événement Event.RENDER
			stage.invalidate();
		}
		// méthode permettant de jouer une animation d'une image de début à une image de fin
		// et d'exécuter une fonction lorsque cette image de fin est atteinte
		//En parametre 
		//    L'image de début d'animation: soit le n° de l'image (int) , soit son étiquette (String)
		//   l'image de fin d'animation :soit le n° de l'image (int) , soit son étiquette (String)
		//   La fonction à exécuter lorsque cette image de fin est atteinte
		public function jouer(pImageDep:*,pImageStop:*,pFonction:Function=null):void {
			addEventListener(Event.ENTER_FRAME,attenteImage);
			addEventListener(Event.REMOVED_FROM_STAGE,function(e:Event){removeEventListener(Event.ENTER_FRAME,attenteImage)});
			gotoAndPlay(pImageDep);
			rappel=pFonction;
			imageStop=pImageStop;

		}
		//Fonction permettant de se déplacer à la dernière image de l'animation
		public function terminer():void {
			this.gotoAndStop(this.currentScene.numFrames);

		}
		/***********************************************************************************
		*                FONCTIONS PRIVEES : interne au fonctionnement                                            *
		***********************************************************************************/

		// teste si l'image de destination est atteinte à chaque frame
		private function attenteImage(evt:Event):void {
			var valImage:*;
			if ((typeof imageStop)=="string") {
				valImage=this.currentLabel;
			} else {
				valImage=this.currentFrame;
			}
			if (valImage == imageStop) {
				this.removeEventListener(Event.ENTER_FRAME,attenteImage);
				this.addEventListener(Event.RENDER,miseAJour);
				stop();
				stage.invalidate();
			}
		}
		//Appel de la fonction de rappel
		private function miseAJour(pEvt:Event):void {
			// nous tentons d'appeler la fonction de rappel 
			if (rappel!=null) {

				try {
					rappel();// si cela échoue, nous affichons un message d'erreur

				} catch (pErreur:Error) {
					trace("Erreur : La méthode de rappel n'a pas été définie");
				} finally {
					removeEventListener(Event.RENDER,miseAJour);
				}
			}
		}
		
		//ALignement d'un élément
		protected static function alignerElement(clip:DisplayObject,align:String,espacementVertical:int,espacementHorizontal:int,scene:Boolean,widthReference:Number,heightReference:Number):void {
			switch (align) {
				case TOP_LEFT :
					clip.x=espacementHorizontal;
					clip.y=espacementVertical;
					break;
				case TOP_RIGHT :
					clip.x=widthReference-clip.width-espacementHorizontal;
					clip.y=espacementVertical;
					break;
				case TOP_CENTER :
					clip.x=(widthReference-clip.width)/2;
					clip.y=espacementVertical;
					break;
				case BOTTOM_LEFT :
					clip.x=espacementHorizontal;
					clip.y=heightReference-clip.height-espacementVertical;
					break;
				case BOTTOM_RIGHT :
					clip.x=widthReference-clip.width-espacementHorizontal;
					clip.y=heightReference-clip.height-espacementVertical;
					break;
				case BOTTOM_CENTER :
					clip.x=(widthReference-clip.width)/2;
					clip.y=heightReference-clip.height-espacementVertical;
					break;
				case CENTER_LEFT :
					clip.x=espacementHorizontal;
					clip.y=(heightReference-clip.height)/2;
					break;
				case CENTER_RIGHT :
					clip.x=widthReference-clip.width-espacementHorizontal;
					clip.y=(heightReference-clip.height)/2;
					break;
				case CENTER_CENTER :
					clip.x=(widthReference-clip.width)/2;
					clip.y=(heightReference-clip.height)/2;
					break;


			}
			if (scene) {
				var point=new Point(clip.x,clip.y);
				point=clip.parent.globalToLocal(point);
				clip.x=point.x;
				clip.y=point.y;
			}
			
		}
		
	}
}