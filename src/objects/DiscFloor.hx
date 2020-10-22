package objects;

import zero.openfl.utilities.Game;
import openfl.events.Event;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class DiscFloor extends Sprite {

	public var target_rotation:Float = 0;

	public function new() {
		super();
		this.set_position(Game.width/2, Game.height/2);
		this.load_graphic('assets/disc_floor.png', MIDDLE_CENTER, true);
		addChild(new DiscMan().set_position(128, 0));
		addEventListener(Event.ENTER_FRAME, (e) -> rotation += (target_rotation - rotation) * 0.1);
		((?e) -> this.set_position(Game.width/2, Game.height/2)).listen('resize');
	}

}