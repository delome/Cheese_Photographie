/******************************************************************
* Classe AnimationCompleteEvent             *
* événement généré par un lorsqu'un fichier swf chargé se termine *
*******************************************************************/

package  {
	
	import flash.events.Event;
	
	public class AnimationCompleteEvent extends Event {
		
		/***************
		*les constantes*
		***************/
		
		public static const ANIMATION_COMPLETE:String = "complete";
		/****************************
		*les propriétés d'occurrence*
		****************************/
		
		private var _info:Object; //Objet contenant des informations sur l'animation qui vient de se terminer
		
		
		/****************
		*le constructeur*
		****************/
		
		public function AnimationCompleteEvent(type:String, pInfo:Object = null,bubbles:Boolean = false, cancelable:Boolean = false ) {
			//initialisation du constructeur de la classe Event
			super(type, bubbles, cancelable);
			if(pInfo==null) {
				this._info = {};
			}else{
				this._info = pInfo
			}
		}
		
		/*************
		*les méthodes*
		*************/
		
		//surcharge de la méthode clone (obligatoire)
		public override function clone():Event {
			return new AnimationCompleteEvent(type, bubbles, cancelable);
		}
		
		//surcharge de la méthode toString (obligatoire)
		public override function toString():String {
			return("[AnimationCompleteEvent : "+type+", bubbles : "+bubbles+", cancelable : "+cancelable+"]");
		}
		
		/***********************
		*les getters et setters*
		***********************/
		
		public function get info():Object {
			return this._info;
		}
		
		public function set info(val:Object):void {
			this._info =val;
		}
	}
}