	stop();
	var racine = root.parent.root;
	var bmp:Bitmap = new  Bitmap(MovieClip(racine).maCapture1);
	affichage.addChild(bmp);
	setChildIndex(affichage.masque,this.numChildren-1);
	affichage.bmp.mask = affichage.masque;
