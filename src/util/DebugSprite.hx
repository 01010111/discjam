package util;

import zero.utilities.Color;
import openfl.display.Sprite;
using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class DebugSprite extends Sprite {
	
	public function new() {
		super();
		draw_shape.listen('draw_debug');
		clear.listen('preupdate');
		this.circle(Color.PICO_8_RED, 100, 100, 100, 2);
	}

	function clear(?_) {
		graphics.clear();
	}
	
	function draw_shape(?input:{ x:Float, y:Float, r:Float }) {
		trace(input);
		this.circle(Color.PICO_8_RED, input.x, input.y, input.r, 2);
	}

}