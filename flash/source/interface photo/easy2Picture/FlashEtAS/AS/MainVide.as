package {
	//elements graphiques
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.display.SimpleButton;
	import caurina.transitions.Tweener;

	//évènements
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.media.Sound;
	import flash.media.SoundChannel;


	//Communication serveur
	import flash.net.URLRequest;


	public class MainVide extends AnimationPleinEcran {

		private var _animation:Loader;//Animation chargée
		private var _chargement:Loader;//animation en cours de chargement
		private var _progression:TextField;//Zone de texte permettant d'afficher la progression
		private var _textFormat:TextFormat;//format du texte
		
		private var typePage:String; //pour savoir quelle page a été cliquée
		private var numeroLoader:Boolean;//permet de gérer quel compteur mettre: false --> compteur 100%, true --> décompte

		private var bouleLoader:BouleTournante;//le loader
				
			
		//constructeur
		public function MainVide() {
						
			
			//Création de la zone de progression des chargementAnimations
			_progression= new TextField();
			_textFormat=new TextFormat("Calibri",20,0xFFFFFF);
			_textFormat.align=TextFormatAlign.CENTER;
						
						
			//Zone pour l'animation dépendra du menu choisi
			_animation=new Loader();
			_chargement=new Loader();
			numeroLoader=false;
			
			
			//chargement du fichier d'intro
			chargementAnimation("./swf/Accueil.swf", "accueil");
			
		}
		
		
		
		//Fonction gerant le chargementAnimation des différentes animations:
		//En parametre : le chemin du fichier swf à charger
		//  Le nom que doit porter cette animation (permet de distinguer les différents cas dans les autres fonctions)
		private function chargementAnimation(urlAnim:String,nom:String) {
			//gestion du pourcentage affiché
			_progression.text = "0%";
			_progression.setTextFormat(_textFormat);
			
			//vérifie si l'application est chargée pour la 1ère fois ou non
			if(numeroLoader == false){
				//créé le loader et le positionne
				bouleLoader = new BouleTournante();
				addChild(bouleLoader);
				aligner(bouleLoader,CENTER_CENTER);
			}
			
			addChild(_progression);
			
			
						
			//positionnement texte de progression
			aligner(_progression,CENTER_CENTER);
			
			
			//définition de l'animation
			_chargement.name = nom;
			_chargement.load(new URLRequest(urlAnim));
			_chargement.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progression);
			_chargement.contentLoaderInfo.addEventListener(Event.COMPLETE, chargementOk);
		}
		
		
		
		// Fonction gérant la progression du chargement et la mise à jour de la zone texte
		private function progression(evt:ProgressEvent):void {
			
			var total:Number = evt.bytesTotal;
			var loaded:Number = evt.bytesLoaded;
			
			//progression en pourcentage
			var taux:Number = loaded/total;
			var temps:int = (int)(taux*100);
			
			_progression.text = (int)(taux*100) + " %";
				
			//défini le format du texte
			_progression.setTextFormat(_textFormat);

		}

		//Fonction indiquant que le chargement du fichier swf est terminé
		private function chargementOk(event:Event):void {
						
			//on supprime les écouteurs
			event.currentTarget.removeEventListener(ProgressEvent.PROGRESS, progression);
			event.currentTarget.removeEventListener(Event.COMPLETE, chargementOk);
			
			//supprime le texte de progression
			removeChild(_progression);
			
			if(numeroLoader == false){
				//supprime le loader
				Tweener.addTween(bouleLoader, {alpha:0, time:1, transition:"linear"});
				removeChild(bouleLoader);
			}
			
			//trace (_animation.name);
			
			//disparition de l'écran d'animation en fonction de l'animation
					switch(typePage){//idée de mettre un brève description dans typePage
						//page accueil
						case "debut"://Debut
							Tweener.addTween(_animation, {x:stage.stageWidth+(stage.stageWidth/4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
							
						case "jouer"://Jouer
							Tweener.addTween(_animation, {x:stage.stageWidth+(stage.stageWidth/4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
						case "aideDeb"://Aide
							Tweener.addTween(_animation, {y:stage.stageHeight+(stage.stageHeight/3), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							break;
						case "apropos"://APropos
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
						
						
						
						
						
						case "aideExp"://PageAideExpert
							Tweener.addTween(_animation, {x:stage.stageWidth+(stage.stageWidth/4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
							
													
						case "accueil"://PageAcceuil
							Tweener.addTween(_animation, {x:stage.stageWidth+(stage.stageWidth/4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
						
						
						
						case "finExo"://Page FinExo
							Tweener.addTween(_animation, {x:stage.stageWidth+(stage.stageWidth/4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});
							
							break;
						
						
						
						
						
						
						//Débutant
						/*Exo1*/
						case "iso"://Exo1Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "exo11deb"://Bouton Jouer après consigne exo1_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo11deb"://solution exo11_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo12deb"://suite consigne exo11_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo12deb"://solution exo12_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo1*/
						
	
	
	
						/*Exo2*/
						case "temp"://Exo2Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo21deb"://Bouton Jouer après consigne exo2_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "solexo21deb"://solution exo21_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo22deb"://suite consigne exo22_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo22deb"://solution exo22_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo2*/

						
						
						
						/*Exo3*/
						case "expo"://Exo3Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo31deb"://Bouton Jouer après consigne exo3_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo31deb"://solution exo31_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo32deb"://suite consigne exo32_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo32deb"://solution exo32_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo3*/
						
						
						
						
						/*Exo4*/
						case "obtu"://Exo4Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo41deb"://Bouton Jouer après consigne exo4_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo41deb"://solution exo41_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo42deb"://suite consigne exo42_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo42deb"://solution exo42_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo4*/
						
						
						
						
						/*Exo5*/
						case "diaph"://Exo5Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo51deb"://Bouton Jouer après consigne exo5_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo51deb"://solution exo51_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo52deb"://suite consigne exo52_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo52deb"://solution exo52_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo5*/
						//Fin Débutant
												
												
						
						
						
						
						
						/*//Expert
						/*Exo1*/
						case "tiers"://Exo1Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo11exp"://Bouton Jouer après consigne exo1_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "solexo11exp"://solution exo11exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo12exp"://suite consigne exo12_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo12exp"://solution exo12_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						//continuer
						case "exo13exp"://suite consigne exo13_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo13exp"://solution exo13_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo1*/
							
							
							
						
						/*Exo2*/
						case "direct"://Exo2Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo21exp"://Bouton Jouer après consigne exo2_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo21exp"://solution exo21exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo22exp"://suite consigne exo22_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo22exp"://solution exo22_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo2*/
							
							
							
						
						/*Exo3*/
						case "triangle"://Exo3Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo31exp"://Bouton Jouer après consigne exo3_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "solexo31exp"://solution exo31exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo32exp"://suite consigne exo32_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo32exp"://solution exo32_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						//continuer
						case "exo33exp"://suite consigne exo33_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo33exp"://solution exo33_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo3*/
						
						
						
						
						/*Exo4*/
						case "regard"://Exo4Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo41exp"://Bouton Jouer après consigne exo4_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "solexo41exp"://solution exo41exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo42exp"://suite consigne exo42_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo42exp"://solution exo42_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						//continuer
						case "exo43exp"://suite consigne exo43_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo43exp"://solution exo43_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo4*/
						
						
						
						
						/*Exo5*/
						case "echelle"://Exo5Consigne
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "exo51exp"://Bouton Jouer après consigne exo5_deb
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						case "solexo51exp"://solution exo51exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						
						//continuer
						case "exo52exp"://suite consigne exo52_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo52exp"://solution exo52_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						//continuer
						case "exo53exp"://suite consigne exo53_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
							
						case "solexo53exp"://solution exo53_exp
							Tweener.addTween(_animation, {x:stage.stageWidth-(stage.stageWidth*4), time:0.5, transition:"easeOutQuint", onComplete:changeAnime});

							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo5*/
						//Fin Expert
					}					
					
			
						
			//si 1ère fois que l'appli se charge
			if(numeroLoader == false){
											
				//on décharge l'animation et on la remplace par l'autre
				dechargementAnimation();
				_animation=_chargement;
				_chargement=null;
				_chargement= new Loader();
				
								
				//l'application a été chargée une 1ère fois
				numeroLoader = true;
				
				//apparition animation suivante
				_animation.alpha = 0;
				addChild(_animation);
				Tweener.addTween(_animation, {alpha:1, time:6, transition:"easeOutQuint"});
			}
			
			//ecran = _animation.name;
			
			//type classe * pour ne pas avoir de soucis de types
			var contenu:* = _animation.content;
			
			
			//positionnement
			aligner(_animation, TOP_LEFT);//par défaut, après BOTTOM_CENTER c'est true
			
			
			//contenu.addEventListener(Event.COMPLETE,finAnimation);
			//ou 
			contenu.addEventListener(AnimationCompleteEvent.ANIMATION_COMPLETE,finAnimation);
		}
		
				
				
		//Fonction qui gère la fin de l'animation
		private function finAnimation(e:AnimationCompleteEvent):void { //e:Event
			
			//on récupère le numéro correspondant à un bouton donné
			typePage = e.info.texte;//
			
			//trace(typePage);
			
						
			//fonction de l'animation
					switch(typePage){
						//Page accueil
						case "debut"://Page Debut
							chargementAnimation("./swf/Debut.swf", "debut");
							break;
							
						case "jouer"://Page Jouer
							chargementAnimation("./swf/Jouer.swf", "jouer");
							break;
							
						case "aideDeb"://Page Aide Débutant
							chargementAnimation("./swf/AideDebutant.swf", "aideDeb");
							break;
							
						case "apropos"://Page APropos
							chargementAnimation("./swf/APropos.swf", "apropos");
							break;
						
						
						//(bouton continuer)
						case "aideExp"://Page Aide Expert
							chargementAnimation("./swf/AideExpert.swf", "aideExp");
							break;
							
						//(bouton retour)
						case "accueil"://Page Accueil
							chargementAnimation("./swf/Accueil.swf", "accueil");
							break;
							
						
						//(page FinExo)
						case "finExo"://Page FinExo
							chargementAnimation("./swf/FinExo.swf", "finExo");
							break;
							
							
							
							
							
						//Débutant
						/*Exo1*/
						case "iso"://Page règle exo1_deb
							chargementAnimation("./swf/ReglesISO.swf", "iso");
							break;
						case "exo11deb"://suite consigne exo1_deb
							chargementAnimation("./swf/Exo11deb.swf", "exo11deb");
							break;
						case "solexo11deb"://solution exo11_deb
							chargementAnimation("./swf/SolutionExo11deb.swf", "solexo11deb");
							break;
						
						//continuer
						case "exo12deb"://suite consigne exo11_deb
							chargementAnimation("./swf/Exo12deb.swf", "exo12deb");
							break;
						case "solexo12deb"://solution exo12_deb
							chargementAnimation("./swf/SolutionExo12deb.swf", "solexo12deb");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo1*/
							
							
							
						
						/*Exo2*/
						case "temp"://Page règle exo1_deb
							chargementAnimation("./swf/ReglesTempCouleurs.swf", "temp");
							break;
						case "exo21deb"://suite consigne exo2_deb
							chargementAnimation("./swf/Exo21deb.swf", "exo21deb");
							break;
						case "solexo21deb"://solution exo21_deb
							chargementAnimation("./swf/SolutionExo21deb.swf", "solexo21deb");
							break;
						
						//continuer
						case "exo22deb"://suite consigne exo22_deb
							chargementAnimation("./swf/Exo22deb.swf", "exo22deb");
							break;
						case "solexo22deb"://solution exo22_deb
							chargementAnimation("./swf/SolutionExo22deb.swf", "solexo22deb");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo2*/
							
																		
						
						
						/*Exo3*/
						case "expo"://Page règle exo3_deb
							chargementAnimation("./swf/ReglesExposition.swf", "expo");
							break;
						case "exo31deb"://suite consigne exo3_deb
							chargementAnimation("./swf/Exo31deb.swf", "exo31deb");
							break;
						case "solexo31deb"://solution exo31_deb
							chargementAnimation("./swf/SolutionExo31deb.swf", "solexo31deb");
							break;
						
						//continuer
						case "exo32deb"://suite consigne exo32_deb
							chargementAnimation("./swf/Exo32deb.swf", "exo32deb");
							break;
						case "solexo32deb"://solution exo32_deb
							chargementAnimation("./swf/SolutionExo32deb.swf", "solexo32deb");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo3*/
						
						
						
						
						/*Exo4*/
						case "obtu"://Page règle exo4_deb
							chargementAnimation("./swf/ReglesObturation.swf", "obtu");
							break;
						case "exo41deb"://suite consigne exo4_deb
							chargementAnimation("./swf/Exo41deb.swf", "exo41deb");
							break;
						case "solexo41deb"://solution exo41_deb
							chargementAnimation("./swf/SolutionExo41deb.swf", "solexo41deb");
							break;
						
						//continuer
						case "exo42deb"://suite consigne exo42_deb
							chargementAnimation("./swf/Exo42deb.swf", "exo42deb");
							break;
						case "solexo42deb"://solution exo42_deb
							chargementAnimation("./swf/SolutionExo42deb.swf", "solexo42deb");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo4*/
							
							
							
							
						/*Exo5*/
						case "diaph"://Page règle exo5_deb
							chargementAnimation("./swf/ReglesDiaph.swf", "diaph");
							break;
						case "exo51deb"://suite consigne exo5_deb
							chargementAnimation("./swf/Exo51deb.swf", "exo51deb");
							break;
						case "solexo51deb"://solution exo51_deb
							chargementAnimation("./swf/SolutionExo51deb.swf", "solexo51deb");
							break;
						
						//continuer
						case "exo52deb"://suite consigne exo52_deb
							chargementAnimation("./swf/Exo52deb.swf", "exo52deb");
							break;
						case "solexo52deb"://solution exo52_deb
							chargementAnimation("./swf/SolutionExo52deb.swf", "solexo52deb");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo5*/
						//Fin Débutant
							
							
							
							
							
						
						//Expert
						/*Exo1*/
						case "tiers"://Page règle exo1_exp
							chargementAnimation("./swf/ReglesTiers.swf", "tiers");
							break;
						case "exo11exp"://suite consigne exo1_exp
							chargementAnimation("./swf/Exo11exp.swf", "exo11exp");
							break;
						case "solexo11exp"://solution exo11_exp
							chargementAnimation("./swf/SolutionExo11exp.swf", "solexo11exp");
							break;
						
						//continuer
						case "exo12exp"://suite consigne exo12_exp
							chargementAnimation("./swf/Exo12exp.swf", "exo12exp");
							break;
						case "solexo12exp"://solution exo12_exp
							chargementAnimation("./swf/SolutionExo12exp.swf", "solexo12exp");
							break;
							
						//continuer
						case "exo13exp"://suite consigne exo13_exp
							chargementAnimation("./swf/Exo13exp.swf", "exo13exp");
							break;
						case "solexo13exp"://solution exo13_exp
							chargementAnimation("./swf/SolutionExo13exp.swf", "solexo13exp");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo1*/
						
						
						
						
						/*Exo2*/
						case "direct"://Page règle exo2_exp
							chargementAnimation("./swf/ReglesLignesDirectrices.swf", "direct");
							break;
						case "exo21exp"://suite consigne exo2_exp
							chargementAnimation("./swf/Exo21exp.swf", "exo21exp");
							break;
						case "solexo21exp"://solution exo21_exp
							chargementAnimation("./swf/SolutionExo21exp.swf", "solexo21exp");
							break;
						
						//continuer
						case "exo22exp"://suite consigne exo22_exp
							chargementAnimation("./swf/Exo22exp.swf", "exo22exp");
							break;
						case "solexo22exp"://solution exo22_exp
							chargementAnimation("./swf/SolutionExo22exp.swf", "solexo22exp");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo2*/
							
							
							
							
						/*Exo3*/
						case "triangle"://Page règle exo3_exp
							chargementAnimation("./swf/ReglesCompoTriangulaire.swf", "triangle");
							break;
						case "exo31exp"://suite consigne exo3_exp
							chargementAnimation("./swf/Exo31exp.swf", "exo31exp");
							break;
						case "solexo31exp"://solution exo31_exp
							chargementAnimation("./swf/SolutionExo31exp.swf", "solexo31exp");
							break;
						
						//continuer
						case "exo32exp"://suite consigne exo32_exp
							chargementAnimation("./swf/Exo32exp.swf", "exo32exp");
							break;
						case "solexo32exp"://solution exo32_exp
							chargementAnimation("./swf/SolutionExo32exp.swf", "solexo32exp");
							break;
							
						//continuer
						case "exo33exp"://suite consigne exo33_exp
							chargementAnimation("./swf/Exo33exp.swf", "exo33exp");
							break;
						case "solexo33exp"://solution exo33_exp
							chargementAnimation("./swf/SolutionExo33exp.swf", "solexo33exp");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo3*/
							
							
						
						
						/*Exo4*/
						case "regard"://Page règle exo4_exp
							chargementAnimation("./swf/ReglesRegard.swf", "regard");
							break;
						case "exo41exp"://suite consigne exo4_exp
							chargementAnimation("./swf/Exo41exp.swf", "exo41exp");
							break;
						case "solexo41exp"://solution exo41_exp
							chargementAnimation("./swf/SolutionExo41exp.swf", "solexo41exp");
							break;
						
						//continuer
						case "exo42exp"://suite consigne exo42_exp
							chargementAnimation("./swf/Exo42exp.swf", "exo42exp");
							break;
						case "solexo42exp"://solution exo42_exp
							chargementAnimation("./swf/SolutionExo42exp.swf", "solexo42exp");
							break;
							
						//continuer
						case "exo43exp"://suite consigne exo43_exp
							chargementAnimation("./swf/Exo43exp.swf", "exo43exp");
							break;
						case "solexo43exp"://solution exo43_exp
							chargementAnimation("./swf/SolutionExo43exp.swf", "solexo43exp");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo4*/
							
							
							
							
						/*Exo5*/
						case "echelle"://Page règle exo5_exp
							chargementAnimation("./swf/ReglesEchellesPlan.swf", "echelle");
							break;
						case "exo51exp"://suite consigne exo5_exp
							chargementAnimation("./swf/Exo51exp.swf", "exo51exp");
							break;
						case "solexo51exp"://solution exo51_exp
							chargementAnimation("./swf/SolutionExo51exp.swf", "solexo51exp");
							break;
						
						//continuer
						case "exo52exp"://suite consigne exo52_exp
							chargementAnimation("./swf/Exo52exp.swf", "exo52exp");
							break;
						case "solexo52exp"://solution exo52_exp
							chargementAnimation("./swf/SolutionExo52exp.swf", "solexo52exp");
							break;
							
						//continuer
						case "exo53exp"://suite consigne exo53_exp
							chargementAnimation("./swf/Exo53exp.swf", "exo53exp");
							break;
						case "solexo53exp"://solution exo53_exp
							chargementAnimation("./swf/SolutionExo53exp.swf", "solexo53exp");
							break;
						//après c'est de nouveau case jouer quand on clique sur continuer
						/*Fin Exo5*/
						//Fin Expert	
					}				
					
			
			//on lance le déchargement de l'animation
			//dechargementAnimation();
		}
		
		//Fonction permettant de décharger une animation
		private function dechargementAnimation() {
			
			//type classe * pour ne pas avoir de soucis de types
			var contenu:* = _animation.content;
			
			//on vérifie si le contenu a un écouteur et si oui, on l'enlève
			if(contenu && contenu.hasEventListener(AnimationCompleteEvent.ANIMATION_COMPLETE)){//Event.COMPLETE
				//contenu.removeEventListener(Event.COMPLETE,finAnimation);
				//ou
				contenu.removeEventListener(AnimationCompleteEvent.ANIMATION_COMPLETE,finAnimation);
			}
			
			//déchargement de l'animation
			//_animation.unload();
			
			//teste si l'animation a un parent
			if(_animation.parent){
				removeChild(_animation);
			}
			
		}
		
		
				
		//fonction changeAnim
		function changeAnime():void{
			//on remet le type du bouton à 0
			typePage="";
			
			//on décharge l'animation et on supprime le nuage
			dechargementAnimation();
			_animation=_chargement;
			_chargement=null;
			_chargement= new Loader();
						
			//chargement animation suivante
			_animation.alpha = 0;
			addChild(_animation);
			Tweener.addTween(_animation, {alpha:1, time:0.4, transition:"easeOutQuint"});
			
			//type classe * pour ne pas avoir de soucis de types
			var contenu:* = _animation.content;
			
			//ajout de l'écouteur de dispatch
			contenu.addEventListener(AnimationCompleteEvent.ANIMATION_COMPLETE,finAnimation);
		}
	}
}