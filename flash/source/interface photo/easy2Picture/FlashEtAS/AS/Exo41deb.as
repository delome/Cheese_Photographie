package 
{
  //elements graphiques
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.SimpleButton;
	import flash.display.StageDisplayState;
	import flash.filters.*;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.FilterShortcuts;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	//évenements
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;

	//Communication serveur
	import flash.net.URLRequest;
	
	
	public class Exo41deb extends AnimationPleinEcran 
	{
		
		//Déclaration de la photo par un boolean si elle est en intérieur ou en extérieur
		var photoInt:Boolean = new Boolean();
		
		//Déclaration de la zone pour l'ISO (grain sur la photographie)
		var myBitmap:BitmapData = new BitmapData(580, 600,false, 0xff000000);
		var image:Bitmap;
		
		//
		var tableau:Array;
		//Réglage de l'exercice par défaut
		var variableIsoJoueur:int=100;
		var variableWbJoueur:int=1;
		var variableExpoJoueur:int=0;
		var variableDiaphJoueur:int=8;
		var variableObturationJoueur:int=30;
		
		//Déclaration des bons réglages
		var variableIsoValide:int=100;
		var variableWbValide:int=3;
		var variableExpoValide:int=0;
		var variableDiaphValide:int=2;
		var variableObturationValide:int=30;
		
		//Initialisation de la note du joueur à 0/20
		var noteJoueur:int=0;
		

		public function Exo41deb()
		{
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		
			//fonction pour savoir quand le flash est ajouté au FlashConteneur
			private function addedToStageHandler (e:Event):void
			{
				//Booléan photo en intérieur
				photoInt=false;
				
				//ISO par défaut
				image = new Bitmap(myBitmap);
				addChild(image);
				myBitmap.noise(Math.random()*100, 0, 150, 7,true);
				image.alpha = 0;
				
				//WB par défaut
				filtreBleu.alpha = 0;
				filtreOrange.alpha = 0;
				
				//Exposition par défaut
				filtreBlanc.alpha = 0;
				filtreNoir.alpha = 0;
				
				
				
				//Ecouteurs des Boutons du mode
				reglage._btnP1.addEventListener(MouseEvent.CLICK, modeAutomatique);
				reglage._btnM1.addEventListener(MouseEvent.CLICK, modeManuel);
				reglage._btnTv1.addEventListener(MouseEvent.CLICK, modePrioriteVitesse);
				reglage._btnAv1.addEventListener(MouseEvent.CLICK, modePrioriteOuverture);
				
				//Ecouteur du déclencheur
				_btnNote.addEventListener(MouseEvent.CLICK, calculerNote);
				
				//Ecouteur sur les boutons ISO
				iso._btnIso100.addEventListener(MouseEvent.CLICK, ajoutGrain100);
				iso._btnIso200.addEventListener(MouseEvent.CLICK, ajoutGrain200);
				iso._btnIso400.addEventListener(MouseEvent.CLICK, ajoutGrain400);
				iso._btnIso800.addEventListener(MouseEvent.CLICK, ajoutGrain800);
				
				//Ecouteur sur les boutons WB
				wb._btnWbSoleil.addEventListener(MouseEvent.CLICK, balanceSoleil);
				wb._btnWbNeon.addEventListener(MouseEvent.CLICK, balanceNeon);
				wb._btnWbNuage.addEventListener(MouseEvent.CLICK, balanceNuage);
				wb._btnWbLampe.addEventListener(MouseEvent.CLICK, balanceLampe);
				
				//Ecouteur sur les boutons Exposition
				expo._btnExpo1.addEventListener(MouseEvent.CLICK, expoMoins1);
				expo._btnExpo05.addEventListener(MouseEvent.CLICK, expoMoins05);
				expo._btnExpo0.addEventListener(MouseEvent.CLICK, expo0);
				expo._btnExpo05p.addEventListener(MouseEvent.CLICK, expoPlus05);
				expo._btnExpo1p.addEventListener(MouseEvent.CLICK, expoPlus1);
				
				//Ecouteur sur les boutons Diaphragme
				diaphragme._btnDiaphragme2.addEventListener(MouseEvent.CLICK, diaphragme2);
				diaphragme._btnDiaphragme4.addEventListener(MouseEvent.CLICK, diaphragme4);
				diaphragme._btnDiaphragme8.addEventListener(MouseEvent.CLICK, diaphragme8);
				diaphragme._btnDiaphragme16.addEventListener(MouseEvent.CLICK, diaphragme16);
				
				//Ecouteur sur les boutons Obturation
				obturation._btnObturation30.addEventListener(MouseEvent.CLICK, obturation30);
				obturation._btnObturation60.addEventListener(MouseEvent.CLICK, obturation60);
				obturation._btnObturation125.addEventListener(MouseEvent.CLICK, obturation125);
				obturation._btnObturation250.addEventListener(MouseEvent.CLICK, obturation250);
				obturation._btnObturation500.addEventListener(MouseEvent.CLICK, obturation500);
				
				//Par défaut le bouton automatique est rouge et les autres blancs
				reglage._btnP2.visible=true;
				reglage._btnP1.visible=false;
				reglage._btnM2.visible=false;
				reglage._btnTv2.visible=false;
				reglage._btnAv2.visible=false;
				
				//Par défaut les boutons ISO, 100 en rouge et les autres en blancs
				iso._btnIso100.visible=false;
				iso._btnIso100Rouge.visible=true;
				iso._btnIso200Rouge.visible=false;
				iso._btnIso400Rouge.visible=false;
				iso._btnIso800Rouge.visible=false;
				
				//Par défaut les boutons WB, soleil en rouge et les autres en blancs
				wb._btnWbSoleil_ON.visible=true;
				wb._btnWbSoleil.visible=false;
				wb._btnWbNeon_ON.visible=false;
				wb._btnWbNuage_ON.visible=false;
				wb._btnWbLampe_ON.visible=false;
				
				//Par défaut les boutons Exposition, 0 en rouge et les autres en blancs
				expo._btnExpo05Rouge.visible=false;
				expo._btnExpo1Rouge.visible=false;
				expo._btnExpo0Rouge.visible=true;
				expo._btnExpo0.visible=false;
				expo._btnExpo05pRouge.visible=false;
				expo._btnExpo1pRouge.visible=false;
				
				//Par défaut les boutons Diaphragme, f/2 en rouge et les autres en blancs
				diaphragme._btnDiaphragme2_ON.visible=false;
				diaphragme._btnDiaphragme2.visible=true;
				diaphragme._btnDiaphragme4_ON.visible=false;
				diaphragme._btnDiaphragme8_ON.visible=true;
				diaphragme._btnDiaphragme8.visible=false;
				diaphragme._btnDiaphragme16_ON.visible=false;
				
				//Par défaut les boutons Obturation, 30 en rouge et les autres en blancs
				obturation._btnObturation30_ON.visible=true;
				obturation._btnObturation30.visible=false;
				obturation._btnObturation60_ON.visible=false;
				obturation._btnObturation125_ON.visible=false;
				obturation._btnObturation250_ON.visible=false;
				obturation._btnObturation500_ON.visible=false;
				
				_photoF4.visible=false;
				photo.visible=false;
				_photoF8.visible=true;
				_photoF16.visible=false;
				
				//ISO, WB, Exposition présents et Diaphragme, Obturation invisibles
				Tweener.addTween(diaphragme, {x:900, y:356.4, time:0.5, transition:"linear"});
				Tweener.addTween(obturation, {x:900, y:488.6, time:0.5, transition:"linear"});
				
				//Initialisation du calque solution
				solution.visible=false;
				
				//Ecouteurs boutons présents au moment de la note
				solution.btnRecommencer.addEventListener(MouseEvent.CLICK, recommencerExercice);
				solution.btnContinuer.addEventListener(MouseEvent.CLICK, actionContinuer);
				solution.btnSolution.addEventListener(MouseEvent.CLICK, donnerSolution);
			}
			
			
			//Réglages du Mode (Automatique, Manuel, Priorité Vitesse et Priorité Ouverture)
				private function modeAutomatique (e:MouseEvent):void
				{
						//Bouton P en rouge et les autres boutons en blanc (défaut)
						reglage._btnP2.visible= true;
						reglage._btnP1.visible= false;
						reglage._btnM2.visible=false;
						reglage._btnM1.visible=true;
						reglage._btnTv2.visible=false;
						reglage._btnTv1.visible=true;
						reglage._btnAv2.visible=false;
						reglage._btnAv1.visible=true;
						
						//ISO, WB, Exposition présents et Diaphragme, Obturation invisibles
						Tweener.addTween(diaphragme, {x:900, y:356.4, time:0.5, transition:"linear"});
						Tweener.addTween(obturation, {x:900, y:488.6, time:0.5, transition:"linear"});
				}
				
				private function modeManuel (e:MouseEvent):void
				{
						//Bouton M en rouge et les autres boutons en blanc
						reglage._btnM2.visible= true;
						reglage._btnM1.visible= false;
						reglage._btnP2.visible=false;
						reglage._btnP1.visible=true;
						reglage._btnTv2.visible=false;
						reglage._btnTv1.visible=true;
						reglage._btnAv2.visible=false;
						reglage._btnAv1.visible=true;
						
						//ISO, WB, Exposition, Diaphragme, Obturation présents
						Tweener.addTween(diaphragme, {x:580.5, y:356.4, time:0.5, transition:"linear"});
						Tweener.addTween(obturation, {x:585.2, y:488.6, time:0.5, transition:"linear"});
				}
				
				private function modePrioriteVitesse (e:MouseEvent):void 
				{
						//Bouton Tv en rouge et les autres boutons en blanc
						reglage._btnTv2.visible= true;
						reglage._btnTv1.visible= false;
						reglage._btnP2.visible=false;
						reglage._btnP1.visible=true;
						reglage._btnM2.visible=false;
						reglage._btnM1.visible=true;
						reglage._btnAv2.visible=false;
						reglage._btnAv1.visible=true;
						
						//ISO, WB, Exposition, Obturation présents et Diaphragme invisible
						Tweener.addTween(diaphragme, {x:900, y:356.4, time:0.5, transition:"linear"});
						Tweener.addTween(obturation, {x:585.2, y:488.6, time:0.5, transition:"linear"});
				}
				
				private function modePrioriteOuverture (e:MouseEvent):void 
				{
						//Bouton Av en rouge et les autres boutons en blanc
						reglage._btnAv2.visible= true;
						reglage._btnAv1.visible= false;
						reglage._btnP2.visible=false;
						reglage._btnP1.visible=true;
						reglage._btnM2.visible=false;
						reglage._btnM1.visible=true;
						reglage._btnTv2.visible=false;
						reglage._btnTv1.visible=true;
		
						//ISO, WB, Exposition, Diaphragme présents et Obturation invisible
						Tweener.addTween(diaphragme, {x:580.5, y:356.4, time:0.5, transition:"linear"});
						Tweener.addTween(obturation, {x:900, y:488.6, time:0.5, transition:"linear"});
						
				}
			
			
			//Réglage ISO
				private function ajoutGrain100(e:Event):void
				{
					//Grain de la photographie
					myBitmap.noise(Math.random()*100, 0, 150, 7,true);
					image.alpha = 0;
					
					//Boutons ISO 100 en rouge et les autres boutons en blanc (défaut)
					iso._btnIso100.visible=false;
					iso._btnIso100Rouge.visible=true;
					iso._btnIso200.visible=true;
					iso._btnIso200Rouge.visible=false;
					iso._btnIso400.visible=true;
					iso._btnIso400Rouge.visible=false;
					iso._btnIso800.visible=true;
					iso._btnIso800Rouge.visible=false;
					
					//Variable pour noter les réglages du joueur (ISO 100)
					variableIsoJoueur=100;
				}
				
				private function ajoutGrain200(e:Event):void
				{
					//Condition du grain en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.08;
					}
					else
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.06;
					}
					
					//Boutons ISO 200 en rouge et les autres boutons en blanc
					iso._btnIso200.visible=false;
					iso._btnIso200Rouge.visible=true;
					iso._btnIso100.visible=true;
					iso._btnIso100Rouge.visible=false;
					iso._btnIso400.visible=true;
					iso._btnIso400Rouge.visible=false;
					iso._btnIso800.visible=true;
					iso._btnIso800Rouge.visible=false;
					
					//Variable pour noter les réglages du joueur (ISO 200)
					variableIsoJoueur=200;
				}
				
				private function ajoutGrain400(e:Event):void
				{
					//Condition du grain en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.12;
					}
					else
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.10;
					}
					
					//Boutons ISO 400 en rouge et les autres boutons en blanc
					iso._btnIso400.visible=false;
					iso._btnIso400Rouge.visible=true;
					iso._btnIso100.visible=true;
					iso._btnIso100Rouge.visible=false;
					iso._btnIso200.visible=true;
					iso._btnIso200Rouge.visible=false;
					iso._btnIso800.visible=true;
					iso._btnIso800Rouge.visible=false;
				
					
					//Variable pour noter les réglages du joueur (ISO 400)
					variableIsoJoueur=400;
				}
				
				private function ajoutGrain800(e:Event):void
				{
					//Condition du grain en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.22;
					}
					else
					{
						myBitmap.noise(Math.random()*100, 0, 150, 7,true);
						image.alpha = 0.20;
					}
					
					//Boutons ISO 800 en rouge et les autres boutons en blanc
					iso._btnIso800.visible=false;
					iso._btnIso800Rouge.visible=true;
					iso._btnIso100.visible=true;
					iso._btnIso100Rouge.visible=false;
					iso._btnIso200.visible=true;
					iso._btnIso200Rouge.visible=false;
					iso._btnIso400.visible=true;
					iso._btnIso400Rouge.visible=false;
					
					//Variable pour noter les réglages du joueur (ISO 800)
					variableIsoJoueur=800;
				}
			
			
			//Réglage WB
				private function balanceSoleil (e:MouseEvent):void
				{
					//Bouton WB soleil en rouge et les autres boutons en blanc
					wb._btnWbSoleil_ON.visible=true;
					wb._btnWbSoleil.visible=false;
					wb._btnWbNeon_ON.visible=false;
					wb._btnWbNeon.visible=true;
					wb._btnWbNuage_ON.visible=false;
					wb._btnWbNuage.visible=true;
					wb._btnWbLampe_ON.visible=false;
					wb._btnWbLampe.visible=true;
					
					//Condition du WB en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0.15;
					}
					else
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0;
					}
					
					//Variable pour noter les réglages du joueur (WB Soleil)
					variableWbJoueur=1;
				}
				
				private function balanceNeon (e:MouseEvent):void
				{
					//Bouton WB Neon en rouge et les autres boutons en blanc
					wb._btnWbSoleil_ON.visible=false;
					wb._btnWbSoleil.visible=true;
					wb._btnWbNeon_ON.visible=true;
					wb._btnWbNeon.visible=false;
					wb._btnWbNuage_ON.visible=false;
					wb._btnWbNuage.visible=true;
					wb._btnWbLampe_ON.visible=false;
					wb._btnWbLampe.visible=true;
					
					//Condition du WB en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0.05;
					}
					else
					{
						filtreBleu.alpha=0.15;
						filtreOrange.alpha=0;
					}
					
					//Variable pour noter les réglages du joueur (WB Neon)
					variableWbJoueur=2;
				}
				
				private function balanceNuage (e:MouseEvent):void
				{
					//Bouton WB Nuage en rouge et les autres boutons en blanc
					wb._btnWbSoleil_ON.visible=false;
					wb._btnWbSoleil.visible=true;
					wb._btnWbNeon_ON.visible=false;
					wb._btnWbNeon.visible=true;
					wb._btnWbNuage_ON.visible=true;
					wb._btnWbNuage.visible=false;
					wb._btnWbLampe_ON.visible=false;
					wb._btnWbLampe.visible=true;
					
					//Condition du WB en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0.20;
					}
					else
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0.05;
					}
					
					//Variable pour noter les réglages du joueur (WB Nuage)
					variableWbJoueur=3;
				}
				
				private function balanceLampe (e:MouseEvent):void
				{
					//Bouton WB Lampe en rouge et les autres boutons en blanc
					wb._btnWbSoleil_ON.visible=false;
					wb._btnWbSoleil.visible=true;
					wb._btnWbNeon_ON.visible=false;
					wb._btnWbNeon.visible=true;
					wb._btnWbNuage_ON.visible=false;
					wb._btnWbNuage.visible=true;
					wb._btnWbLampe_ON.visible=true;
					wb._btnWbLampe.visible=false;
					
					//Condition du WB en fonction de la photographie (Intérieur/Extérieur)
					if(photoInt==true)
					{
						filtreBleu.alpha=0;
						filtreOrange.alpha=0;
					}
					else
					{
						filtreBleu.alpha=0.20;
						filtreOrange.alpha=0;
					}
					
					//Variable pour noter les réglages du joueur (WB Lampe)
					variableWbJoueur=4;
				}
				
				
			//Réglage Exposition	
				private function expoMoins1 (e:MouseEvent):void
				{
						//Exposition de la photographie (filtre Noir)
						filtreNoir.alpha=0.3;
						filtreBlanc.alpha=0;
						
						//Boutons Exposition -1 en rouge et les autres boutons en blanc
						expo._btnExpo1Rouge.visible=true;
						expo._btnExpo1.visible=false;
						expo._btnExpo05Rouge.visible=false;
						expo._btnExpo05.visible=true;
						expo._btnExpo0Rouge.visible=false;
						expo._btnExpo0.visible=true;
						expo._btnExpo1pRouge.visible=false;
						expo._btnExpo1p.visible=true;
						expo._btnExpo05pRouge.visible=false;
						expo._btnExpo05p.visible=true;
						
						//Variable pour noter les réglages du joueur (Exposition -1)
						variableExpoJoueur=-1;
				}
				
				private function expoMoins05 (e:MouseEvent):void
				{
						//Exposition de la photographie (filtre Noir)
						filtreNoir.alpha=0.2;
						filtreBlanc.alpha=0;
						
						//Boutons Exposition -0,5 en rouge et les autres boutons en blanc
						expo._btnExpo05Rouge.visible=true;
						expo._btnExpo05.visible=false;
						expo._btnExpo1.visible=true;
						expo._btnExpo1Rouge.visible=false;
						expo._btnExpo0Rouge.visible=false;
						expo._btnExpo0.visible=true;
						expo._btnExpo0Rouge.visible=false;
						expo._btnExpo1pRouge.visible=false;
						expo._btnExpo1p.visible=true;
						expo._btnExpo05pRouge.visible=false;
						expo._btnExpo05p.visible=true;
						
						//Variable pour noter les réglages du joueur (Exposition -0,5)
						variableExpoJoueur=-0.5;
				}
				
				private function expo0 (e:MouseEvent):void
				{
						//Exposition de la photographie (sans filtre)
						filtreBlanc.alpha=0;
						filtreNoir.alpha=0;
						
						//Boutons Exposition 0 en rouge et les autres boutons en blanc (défaut)
						expo._btnExpo0Rouge.visible=true;
						expo._btnExpo0.visible=false;
						expo._btnExpo1.visible=true;
						expo._btnExpo1Rouge.visible=false;
						expo._btnExpo05Rouge.visible=false;
						expo._btnExpo05.visible=true;
						expo._btnExpo0Rouge.visible=true;
						expo._btnExpo0.visible=false;
						expo._btnExpo1pRouge.visible=false;
						expo._btnExpo1p.visible=true;
						expo._btnExpo05pRouge.visible=false;
						expo._btnExpo05p.visible=true;
						
						//Variable pour noter les réglages du joueur (Exposition 0)
						variableExpoJoueur=0;
				}
		
				private function expoPlus05 (e:MouseEvent):void
				{
						//Exposition de la photographie (filtre Blanc)
						filtreBlanc.alpha=0.2;
						filtreNoir.alpha=0;
						
						//Boutons Exposition +0,5 en rouge et les autres boutons en blanc
						expo._btnExpo05pRouge.visible=true;
						expo._btnExpo05p.visible=false;
						expo._btnExpo1.visible=true;
						expo._btnExpo1Rouge.visible=false;
						expo._btnExpo05Rouge.visible=false;
						expo._btnExpo05.visible=true;
						expo._btnExpo0Rouge.visible=false;
						expo._btnExpo0.visible=true;
						expo._btnExpo1pRouge.visible=false;
						expo._btnExpo1p.visible=true;
						
						//Variable pour noter les réglages du joueur (Exposition +0,5)
						variableExpoJoueur=0.5;
				}
				
				private function expoPlus1 (e:MouseEvent):void
				{
						//Exposition de la photographie (filtre Blanc)
						filtreBlanc.alpha=0.3;
						filtreNoir.alpha=0;
						
						//Boutons Exposition +1 en rouge et les autres boutons en blanc
						expo._btnExpo1pRouge.visible=true;
						expo._btnExpo1p.visible=false;
						expo._btnExpo05pRouge.visible=false;
						expo._btnExpo05p.visible=true;
						expo._btnExpo1.visible=true;
						expo._btnExpo1Rouge.visible=false;
						expo._btnExpo05Rouge.visible=false;
						expo._btnExpo05.visible=true;
						expo._btnExpo0Rouge.visible=false;
						expo._btnExpo0.visible=true;
						
						//Variable pour noter les réglages du joueur (Exposition +1)
						variableExpoJoueur=1;
				}
			
			
			//Réglage Diaphragme
				private function diaphragme2 (e:MouseEvent):void
				{
					//Bouton Diaphragme f/2 en rouge et les autres boutons en blanc (défaut)
					diaphragme._btnDiaphragme2_ON.visible=true;
					diaphragme._btnDiaphragme2.visible=false;
					diaphragme._btnDiaphragme4_ON.visible=false;
					diaphragme._btnDiaphragme4.visible=true;
					diaphragme._btnDiaphragme8_ON.visible=false;
					diaphragme._btnDiaphragme8.visible=true;
					diaphragme._btnDiaphragme16_ON.visible=false;
					diaphragme._btnDiaphragme16.visible=true;
					
					_photoF4.visible=false;
					photo.visible=true;
					_photoF8.visible=false;
					_photoF16.visible=false;
					//Variable pour noter les réglages du joueur (Diaphragme f/2)
					variableDiaphJoueur=2;
				}
				
				private function diaphragme4 (e:MouseEvent):void
				{
					//Bouton Diaphragme f/4 en rouge et les autres boutons en blanc 
					diaphragme._btnDiaphragme2_ON.visible=false;
					diaphragme._btnDiaphragme2.visible=true;
					diaphragme._btnDiaphragme4_ON.visible=true;
					diaphragme._btnDiaphragme4.visible=false;
					diaphragme._btnDiaphragme8_ON.visible=false;
					diaphragme._btnDiaphragme8.visible=true;
					diaphragme._btnDiaphragme16_ON.visible=false;
					diaphragme._btnDiaphragme16.visible=true;
					
					_photoF4.visible=true;
					_photoF8.visible=false;
					photo.visible=false;
					_photoF16.visible=false;
					
					//Variable pour noter les réglages du joueur (Diaphragme f/4)
					variableDiaphJoueur=4;
				}
				
				private function diaphragme8 (e:MouseEvent):void
				{
					//Bouton Diaphragme f/8 en rouge et les autres boutons en blanc 
					diaphragme._btnDiaphragme2_ON.visible=false;
					diaphragme._btnDiaphragme2.visible=true;
					diaphragme._btnDiaphragme4_ON.visible=false;
					diaphragme._btnDiaphragme4.visible=true;
					diaphragme._btnDiaphragme8_ON.visible=true;
					diaphragme._btnDiaphragme8.visible=false;
					diaphragme._btnDiaphragme16_ON.visible=false;
					diaphragme._btnDiaphragme16.visible=true;
					
					_photoF4.visible=false;
					photo.visible=false;
					_photoF8.visible=true;
					_photoF16.visible=false;
					
					
					//Variable pour noter les réglages du joueur (Diaphragme f/8)
					variableDiaphJoueur=8;
				}
				
				private function diaphragme16 (e:MouseEvent):void
				{
					//Bouton Diaphragme f/16 en rouge et les autres boutons en blanc 
					diaphragme._btnDiaphragme2_ON.visible=false;
					diaphragme._btnDiaphragme2.visible=true;
					diaphragme._btnDiaphragme4_ON.visible=false;
					diaphragme._btnDiaphragme4.visible=true;
					diaphragme._btnDiaphragme8_ON.visible=false;
					diaphragme._btnDiaphragme8.visible=true;
					diaphragme._btnDiaphragme16_ON.visible=true;
					diaphragme._btnDiaphragme16.visible=false;
					
					
					_photoF4.visible=false;
					photo.visible=false;
					_photoF8.visible=false;
					_photoF16.visible=true;
					
					//Variable pour noter les réglages du joueur (Diaphragme f/16)
					variableDiaphJoueur=16;
				}
			
			
			//Réglage Obturation
				private function obturation30 (e:MouseEvent):void
				{
					//Bouton Obturation 30 en rouge et les autres boutons en blanc 
					obturation._btnObturation30_ON.visible=true;
					obturation._btnObturation30.visible=false;
					obturation._btnObturation60_ON.visible=false;
					obturation._btnObturation60.visible=true;
					obturation._btnObturation125_ON.visible=false;
					obturation._btnObturation125.visible=true;
					obturation._btnObturation250_ON.visible=false;
					obturation._btnObturation250.visible=true;
					obturation._btnObturation500_ON.visible=false;
					obturation._btnObturation500.visible=true;
					
					//Variable pour noter les réglages du joueur (Obturation 30)
					variableObturationJoueur=30;
				}
				
				private function obturation60 (e:MouseEvent):void
				{
					//Bouton Obturation 30 en rouge et les autres boutons en blanc 
					obturation._btnObturation30_ON.visible=false;
					obturation._btnObturation30.visible=true;
					obturation._btnObturation60_ON.visible=true;
					obturation._btnObturation60.visible=false;
					obturation._btnObturation125_ON.visible=false;
					obturation._btnObturation125.visible=true;
					obturation._btnObturation250_ON.visible=false;
					obturation._btnObturation250.visible=true;
					obturation._btnObturation500_ON.visible=false;
					obturation._btnObturation500.visible=true;
					
					//Variable pour noter les réglages du joueur (Obturation 60)
					variableObturationJoueur=60;
				}
				
				private function obturation125 (e:MouseEvent):void
				{
					//Bouton Obturation 30 en rouge et les autres boutons en blanc 
					obturation._btnObturation30_ON.visible=false;
					obturation._btnObturation30.visible=true;
					obturation._btnObturation60_ON.visible=false;
					obturation._btnObturation60.visible=true;
					obturation._btnObturation125_ON.visible=true;
					obturation._btnObturation125.visible=false;
					obturation._btnObturation250_ON.visible=false;
					obturation._btnObturation250.visible=true;
					obturation._btnObturation500_ON.visible=false;
					obturation._btnObturation500.visible=true;
					
					
					//Variable pour noter les réglages du joueur (Obturation 125)
					variableObturationJoueur=125;
				}
				
				private function obturation250 (e:MouseEvent):void
				{
					//Bouton Obturation 30 en rouge et les autres boutons en blanc 
					obturation._btnObturation30_ON.visible=false;
					obturation._btnObturation30.visible=true;
					obturation._btnObturation60_ON.visible=false;
					obturation._btnObturation60.visible=true;
					obturation._btnObturation125_ON.visible=false;
					obturation._btnObturation125.visible=true;
					obturation._btnObturation250_ON.visible=true;
					obturation._btnObturation250.visible=false;
					obturation._btnObturation500_ON.visible=false;
					obturation._btnObturation500.visible=true;
					
					//Variable pour noter les réglages du joueur (Obturation 250)
					variableObturationJoueur=250;
				}
				
				private function obturation500 (e:MouseEvent):void
				{
					//Bouton Obturation 30 en rouge et les autres boutons en blanc 
					obturation._btnObturation30_ON.visible=false;
					obturation._btnObturation30.visible=true;
					obturation._btnObturation60_ON.visible=false;
					obturation._btnObturation60.visible=true;
					obturation._btnObturation125_ON.visible=false;
					obturation._btnObturation125.visible=true;
					obturation._btnObturation250_ON.visible=false;
					obturation._btnObturation250.visible=true;
					obturation._btnObturation500_ON.visible=true;
					obturation._btnObturation500.visible=false;
	
					//Variable pour noter les réglages du joueur (Obturation 500)
					variableObturationJoueur=500;
				}

			
				
			//Résultat du joueur
				private function calculerNote (e:MouseEvent):void
				{
					fond.visible=false;
					//Son du déclencheur (prise de la photo et donc validation des réglages du joueur)
					var monURL:String = "./swf/photo.mp3";
					var requete:URLRequest = new URLRequest(monURL);
					var monSon:Sound = new Sound();
					monSon.load(requete);
					monSon.play();
					photo.visible=false;
					//Clip des éléments à cacher pour montrer le résultat du joueur et sa note	
					var conteneur:MovieClip= new MovieClip();
					addChild(conteneur);
					
					conteneur.addChild(reglage);
					conteneur.addChild(_btnNote);
					//conteneur.addChild(iso);
					//conteneur.addChild(wb);
					//conteneur.addChild(expo);
					//conteneur.addChild(diaphragme);
					//conteneur.addChild(obturation);
					//conteneur.addChild(fond);
					
					//Tableau contenant les photos reglage diaphragme
					tableau=new Array();
					
					tableau.push(photo);
					tableau.push(_photoF4);
					tableau.push(_photoF8);
					tableau.push(_photoF16);
					photo.visible=true;
					//parcourir le tableau
					for(var i=0;i<tableau.length;i++){
						tableau[0].visible=true;
						conteneur.addChild(tableau[i]);
						tableau[i].width=solution.photo.width;
						tableau[i].height=solution.photo.height;
						tableau[i].y=solution.photo.y;
						tableau[i].x=solution.photo.x;
						solution.addChild(tableau[i]);
						}
					
					solution.photo.visible=false;
					conteneur.visible=false;
					
					//Solution visible
					solution.visible=true;

					//Suppression écouteurs et suppression de la main
						//Boutons ISO
						iso._btnIso100.removeEventListener (MouseEvent.CLICK, ajoutGrain100);
						iso._btnIso100.useHandCursor=false; 
						iso._btnIso200.removeEventListener (MouseEvent.CLICK, ajoutGrain200);
						iso._btnIso200.useHandCursor=false; 
						iso._btnIso400.removeEventListener (MouseEvent.CLICK, ajoutGrain400);
						iso._btnIso400.useHandCursor=false; 
						iso._btnIso800.removeEventListener (MouseEvent.CLICK, ajoutGrain800);
						iso._btnIso800.useHandCursor=false; 
						
						//Boutons WB 
						wb._btnWbSoleil.removeEventListener(MouseEvent.CLICK, balanceSoleil);
						wb._btnWbSoleil.useHandCursor=false; 
						wb._btnWbNeon.removeEventListener(MouseEvent.CLICK, balanceNeon);
						wb._btnWbNeon.useHandCursor=false; 
						wb._btnWbNuage.removeEventListener(MouseEvent.CLICK, balanceNuage);
						wb._btnWbNuage.useHandCursor=false; 
						wb._btnWbLampe.removeEventListener(MouseEvent.CLICK, balanceLampe);
						wb._btnWbLampe.useHandCursor=false; 
						
						//Boutons Exposition 
						expo._btnExpo1.removeEventListener(MouseEvent.CLICK, expoMoins1);
						expo._btnExpo1.useHandCursor=false; 
						expo._btnExpo05.removeEventListener(MouseEvent.CLICK, expoMoins05);
						expo._btnExpo05.useHandCursor=false;
						expo._btnExpo0.removeEventListener(MouseEvent.CLICK, expo0);
						expo._btnExpo0.useHandCursor=false;
						expo._btnExpo05p.removeEventListener(MouseEvent.CLICK, expoPlus05);
						expo._btnExpo05p.useHandCursor=false;
						expo._btnExpo1p.removeEventListener(MouseEvent.CLICK, expoPlus1);
						expo._btnExpo1p.useHandCursor=false;
						
						diaphragme._btnDiaphragme2.removeEventListener(MouseEvent.CLICK, diaphragme2);
						diaphragme._btnDiaphragme2.useHandCursor=false; 
						diaphragme._btnDiaphragme4.removeEventListener(MouseEvent.CLICK, diaphragme4);
						diaphragme._btnDiaphragme4.useHandCursor=false; 
						diaphragme._btnDiaphragme8.removeEventListener(MouseEvent.CLICK, diaphragme8);
						diaphragme._btnDiaphragme8.useHandCursor=false; 
						diaphragme._btnDiaphragme16.removeEventListener(MouseEvent.CLICK, diaphragme16);
						diaphragme._btnDiaphragme16.useHandCursor=false; 
						
						//Ecouteur sur les boutons Obturation
						obturation._btnObturation30.removeEventListener(MouseEvent.CLICK, obturation30);
						obturation._btnObturation30.useHandCursor=false; 
						obturation._btnObturation60.removeEventListener(MouseEvent.CLICK, obturation60);
						obturation._btnObturation60.useHandCursor=false; 
						obturation._btnObturation125.removeEventListener(MouseEvent.CLICK, obturation125);
						obturation._btnObturation125.useHandCursor=false; 
						obturation._btnObturation250.removeEventListener(MouseEvent.CLICK, obturation250);
						obturation._btnObturation250.useHandCursor=false; 
						obturation._btnObturation500.removeEventListener(MouseEvent.CLICK, obturation500);
						obturation._btnObturation500.useHandCursor=false; 
					
					//Réglages du joueur sélectionnés de la même taille et à la même position que la photo proposée
						//Filtre Orange (WB)
						filtreOrange.width=solution.photo.width;
						filtreOrange.height=solution.photo.height;
						filtreOrange.x=solution.photo.x+154;
						filtreOrange.y=solution.photo.y+20;
						
						//Filre Bleu (WB)
						filtreBleu.width=solution.photo.width;
						filtreBleu.height=solution.photo.height;
						filtreBleu.x=solution.photo.x+154;
						filtreBleu.y=solution.photo.y+20;
						
						//Filtre Blanc (Exposition)
						filtreBlanc.width=solution.photo.width;
						filtreBlanc.height=solution.photo.height;
						filtreBlanc.x=solution.photo.x+154;
						filtreBlanc.y=solution.photo.y+20;
						
						//Filtre Noir (Exposition)
						filtreNoir.width=solution.photo.width;
						filtreNoir.height=solution.photo.height;
						filtreNoir.x=solution.photo.x+154;
						filtreNoir.y=solution.photo.y+20;
					
						//Grain (ISO)
						image.width=solution.photo.width;
						image.height=solution.photo.height;
						image.x=solution.photo.x+154;
						image.y=solution.photo.y+20;
					
					//Calcule de la note	
						//Notation de l'ISO
						if (variableIsoJoueur == variableIsoValide) {
							noteJoueur=3;
						} 
						else {
							noteJoueur=0;
						}
						
						//Notation du WB
						if (variableWbJoueur == variableWbValide) {
							noteJoueur=noteJoueur+3;
						} 
						else {
							noteJoueur=noteJoueur+0;
						}
						
						//Notation de l'exposition
						if (variableExpoJoueur == variableExpoValide) {
							noteJoueur=noteJoueur+3;
						} 
						else {
							noteJoueur=noteJoueur+0;
						}
						
						//Notation du diaphragme
						if (variableDiaphJoueur == variableDiaphValide) {
							noteJoueur=noteJoueur+11;
						} 
						else {
							noteJoueur=noteJoueur+0;
						}
						
						//Notation de l'obturation
						if (variableObturationJoueur == variableObturationValide) {
							noteJoueur=noteJoueur+0;
						} 
						else {
							noteJoueur=noteJoueur+0;
						}
					
					//Boutons Solution, Recommencer et Continuer en fonction de la note du joueur
					if(noteJoueur<10)
					{
						solution.btnSolution.visible=false;
						solution.btnRecommencer.visible=true;
						solution.btnContinuer.visible=false;
					}
					else
					{
						solution.btnSolution.visible=true;
						solution.btnContinuer.visible=true;
						solution.btnRecommencer.visible=false;
					}
					
					//Texte dynamique, la NOTE
					solution.resultatExercice.text = noteJoueur + " / 20";
		
				}
				
				private function recommencerExercice (e:MouseEvent):void
				{
					/*//Clip des éléments à cacher pour montrer la solution	
					var conteneur:MovieClip= new MovieClip();
					addChild(conteneur);
					
					conteneur.addChild(photo);
					conteneur.addChild(filtreBlanc); 
					conteneur.addChild(filtreNoir);
					conteneur.addChild(filtreOrange);
					conteneur.addChild(filtreBleu);
					conteneur.addChild(fond);
					conteneur.addChild(reglage);
					conteneur.addChild(_btnNote);
					conteneur.addChild(iso);
					conteneur.addChild(wb);
					conteneur.addChild(expo);
					conteneur.addChild(diaphragme);
					conteneur.addChild(obturation);
					
					conteneur.visible=true;
					
					//filtres de la même taille et à la même position que la photo
					filtreOrange.width=photo.width;
					filtreOrange.height=photo.height;
					filtreOrange.x=photo.x;
					filtreOrange.y=photo.y;
					
					filtreBleu.width=photo.width;
					filtreBleu.height=photo.height;
					filtreBleu.x=photo.x;
					filtreBleu.y=photo.y;
					
					filtreBlanc.width=photo.width;
					filtreBlanc.height=photo.height;
					filtreBlanc.x=photo.x;
					filtreBlanc.y=photo.y;
					
					
					filtreNoir.width=photo.width;
					filtreNoir.height=photo.height;
					filtreNoir.x=photo.x;
					filtreNoir.y=photo.y;
					
					//ISO par défaut
					image = new Bitmap(myBitmap);
					addChild(image);
					myBitmap.noise(Math.random()*100, 0, 150, 7,true);
					image.alpha = 0;
				
					//Solution visible
					solution.visible=false;*/
					
					//sert à définir quel bouton a été cliqué
					var texte:String = "exo41deb";
				
					//envoie un évènement avec le type du bouton et ses coordonnées
					this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
				}
				
				private function actionContinuer (e:MouseEvent):void
				{
					//sert à définir quel bouton a été cliqué
					var texte:String = "exo42deb";
				
					//envoie un évènement avec le type du bouton et ses coordonnées
					this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
				}
				
				private function donnerSolution (e:MouseEvent):void
				{
					//sert à définir quel bouton a été cliqué
					var texte:String = "solexo41deb";
				
					//envoie un évènement avec le type du bouton et ses coordonnées
					this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
				}
	}
}