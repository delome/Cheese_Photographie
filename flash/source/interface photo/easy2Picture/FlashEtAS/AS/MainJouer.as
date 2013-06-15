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
	
	
	public class MainJouer extends AnimationPleinEcran {
		
		//Initialisation du flou
		private var flouImage:BlurFilter = new BlurFilter();
		FilterShortcuts.init();
		
		public function MainJouer() {
						
			//tu écoutes l'ajout à la liste d'affichage
			addEventListener (Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		
		//fonction pour savoir quand le flash est ajouté au FlashConteneur
		private function addedToStageHandler (e:Event):void{
			
			
			flouImage.quality = BitmapFilterQuality.MEDIUM;
			
			//Texte "Choix de l'exercice" par défaut (non visible)
			//jeu.text_exercice.visible=false;
			
			//Niveau Débutant :
				//Bouton Débutant flou par défaut
				jeu._btnDebutant.filters = [flouImage];
				Tweener.addTween(jeu._btnDebutant, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
				
				//Ecouteur du bouton Débutant
				jeu._btnDebutant.addEventListener(MouseEvent.CLICK, choixExerciceDebutant);
				jeu._btnDebutant.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_deb);
				jeu._btnDebutant.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_deb);
				
				//Fleche qui se transforme en Main
				jeu._btnDebutant.buttonMode=true; 
			
			//Exercices Débutant :
				//Bouton exercice 1
					//Flou par défaut
					jeu.ex1_deb.filters = [flouImage] 
					Tweener.addTween(jeu.ex1_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex1_deb.x=0;
					jeu.ex1_deb.y=606;
					//Evenements sur le bouton
					jeu.ex1_deb.addEventListener(MouseEvent.CLICK, clicbouton_ex1_deb);
					jeu.ex1_deb.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex1_deb);
					jeu.ex1_deb.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex1_deb);
				
				//Bouton exercice 2
					//Flou par défaut
					jeu.ex2_deb.filters = [flouImage]
					Tweener.addTween(jeu.ex2_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex2_deb.x=150;
					jeu.ex2_deb.y=606;
					//Evenements sur le bouton
					jeu.ex2_deb.addEventListener(MouseEvent.CLICK, clicbouton_ex2_deb);
					jeu.ex2_deb.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex2_deb);
					jeu.ex2_deb.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex2_deb);
				
				//Bouton exercice 3
					//Flou par défaut
					jeu.ex3_deb.filters = [flouImage]
					Tweener.addTween(jeu.ex3_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex3_deb.x=300;
					jeu.ex3_deb.y=606;
					//Evenements sur le bouton
					jeu.ex3_deb.addEventListener(MouseEvent.CLICK, clicbouton_ex3_deb);
					jeu.ex3_deb.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex3_deb);
					jeu.ex3_deb.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex3_deb);
				
				//Bouton exercice 4
					//Flou par défaut
					jeu.ex4_deb.filters = [flouImage]
					Tweener.addTween(jeu.ex4_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex4_deb.x=450;
					jeu.ex4_deb.y=606;
					//Evenements sur le bouton
					jeu.ex4_deb.addEventListener(MouseEvent.CLICK, clicbouton_ex4_deb);
					jeu.ex4_deb.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex4_deb);
					jeu.ex4_deb.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex4_deb);
				
				//Bouton exercice 5
					//Flou par défaut
					jeu.ex5_deb.filters = [flouImage]
					Tweener.addTween(jeu.ex5_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex5_deb.x=600;
					jeu.ex5_deb.y=606;
					//Evenements sur le bouton
					jeu.ex5_deb.addEventListener(MouseEvent.CLICK, clicbouton_ex5_deb);
					jeu.ex5_deb.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex5_deb);
					jeu.ex5_deb.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex5_deb);
			
			
			
			
			//Niveau Expert :
				//Bouton Expert flou par défaut
				jeu._btnExpert.filters = [flouImage]
				Tweener.addTween(jeu._btnExpert, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
				
				//Ecouteur du bouton Expert
				jeu._btnExpert.addEventListener(MouseEvent.CLICK, choixExerciceExpert);
				jeu._btnExpert.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_exp);
				jeu._btnExpert.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_exp);
				
				//Fleche qui se transforme en Main
				jeu._btnExpert.buttonMode=true;
				
			//Exercices Expert :
				//Bouton exercice 1
					//Flou par défaut
					jeu.ex1_exp.filters = [flouImage]
					Tweener.addTween(jeu.ex1_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex1_exp.x=0;
					jeu.ex1_exp.y=606;
					//Evenements sur le bouton
					jeu.ex1_exp.addEventListener(MouseEvent.CLICK, clicbouton_ex1_exp);
					jeu.ex1_exp.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex1_exp);
					jeu.ex1_exp.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex1_exp);
					
				//Bouton exercice 2
					//Flou par défaut
					jeu.ex2_exp.filters = [flouImage]
					Tweener.addTween(jeu.ex2_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex2_exp.x=150;
					jeu.ex2_exp.y=606;
					//Evenements sur le bouton
					jeu.ex2_exp.addEventListener(MouseEvent.CLICK, clicbouton_ex2_exp);
					jeu.ex2_exp.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex2_exp);
					jeu.ex2_exp.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex2_exp);
					
				//Bouton exercice 3
					//Flou par défaut
					jeu.ex3_exp.filters = [flouImage]
					Tweener.addTween(jeu.ex3_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex3_exp.x=300;
					jeu.ex3_exp.y=606;
					//Evenements sur le bouton
					jeu.ex3_exp.addEventListener(MouseEvent.CLICK, clicbouton_ex3_exp);
					jeu.ex3_exp.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex3_exp);
					jeu.ex3_exp.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex3_exp);
					
				//Bouton exercice 4
					//Flou par défaut
					jeu.ex4_exp.filters = [flouImage]
					Tweener.addTween(jeu.ex4_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex4_exp.x=450;
					jeu.ex4_exp.y=606;
					//Evenements sur le bouton
					jeu.ex4_exp.addEventListener(MouseEvent.CLICK, clicbouton_ex4_exp);
					jeu.ex4_exp.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex4_exp);
					jeu.ex4_exp.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex4_exp);
					
				//Bouton exercice 5
					//Flou par défaut
					jeu.ex5_exp.filters = [flouImage]
					Tweener.addTween(jeu.ex5_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
					//Position par défaut du bouton
					jeu.ex5_exp.x=600;
					jeu.ex5_exp.y=606;
					//Evenements sur le bouton
					jeu.ex5_exp.addEventListener(MouseEvent.CLICK, clicbouton_ex5_exp);
					jeu.ex5_exp.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex5_exp);
					jeu.ex5_exp.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex5_exp);
			
			//Bouton Retour flou par défaut
			jeu._btnRetour.filters = [flouImage]
			Tweener.addTween(jeu._btnRetour, {_Blur_blurX:3, _Blur_blurY:3, time:0, transition:"linear"});
			
			//Evenements sur le bouton Retour
			jeu._btnRetour.addEventListener(MouseEvent.CLICK ,chargementRetour);
			jeu._btnRetour.addEventListener(MouseEvent.MOUSE_OVER, bouton_over_retour);
			jeu._btnRetour.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_retour);
			
			//ecoute si l'animation a été déchargée
			this.addEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);			
		}
		
		
		
		//fonction chargée de supprimer les intéractions lorsque l'animation est déchargée
		private function desactiverAnim (e:Event):void{
			
			//on supprime tous les écouteurs
			jeu._btnDebutant.removeEventListener(MouseEvent.CLICK, choixExerciceDebutant);
			jeu._btnDebutant.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_deb);
			jeu._btnDebutant.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_deb);
			
			jeu.ex1_deb.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex1_deb);
			jeu.ex1_deb.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex1_deb);
			
			jeu.ex2_deb.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex2_deb);
			jeu.ex2_deb.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex2_deb);
			
			jeu.ex3_deb.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex3_deb);
			jeu.ex3_deb.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex3_deb);
			
			jeu.ex4_deb.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex4_deb);
			jeu.ex4_deb.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex4_deb);
			
			jeu.ex5_deb.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex5_deb);
			jeu.ex5_deb.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex5_deb);
			
			
			jeu._btnExpert.removeEventListener(MouseEvent.CLICK, choixExerciceExpert);
			jeu._btnExpert.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_exp);
			jeu._btnExpert.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_exp);
			
			jeu.ex1_exp.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex1_exp);
			jeu.ex1_exp.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex1_exp);
			
			jeu.ex2_exp.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex2_exp);
			jeu.ex2_exp.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex2_exp);
			
			jeu.ex3_exp.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex3_exp);
			jeu.ex3_exp.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex3_exp);
			
			jeu.ex4_exp.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex4_exp);
			jeu.ex4_exp.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex4_exp);
			
			jeu.ex5_exp.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_ex5_exp);
			jeu.ex5_exp.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_ex5_exp);
			
			jeu._btnRetour.removeEventListener(MouseEvent.CLICK ,chargementRetour);
			jeu._btnRetour.removeEventListener(MouseEvent.MOUSE_OVER, bouton_over_retour);
			jeu._btnRetour.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_retour);
			
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE,desactiverAnim);
		}
		
		
		
		//Fonctions Niveau Débutant :
			private function choixExerciceDebutant(e:MouseEvent):void 
			{
				//Texte "Choix de l'exercice" visible
				jeu.text_exercice.visible=true;
				
				//Bouton Expert flou quand on a cliqué sur Débutant
				Tweener.addTween(jeu._btnExpert, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
				
				//Position des boutons exercices débutant (visible)
				Tweener.addTween(jeu.ex1_deb, {x:0, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex2_deb, {x:150, y:474.7, time:0.5, transition:"linear"});//41.3
				Tweener.addTween(jeu.ex3_deb, {x:300, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex4_deb, {x:450, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex5_deb, {x:600, y:474.7, time:0.5, transition:"linear"});
				
				//Position des boutons exercices expert (invisible)
				Tweener.addTween(jeu.ex1_exp, {x:0, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex2_exp, {x:150, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex3_exp, {x:300, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex4_exp, {x:450, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex5_exp, {x:600, y:606, time:0.5, transition:"linear"});
				
				jeu._btnDebutant.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_deb);
				jeu._btnExpert.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_exp);
			}
		
			private function bouton_over_deb(e:MouseEvent):void 
			{
				//Bouton debutant sans flou quand la souris est dessus
				Tweener.addTween(jeu._btnDebutant, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
			}
			
			private function bouton_out_deb(e:MouseEvent):void 
			{
				//Bouton Debutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu._btnDebutant, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
			}
		
		//Fonctions Exercices Débutant :
			private function clicbouton_ex1_deb(e:MouseEvent):void{
				//sert à définir quel bouton a été cliqué
				var texte:String = "iso";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
		
			private function bouton_over_ex1_deb(e:MouseEvent):void 
			{
				//Bouton exercice 1 débutant sans flou quand la souris est dessus
				Tweener.addTween(jeu.ex1_deb, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex1_deb(e:MouseEvent):void 
			{
				//Bouton exercice 1 débutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex1_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			
			private function clicbouton_ex2_deb(e:MouseEvent):void{
				//sert à définir quel bouton a été cliqué
				var texte:String = "temp";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			private function bouton_over_ex2_deb(e:MouseEvent):void 
			{
				//Bouton exercice 2 débutant sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex2_deb, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex2_deb(e:MouseEvent):void 
			{
				//Bouton exercice 2 débutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex2_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			
			private function clicbouton_ex3_deb(e:MouseEvent):void{
				//sert à définir quel bouton a été cliqué
				var texte:String = "expo";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			private function bouton_over_ex3_deb(e:MouseEvent):void 
			{
				//Bouton exercice 3 débutant sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex3_deb, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex3_deb(e:MouseEvent):void 
			{
				//Bouton exercice 3 débutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex3_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			
			
			private function clicbouton_ex4_deb(e:MouseEvent):void{
				//sert à définir quel bouton a été cliqué
				var texte:String = "diaph";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			private function bouton_over_ex4_deb(e:MouseEvent):void 
			{
				//Bouton exercice 4 débutant sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex4_deb, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex4_deb(e:MouseEvent):void 
			{
				//Bouton exercice 4 débutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex4_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			private function clicbouton_ex5_deb(e:MouseEvent):void{
				//sert à définir quel bouton a été cliqué
				var texte:String = "obtu";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			private function bouton_over_ex5_deb(e:MouseEvent):void 
			{
				//Bouton exercice 5 débutant sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex5_deb, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex5_deb(e:MouseEvent):void 
			{
				//Bouton exercice 5 débutant avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex5_deb, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
		
		
		//Fonctions Niveau Expert :
			private function choixExerciceExpert(e:MouseEvent):void 
			{
				//Texte "Choix de l'exercice" visible
				jeu.text_exercice.visible=true;
				
				//Bouton Débutant flou quand on a cliqué sur Débutant
				Tweener.addTween(jeu._btnDebutant, {_Blur_blurX:8, _Blur_blurY:8, time:0, transition:"linear"});
				
				//Position des boutons exercices expert (visible)
				Tweener.addTween(jeu.ex1_exp, {x:0, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex2_exp, {x:150, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex3_exp, {x:300, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex4_exp, {x:450, y:474.7, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex5_exp, {x:600, y:474.7, time:0.5, transition:"linear"});
				
				//Position des boutons exercices débutant (invisible)
				Tweener.addTween(jeu.ex1_deb, {x:0, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex2_deb, {x:150, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex3_deb, {x:300, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex4_deb, {x:450, y:606, time:0.5, transition:"linear"});
				Tweener.addTween(jeu.ex5_deb, {x:600, y:606, time:0.5, transition:"linear"});
				
				jeu._btnExpert.removeEventListener(MouseEvent.MOUSE_OUT, bouton_out_exp);
				jeu._btnDebutant.addEventListener(MouseEvent.MOUSE_OUT, bouton_out_deb);
			}
			
			private function bouton_over_exp(e:MouseEvent):void 
			{
				//Bouton expert sans flou quand la souris est dessus
				Tweener.addTween(jeu._btnExpert, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
			}
			
			private function bouton_out_exp(e:MouseEvent):void 
			{
				//Bouton expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu._btnExpert, {_Blur_blurX:8, _Blur_blurY:8, time:0.4, transition:"linear"});
			}
			
		//Fonctions Exercices Expert :
			private function clicbouton_ex1_exp(e:MouseEvent):void
			{
				//sert à définir quel bouton a été cliqué
				var texte:String = "tiers";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			
			private function bouton_over_ex1_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex1_exp, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex1_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex1_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			private function clicbouton_ex2_exp(e:MouseEvent):void
			{
				//sert à définir quel bouton a été cliqué
				var texte:String = "direct";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			
			private function bouton_over_ex2_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex2_exp, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex2_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex2_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			private function clicbouton_ex3_exp(e:MouseEvent):void
			{
				//sert à définir quel bouton a été cliqué
				var texte:String = "triangle";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			
			private function bouton_over_ex3_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex3_exp, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex3_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex3_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			private function clicbouton_ex4_exp(e:MouseEvent):void
			{
				//sert à définir quel bouton a été cliqué
				var texte:String = "regard";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			
			private function bouton_over_ex4_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex4_exp, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex4_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex4_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}
			
			
			private function clicbouton_ex5_exp(e:MouseEvent):void
			{
				//sert à définir quel bouton a été cliqué
				var texte:String = "echelle";
			
				//envoie un évènement avec le type du bouton et ses coordonnées
				this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
			}
			
			private function bouton_over_ex5_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert sans flou quand la souris est dessu
				Tweener.addTween(jeu.ex5_exp, {_Blur_blurX:0, _Blur_blurY:0, time:0.6, transition:"linear"});
			}
			
			private function bouton_out_ex5_exp(e:MouseEvent):void 
			{
				//Bouton exercice 1 expert avec flou quand la souris n'est pas dessus
				Tweener.addTween(jeu.ex5_exp, {_Blur_blurX:3, _Blur_blurY:3, time:0.6, transition:"linear"});
			}

			
		private function chargementRetour (e:MouseEvent):void {
			//sert à définir quel bouton a été cliqué
			var texte:String = "accueil";
			
			//envoie un évènement avec le type du bouton et ses coordonnées
			this.dispatchEvent(new AnimationCompleteEvent(AnimationCompleteEvent.ANIMATION_COMPLETE,{texte:String(texte)}));
		}
		
		private function bouton_over_retour(e:MouseEvent):void 
		{
			//Bouton Retour sans flou quand la souris est dessus
			Tweener.addTween(jeu._btnRetour, {_Blur_blurX:0, _Blur_blurY:0, time:0.4, transition:"linear"});
		}
		
		private function bouton_out_retour(e:MouseEvent):void 
		{
			//Bouton Retour avec flou quand la souris n'est pas dessus
			Tweener.addTween(jeu._btnRetour, {_Blur_blurX:3, _Blur_blurY:3, time:0.4, transition:"linear"});
		}
	}
}