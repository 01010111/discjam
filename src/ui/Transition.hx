package ui;

import zero.utilities.Timer;
import zero.utilities.Ease;
import zero.utilities.Tween;
import zero.openfl.utilities.Game;
import zero.utilities.Color;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;

class Transition extends Sprite {
	
	public function new() {
		super();
		for (i in 0...16) {
			var bar = new Sprite().fill_rect(Color.BLACK, 0, i * (720/16), 1280, 720/8);
			Tween.get(bar).from_to('x', 0, 1280).ease(Ease.quadOut).delay(i * 0.05).duration(0.25);
			addChild(bar);
		}
	}

}