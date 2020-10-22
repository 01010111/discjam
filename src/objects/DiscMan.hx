package objects;

import openfl.events.Event;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;

class DiscMan extends DiscObject {

	public function new() {
		super(8);
		addChild(new Sprite().load_graphic('assets/disc_man.png', BOTTOM_CENTER, true).set_position(0, 4));
		addEventListener(Event.ENTER_FRAME, (e) -> {
			rotation = -parent.rotation;
		});
	}

}