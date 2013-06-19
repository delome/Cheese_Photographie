package {
	
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	
	public class McTIDE extends MovieClip {
		
		public var tfNum:TextField; 
		public var mcSize:Sprite; //Sprite : Sous classe de MovieClip
		public var mcEtats:MovieClip;
		
		
		public var indexX:int; //Son index en X
		public var indexY:int; //Son index en Y
		public var wall:Boolean = false;
		public var bombe:Boolean = false;
		
		public function McTIDE() {
			trace(this, "constructor");
			mcSize.visible = false; //Pas besoin de voir le clip qui sert à calculer la taille
			initRolls();
			useHandCursor = true;
			mouseChildren = false;
			buttonMode = true;
			
		}
		
		private function initRolls() : void {
			
			addEventListener(MouseEvent.ROLL_OVER, _rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, _rollOutHandler);
			
		}
		
		private function _rollOverHandler(e:MouseEvent) : void {
			alpha = 0.8;
		}
		
		private function _rollOutHandler(e:MouseEvent) : void {
			alpha = 1;
		}
		
		public function setNum(sTxt:String) : void {
			tfNum.text  = sTxt;
		}
		

		
		
		
	}
	
	
	
}