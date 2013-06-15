﻿package 
{
	import flash.display.Sprite;
	//import flash.events.MouseEvent.MOUSE_WHEEL;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Loader;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.ui.ContextMenuItem;
	import flash.ui.*;
	import fl.motion.MatrixTransformer;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import caurina.transitions.properties.FilterShortcuts;
	import flash.filters.*;
	import caurina.transitions.Tweener;
	import Carre;
	
	
	public class Exo13exp extends AnimationPleinEcran
	{
		private var espacePhoto:MovieClip;
		private var limites:Carre; //Limites du déplacement du cadre dans la photo
		private var valeurZoom:Number; 
		private var valeurFocus:Number; 
		private var valeurExpo:Number; 
		private var valeurTemperature:Number; 
		
		private var noteFinale:int;
		private var doubleSolution:Boolean; 
		
		private var valeurParfaiteX:int;
		private var valeurParfaiteY:int;
		private var valeurParfaiteZoom:int;
		
		private var valeurParfaiteXBis:int;
		private var valeurParfaiteYBis:int;
		private var valeurParfaiteZoomBis:int;
		
		private var valeurJoueurX:int;
		private var valeurJoueurY:int;
		private var valeurJoueurZoom:int;
		
		private var flouImage:BlurFilter = new BlurFilter();

		
		var bd:Bitmap;
		var bmd:BitmapData;
		var m:Matrix;
		var re:Rectangle;
		

		
		public function Exo13exp()
		{
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			
						
			//GESTION DE LA NOTE DU JOUEUR
			
			noteFinale = 0;
			
			valeurZoom=66;
			
			doubleSolution=true; 
			//false = 1 solution
			//true = 2 solutions (portrait / paysage)
			
			valeurParfaiteX=-397; //valeur de X du cadrage parfait
			valeurParfaiteY=-206; //valeur de Y du cadrage parfait
			valeurParfaiteZoom=62; //valeur de Zoom du cadrage parfait
			
			valeurParfaiteXBis=164; //valeur de X du cadrage parfait (deuxième solution)
			valeurParfaiteYBis=-189; //valeur de Y du cadrage parfait (deuxième solution)
			valeurParfaiteZoomBis=84; //valeur de Zoom du cadrage parfait (deuxième solution)
			
			valeurJoueurX=new int(); //valeur de X du cadrage du joueur
			valeurJoueurY=new int(); //valeur de Y du cadrage du joueur
			valeurJoueurZoom=new int(); //valeur de Zoom du cadrage du joueur
			
			
			//--GESTION DU ZOOM / ROTATION / ORIENTATION--
			
			photo.getChildAt(0).x = - photo.width/2;
			photo.getChildAt(0).y = - photo.height/2;
			photo.x=400;
			photo.y=300;
			photo.scaleX=0.5;
			photo.scaleY=0.5;
			
			
			textZoom.text=""+valeurZoom+"";
			//monCadre.addChild(textZoom);
			//textZoom.x=307;
			//textZoom.y=307;
			
			stage.focus = this;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, zoom); 
			//stage.addEventListener(MouseEvent.MOUSE_WHEEL, zoomd); 
			
			
			
			//--GESTION DU DEPLACEMENT DE LA SOURIS ET DU CADRE--

			Mouse.hide();
			surfacePhoto.alpha=0;
			espacePhoto = new MovieClip();
			limites = new Carre();
			limites.alpha=0;
			
			addChild(espacePhoto);
			espacePhoto.addChild(limites);
			espacePhoto.getChildAt(0).x = - espacePhoto.width/2;
			espacePhoto.getChildAt(0).y = - espacePhoto.height/2;
			espacePhoto.x=photo.x+monCadre.width/4;
			espacePhoto.y=photo.y-40;
			espacePhoto.height=320;
			espacePhoto.width=photo.width-monCadre.width*0.5;
			
			
			monCadre.startDrag(true);
			//monCadre.getChildAt(0).x = - monCadre.width/2;
			//monCadre.getChildAt(0).y = - monCadre.height/2;
			monCadre.addEventListener(MouseEvent.MOUSE_DOWN, changerPoint); 
			monCadre.addEventListener(MouseEvent.MOUSE_UP, remettrePoint); 
			addChild(monCadre);
			
			//espacePhoto.addEventListener(MouseEvent.ROLL_OUT, horsCadre); 
			
			
			
			
			//--GESTION DU DEPLACEMENT DE LA PHOTO--
			addChild(btnDroit);
			addChild(btnGauche);
			addChild(btnHaut);
			addChild(btnBas);
			
			btnDroit.alpha=0;
			btnGauche.alpha=0;
			btnHaut.alpha=0;
			btnBas.alpha=0;
			
			
				
				btnHaut.addEventListener(MouseEvent.ROLL_OVER, versHaut); 
				btnBas.addEventListener(MouseEvent.ROLL_OVER, versBas); 
			
				btnGauche.addEventListener(MouseEvent.ROLL_OVER, versGauche); 
				btnDroit.addEventListener(MouseEvent.ROLL_OVER, versDroit); 
			
			
			
			
			
			
			
			
			

			
			
			//--GESTION DE LA PRISE DE PHOTO--
			
			stage.addEventListener(MouseEvent.CLICK, prendrePhoto);
			
			
			
			
			FilterShortcuts.init();
			
			btnSolution.visible=false;
			btnRecommencer.visible=false;
			btnContinuer.visible=false;
			
			btnSolution.filters = [flouImage];
			btnRecommencer.filters = [flouImage];
			btnContinuer.filters = [flouImage];
			Tweener.addTween(btnSolution, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			Tweener.addTween(btnRecommencer, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			Tweener.addTween(btnContinuer, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			
			btnSolution.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_solution);
			btnSolution.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_solution);
			btnSolution.addEventListener(MouseEvent.MOUSE_DOWN, donnerSolution);
			
			btnRecommencer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_recommencer);
			btnRecommencer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_recommencer);
			btnRecommencer.addEventListener(MouseEvent.MOUSE_DOWN, recommencer);
			
			btnContinuer.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_continuer);
			btnContinuer.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_continuer);
			btnContinuer.addEventListener(MouseEvent.MOUSE_DOWN, actionContinuer);
			
			
		}
		
		private function recommencer(evt:Event):void
		{
			textZoom.visible=true;
			stringZoom.visible=true;
			photo.visible=true; 
			monCadre.visible=true;
			Mouse.hide();
			bd.visible=false;
			bd.visible=false;
			textNote.visible=false;
			btnRecommencer.visible=false;
			btnSolution.visible=false;
			photo.x=400;
			photo.y=300;
			photo.scaleX=0.5;
			photo.scaleY=0.5;
			valeurZoom=66;
			monCadre.rotation=0;
			
			noteFinale=0;
			
			stage.addEventListener(MouseEvent.CLICK, prendrePhoto);
			monCadre.addEventListener(MouseEvent.MOUSE_DOWN, changerPoint); 
			monCadre.addEventListener(MouseEvent.MOUSE_UP, remettrePoint); 
		}
		
		private function donnerSolution(evt:Event):void{
			//sert à définir quel bouton a été cliqué
			var texte:String = "solexo13exp";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		private function actionContinuer(evt:Event):void{
			//sert à définir quel bouton a été cliqué
			var texte:String = "finExo";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		private function bouton_over_solution(evt:Event):void
		{
			Tweener.addTween(btnSolution, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_over_recommencer(evt:Event):void
		{
			Tweener.addTween(btnRecommencer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_over_continuer(evt:Event):void
		{
			Tweener.addTween(btnContinuer, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_solution(evt:Event):void
		{
			Tweener.addTween(btnSolution, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_recommencer(evt:Event):void
		{
			Tweener.addTween(btnRecommencer, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_continuer(evt:Event):void
		{
			Tweener.addTween(btnContinuer, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}
		
		
		private function changerPoint(evt:Event):void //Fonction appellant la fonction getBitmapdata et affichant l'image capturée
		{
			monCadre.getChildAt(0).x = - monCadre.width/2;
			monCadre.getChildAt(0).y = - monCadre.height/2;
			
			
			
		}
		
		private function remettrePoint(evt:Event):void //Fonction appellant la fonction getBitmapdata et affichant l'image capturée
		{
			monCadre.getChildAt(0).x =  0;
			monCadre.getChildAt(0).y =  0;
			
			
		}
		
		private function prendrePhoto(evt:Event):void //Fonction appellant la fonction getBitmapdata et affichant l'image capturée
		{
			stage.removeEventListener(MouseEvent.CLICK, prendrePhoto);
			valeurJoueurX=photo.mouseX;
			valeurJoueurY=photo.mouseY;
			valeurJoueurZoom=valeurZoom;
			
			var monURL:String = "./swf/photo.mp3";
				var requete:URLRequest = new URLRequest(monURL);
				var monSon:Sound = new Sound();
				monSon.load(requete);
				monSon.play();
			
			
			re = monCadre.getBounds(monCadre);
			re.width=re.width-70;
			//re.rotation=monCadre.rotation;
			bmd = new BitmapData(re.width, re.height, true, 0);
			bd = new Bitmap(bmd);
			if(monCadre.rotation>45)
			{
				bd.rotation=90;
				bd.x = 525;
				bd.y = 100;
			}
			else
			{
				bd.x=230;
				bd.y=180;
			}
			addChild(bd);
			
			//Disparition du cadre et de la photo
			textZoom.visible=false;
			stringZoom.visible=false;
			photo.visible=false; 
			monCadre.visible=false;
			textNote.visible=true;
			Mouse.show();
			
			
			drawClip();			
			calculeNote();		
		}
		
		private function drawClip():void 
		{			m = new Matrix();
			m.scale((photo.scaleX), (photo.scaleY));
			/*if(monCadre.rotation==90)
			{
				m.translate((photo.x-monCadre.x-monCadre.width/2), (photo.y-monCadre.y-monCadre.height/2));
				MatrixTransformer.rotateAroundExternalPoint(m,photo.x-monCadre.x-monCadre.height/2,photo.y-monCadre.y-monCadre.width/2, monCadre.rotation);
				
			}
			else
			{*/
				re = monCadre.getBounds(monCadre);
			
			m.translate((photo.x - monCadre.x-re.x), (photo.y - monCadre.y-re.y));
			//}
			
			m.rotate(-(Math.PI*monCadre.rotation/180));
			
			bmd.fillRect(bmd.rect, 0);
			bmd.draw(photo, m);
		}
		
		private function calculeNote():void 
		{	
			trace(valeurJoueurX);
			trace(valeurJoueurY);
			trace(valeurJoueurZoom);
			
			var noteX:int = new int(); //Ecart entre la valeur de X du cadrage parfait et celle du joueur
			var noteY:int = new int(); //Ecart entre la valeur de Y du cadrage parfait et celle du joueur
			var noteZoom:int = new int(); //Ecart entre la valeur de Zoom du cadrage parfait et celle du joueur
			
			if(doubleSolution==false) // Cas ou l'exercice ne propose qu'une seule solution
			{
				if(monCadre.rotation==90) // Cas ou le joueur ne choisi pas la bonne orientation
				{
					noteX=valeurParfaiteX-valeurJoueurX;
					noteY=valeurParfaiteY-valeurJoueurY;
					noteZoom=valeurParfaiteZoom-valeurJoueurZoom;
					noteFinale=-3;
				}
				else // Cas ou le joueur choisi la bonne orientation
				{
					noteX=valeurParfaiteX-valeurJoueurX;
					noteY=valeurParfaiteY-valeurJoueurY;
					noteZoom=valeurParfaiteZoom-valeurJoueurZoom;
					
				}
				if(monCadre.rotation>4 && monCadre.rotation<86 || monCadre.rotation<-4 && monCadre.rotation>-86) // Cas ou le joueur ne choisi pas la bonne orientation
				{
					noteX=valeurParfaiteX-valeurJoueurX;
					noteY=valeurParfaiteY-valeurJoueurY;
					noteZoom=valeurParfaiteZoom-valeurJoueurZoom;
					noteFinale=-2;
				}
			}
			else // Cas ou l'exercice propose deux solution
			{
				if(monCadre.rotation==90) // Calcul de la note selon la solution portrait
				{
					noteX=valeurParfaiteXBis-valeurJoueurX;
					noteY=valeurParfaiteYBis-valeurJoueurY;
					noteZoom=valeurParfaiteZoomBis-valeurJoueurZoom;
				}
				else // Calcul de la note selon la solution paysage
				{
					noteX=valeurParfaiteX-valeurJoueurX;
					noteY=valeurParfaiteY-valeurJoueurY;
					noteZoom=valeurParfaiteZoom-valeurJoueurZoom;
				}	
				if(monCadre.rotation>4 && monCadre.rotation<86 || monCadre.rotation<-4 && monCadre.rotation>-86) // Cas ou le joueur ne choisi pas la bonne orientation
				{
					noteX=valeurParfaiteX-valeurJoueurX;
					noteY=valeurParfaiteY-valeurJoueurY;
					noteZoom=valeurParfaiteZoom-valeurJoueurZoom;
					noteFinale=-2;
				}
			}
			
			var noteFinaleX:int = new int(); // Note sur 5 points sur la cadrage X du joueur
			var noteFinaleY:int = new int(); // Note sur 5 points sur la cadrage Y du joueur
			var noteFinaleZoom:int = new int(); // Note sur 5 points sur la valeur du Zoom du joueur
			
			trace("noteX : "+noteX);
			trace("noteY : "+noteY);
			trace("noteZoom : "+noteZoom);
			
			// Conditions permettant de convertir l'écrart entre deux valeurs en une note sur 5.
			
			// Pour les X :
			/*
			if(noteX<=20 || noteX>=-20)
			{
				noteFinaleX=5;
			}
			if(noteX>=40 || noteX<=-40)
			{
				noteFinaleX=4;
			}
			if(noteX>=60 || noteX<=-60)
			{
				noteFinaleX=3;
			}
			if(noteX>=80 || noteX<=-80)
			{
				noteFinaleX=2;
			}
			if(noteX>=100 || noteX<=-100)
			{
				noteFinaleX=2;
			}
			if(noteX>=120 || noteX<=-120)
			{
				noteFinaleX=1;
			}
			if(noteX>=140 || noteX<=-140)
			{
				noteFinaleX=0;
			}
			trace (noteFinaleX);
			*/
			
			
			// Pour les Y :
			if(noteY<=10 || noteY>=-10)
			{
				noteFinaleY=5;
			}
			if(noteY>=10 || noteY<=-10)
			{
				noteFinaleY=4;
			}
			if(noteY>=20 || noteY<=-20)
			{
				noteFinaleY=3;
			}
			if(noteY>=30 || noteY<=-30)
			{
				noteFinaleY=2;
			}
			if(noteY>=40 || noteY<=-40)
			{
				noteFinaleY=2;
			}
			if(noteY>=50 || noteY<=-50)
			{
				noteFinaleY=1;
			}
			if(noteY>=60 || noteY<=-60)
			{
				noteFinaleY=0;
			}
			trace (noteFinaleY);
			
			
			// Pour le Zoom :
			if(noteZoom<=10 || noteZoom>=-10)
			{
				noteFinaleZoom=5;
			}
			if(noteZoom>=10 || noteZoom<=-10)
			{
				noteFinaleZoom=4;
			}
			if(noteZoom>=20 || noteZoom<=-20)
			{
				noteFinaleZoom=3;
			}
			if(noteZoom>=30 || noteZoom<=-30)
			{
				noteFinaleZoom=2;
			}
			if(noteZoom>=40 || noteZoom<=-40)
			{
				noteFinaleZoom=2;
			}
			if(noteZoom>=50 || noteZoom<=-50)
			{
				noteFinaleZoom=1;
			}
			if(noteZoom>=60 || noteZoom<=-60)
			{
				noteFinaleZoom=0;
			}
			trace (noteFinaleZoom);
			
			noteFinale=(noteFinale+((noteFinaleY*2+noteFinaleZoom)/3)*4); // Calcul de la note sur 20 d'après les trois notes sur 5 calculées précedemment
			trace("vous avez : "+noteFinale+"/20");
			
			if(noteFinale<0)
			{
				noteFinale=0;
			}
			
			textNote.text="VOTRE NOTE : "+noteFinale+"/20"; // Affichage de la note
			
			if(noteFinale<10)
			{
				
				addChild(btnRecommencer);
				
				
				btnRecommencer.visible=true;
				
				
			}
			else
			{
				addChild(btnSolution);
				addChild(btnContinuer);
				
				btnSolution.visible=true;
				btnContinuer.visible=true;
			}
		}
		
		private function versGauche(evt:Event):void // Déplace la photo vers la gauche
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, versGauche);
			if(photo.width>surfacePhoto.width)
			{
				Tweener.addTween(photo, {x:-(surfacePhoto.x-photo.width/2), time:valeurZoom/40, transition:"linear"});
			}
			if(photo.width<surfacePhoto.width && photo.x>(surfacePhoto.x-photo.width/2))
			{
				Tweener.addTween(photo, {x:(surfacePhoto.width/2), time:valeurZoom/40, transition:"linear"});
			}
			
			
			btnGauche.addEventListener(MouseEvent.ROLL_OUT, stopDefilement); 
		}
		
		private function versDroit(evt:Event):void // Déplace la photo vers la droite
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, versDroit);
			if(photo.width>surfacePhoto.width)
			{
				Tweener.addTween(photo, {x:(surfacePhoto.x+surfacePhoto.width-photo.width/2), time:valeurZoom/40, transition:"linear"});
			}
			if(photo.width<surfacePhoto.width && photo.x>-(surfacePhoto.x-photo.width/2))
			{
				Tweener.addTween(photo, {x:(surfacePhoto.width/2), time:valeurZoom/40, transition:"linear"});
			}
			btnDroit.addEventListener(MouseEvent.ROLL_OUT, stopDefilement); 
		}
		
		private function versHaut(evt:Event):void // Déplace la photo vers la gauche
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, versHaut);
			if(photo.height>surfacePhoto.height)
			{
				Tweener.addTween(photo, {y:(surfacePhoto.y+photo.height/2), time:valeurZoom/40, transition:"linear"});
			}
			if(photo.height<surfacePhoto.height && photo.y>(surfacePhoto.y-photo.height/2))
			{
				Tweener.addTween(photo, {y:(surfacePhoto.y+surfacePhoto.height/2), time:valeurZoom/40, transition:"linear"});
			}
			btnHaut.addEventListener(MouseEvent.ROLL_OUT, stopDefilement); 
		}
		
		private function versBas(evt:Event):void // Déplace la photo vers la droite
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, versBas);
			if(photo.height>surfacePhoto.height)
			{
				Tweener.addTween(photo, {y:(surfacePhoto.y+surfacePhoto.height-photo.height/2), time:valeurZoom/40, transition:"linear"});
			}
			if(photo.height<surfacePhoto.height && photo.y>-(surfacePhoto.y-photo.height/2))
			{
				Tweener.addTween(photo, {y:(surfacePhoto.y+surfacePhoto.height/2), time:valeurZoom/40, transition:"linear"});
			}
			btnBas.addEventListener(MouseEvent.ROLL_OUT, stopDefilement); 
		}
		
		private function stopDefilement(evt:Event):void // Arrete le défilement de la photo (gauche et droite)
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OUT, versGauche);
			Tweener.removeTweens(photo);
			btnGauche.addEventListener(MouseEvent.ROLL_OVER, versGauche); 
			btnDroit.addEventListener(MouseEvent.ROLL_OVER, versDroit); 
			btnHaut.addEventListener(MouseEvent.ROLL_OVER, versHaut); 
			btnBas.addEventListener(MouseEvent.ROLL_OVER, versBas); 
		}
		
		private function horsCadre(evt:Event):void // Gère la réaparition de la souris et le bloquage du cadre lorsque la souris sort des limites de la photo
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OUT, horsCadre);
			Mouse.show();
			monCadre.stopDrag();
			espacePhoto.addEventListener(MouseEvent.ROLL_OVER, inCadre);
		}
		
		private function inCadre(evt:Event):void // Gère la disparition de la souris et le débloquage du cadre
		{
			evt.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, inCadre);
			Mouse.hide();
			monCadre.startDrag(true);
			espacePhoto.addEventListener(MouseEvent.ROLL_OUT, horsCadre); 
		}
		
		private function zoom(evt:KeyboardEvent):void // Gère le zoom, la rotation et l'orientation du cadre.
		{
			
			switch(evt.keyCode)
			{
				// ZOOM :
				case Keyboard.UP:
					if(valeurZoom<150)
					{
					photo.scaleX=photo.scaleX+0.02;
					photo.scaleY=photo.scaleY+0.02;
					valeurZoom=valeurZoom+2;
					textZoom.text=""+valeurZoom+"";
					}
					else
					{
						photo.scaleX=photo.scaleX;
						photo.scaleY=photo.scaleY;
					}
					break;
					
				// DEZOOM :
				case Keyboard.DOWN:
					if(photo.width>photo.height)
					{
						if(monCadre.height<photo.height)
						{
							photo.scaleX=photo.scaleX-0.02;
							photo.scaleY=photo.scaleY-0.02;
							valeurZoom=valeurZoom-2;
							textZoom.text=""+valeurZoom+"";
						}
						else
						{
							photo.scaleX=photo.scaleX;
							photo.scaleY=photo.scaleY;
						}
					}
					else
					{
						if(monCadre.width-58<photo.width || monCadre.height<photo.width)
						{
							photo.scaleX=photo.scaleX-0.02;
							photo.scaleY=photo.scaleY-0.02;
							valeurZoom=valeurZoom-2;
							textZoom.text=""+valeurZoom+"";
						}
						else
						{
							photo.scaleX=photo.scaleX;
							photo.scaleY=photo.scaleY;
						}
					}
					
						 break;
						 
				// PORTRAIT / PAYSAGE :
				case Keyboard.SPACE:
					if(monCadre.rotation==0)
					{
						monCadre.rotation=90;
					}
					else
					{
						monCadre.rotation=0;
					}
					break;
					
				//ROTATION GAUCHE : 
				case Keyboard.LEFT:
					monCadre.rotation=monCadre.rotation+1;
					break;
					
				//ROTATION DROITE : 
				case Keyboard.RIGHT:
					monCadre.rotation=monCadre.rotation-1;
					break;
			}
			
		}
		
		
		/*
		private function zoomd(evt:MouseEvent):void // Gère le zoom, la rotation et l'orientation du cadre.
		{
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, zoomd);
			
						trace("yeah")
						trace(evt.delta);
						photo.scaleX=photo.scaleX-evt.delta*0.02;
						photo.scaleY=photo.scaleY-evt.delta*0.02;
						valeurZoom=valeurZoom-2;
						textZoom.text=""+valeurZoom+"";
						/*
						espacePhoto.x=photo.x;
						espacePhoto.y=photo.y;
						espacePhoto.height=photo.height-monCadre.height;
						espacePhoto.width=photo.width-monCadre.width;
						*/
					
		//}
		

		
	}
}