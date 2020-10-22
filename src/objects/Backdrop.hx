package objects;

import zero.openfl.utilities.Game;
import zero.utilities.Color;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class Backdrop extends Sprite {

	public function new() {
		super();
		this.fill_rect(Color.PICO_8_DARK_BLUE, -0.5, -0.5, 1, 1).set_position(Game.width/2, Game.height/2);
		var resize = (?e) -> this.set_scale(Game.width, Game.height).set_position(Game.width/2, Game.height/2);
		resize.listen('resize');
		resize();
	}

}