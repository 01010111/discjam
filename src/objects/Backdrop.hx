package objects;

import zero.openfl.utilities.Game;
import zero.utilities.Color;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class Backdrop extends Sprite {

	public function new() {
		super();
		this.load_graphic('assets/bg.png', MIDDLE_CENTER, true);
		var resize = (?e) -> this.set_scale(Game.width/1280, Game.height/720).set_position(Game.width/2, Game.height/2);
		resize.listen('resize');
		resize();
	}

}