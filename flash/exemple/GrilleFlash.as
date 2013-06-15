package 
{

	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class GrilleFlash extends MovieClip
	{

		//Choix de la méthode de placement( Emmanuel ou Flore-Anne, bravo à vous deux :p )
		private const ET_METHOD:Boolean = true;


		private var _loadXML:URLLoader;
		private var _xml:XML;
		private var _tides:Array;//Sera un array de array de Cases
		private var _tidesContainer:Sprite;
		private var _bombe:Sprite;
		
		
		private var persoX:int;
		private var persoY:int;
		
		public var mcPerso:MovieClip;


		public function GrilleFlash()
		{
			trace(this, "constructor");

			_loadXML = new URLLoader();
			_loadXML.addEventListener(Event.COMPLETE, onFileComplete);
			_loadXML.addEventListener(IOErrorEvent.IO_ERROR, onFileError);
			_loadXML.load(new URLRequest("map.xml"));

			_tidesContainer = new Sprite();
			_bombe = new Sprite();
			
			addChildAt(_tidesContainer, 0);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);

			trace(_loadXML);


		}
		
		private function _onKeyDown(e:KeyboardEvent) : void{
			switch(e.keyCode){
				case Keyboard.UP: 
					trace("haut");
					_move(0,-1);
				break;
				case Keyboard.DOWN: 
					trace("bas");
					_move(0,1);
				break;
				case Keyboard.LEFT: 
					trace("gauche");
					_move(-1,0);
				break;
				case Keyboard.RIGHT: 
					trace("droite");
					_move(1,0);
				break;
				case Keyboard.SPACE:
					_mur(0,0);
				break;
				case Keyboard.SHIFT:
					_casse_mur(0,0);
					_casse_mur(1,0);
					_casse_mur(-1,0);
					_casse_mur(0,1);
					_casse_mur(0,-1);
				break;
			}
		}
		
		private function _move(iX:int, iY:int){
			trace(iX, iY);
			var tempX = persoX+iX;
			var tempY = persoY+iY;
			
			if ((tempX>=0) && (tempY>=0) && (tempY != 9) && _tides[tempX]){
				
				var pCase = _tides[tempX][tempY];
				trace(this, pCase.indexX, pCase.indexY);
				if(pCase){
					
					if(!pCase.wall && !pCase.bombe){
				
						persoX = tempX;
						persoY = tempY;
				
						mcPerso.x = pCase.x;
						mcPerso.y = pCase.y;
						
					}
				}
			}
			
		}
		
		private function _casse_mur(iX:int, iY:int){
			trace(iX, iY);
			var tempX = persoX+iX;
			var tempY = persoY+iY;
			
			
			if ((tempX>=0) && (tempY>=0) && (tempY != 9) && _tides[tempX]){
				
				var pCase = _tides[tempX][tempY];
				trace(this, pCase.indexX, pCase.indexY);
				if(pCase){
					
					if(pCase.wall){
						if((iX==0) && (iY==0)&&(!pCase.bombe)){
							mcPerso.y = mcPerso.y + 10;
							var bombe = new McBombe();
							addChild(bombe);
							bombe.currentScene;
							bombe.x = mcPerso.x;
							bombe.y = mcPerso.y;
							pCase.bombe=1;
							//var moteur:Timer = new Timer(5000,1);
							//moteur.addEventListener(TimerEvent.TIMER_COMPLETE,destruction);
							//moteur.start();
							pCase.bombe=0;
							pCase.wall=0;
						}
					}else if((iX==0) && (iY==0)&&(!pCase.bombe)){
							var bombe = new McBombe();
							addChild(bombe);
							bombe.currentScene;
							bombe.x = mcPerso.x;
							bombe.y = mcPerso.y;
							pCase.bombe=1;
							pCase.wall=0;
							pCase.y = pCase.y +10;
							pCase.bombe=0;
					}
				}
			}
			
		}
		
		private function _mur(iX:int, iY:int){
			trace(iX, iY);
			var tempX = persoX+iX;
			var tempY = persoY+iY;
			var pCase = _tides[tempX][tempY];
			if(!pCase.wall){
				pCase.wall=1;
				pCase.y = pCase.y -10;
				pCase.mcEtats.gotoAndStop(3);
				mcPerso.y = mcPerso.y - 10;
			}
			
		}

		protected function onFileComplete(evt:Event):void
		{

			trace("xml arrivé !", evt.target);
			var myLoader:URLLoader = evt.target as URLLoader;
			if (myLoader)
			{

				trace(this, "C'est bien un loader !");
				_xml = new XML(myLoader.data);

				drawGrid(300,120);
			}

		}

		protected function onFileError(evt:IOErrorEvent):void
		{

			trace(this, evt);

		}

		private function drawGrid(nDecalX:Number, nDecalY:Number):void
		{

			
			_tides = new Array();
			
			var iTRCount:int = _xml.grid.tr.length();

			for (var i:int = 0; i < iTRCount; i++)
			{	
				if(!_tides[i]){
					_tides[i] = new Array();
				}
				

				var xTR:XML = _xml.grid.tr[i] as XML;
				var iTDCount:int = xTR.td.length();

				for (var j:int = 0; j < iTDCount; j++)
				{
					var xTD:XML = xTR.td[j] as XML;

					var tempClip:McTIDE = new McTIDE();
					
					tempClip.indexX = i;
					tempClip.indexY = j;
					
					var demW:Number = tempClip.mcSize.width / 2;
					var demH:Number = tempClip.mcSize.height / 2;

					if (ET_METHOD)
					{

						//Méthode de Emmanuel T
						tempClip.x = nDecalX + (-demW*j)+(demW*i);//+(2*demW) ;
						tempClip.y = nDecalY + (demH * j) + (demH * i);

					} else {

						//Méthode de Flore-Anne
						tempClip.x = nDecalX + demW * j - demW * i;
						tempClip.y = nDecalY + demH * i + demH * j;

					}

					_tidesContainer.addChild(tempClip);

					tempClip.wall = (xTD.@mur.toString() == "1");
						if(tempClip.wall){
							tempClip.y = tempClip.y -10;
							tempClip.mcEtats.gotoAndStop(2);
						}

					if (xTD.hasOwnProperty("@num"))
					{

						tempClip.setNum(xTD.@num.toString());
						//trace(this, 'TD :',xTD.@num);
						

					}
					else
					{	
						//Champs vide
						tempClip.setNum("");
						//trace(this, 'TD sans num');
					}
					
					_tides[i].push(tempClip);
					
					if (xTD.hasOwnProperty("@perso"))
					{

						if(xTD.@perso.toString() == "1"){
							
							mcPerso.x = tempClip.x;
							mcPerso.y = tempClip.y;
							
							persoX = tempClip.indexX;
							persoY = tempClip.indexY;
						}
						

					}
					
					
					
					tempClip.addEventListener(MouseEvent.CLICK, onTideClick);
					
				}



			}

			//trace("_tides", _tides);

		}
		
		function onTideClick (e:Event) : void{
			
			var mcTide:McTIDE = e.target as McTIDE;
			
			trace(this, mcTide.wall);
			if (!mcTide.wall && !mcTide.bombe){
			
				mcPerso.x = mcTide.x;
				mcPerso.y = mcTide.y;
				
				persoX = mcTide.indexX;
				persoY = mcTide.indexY;
			}
			
		}


	}



}