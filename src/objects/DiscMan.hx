package objects;

import zero.utilities.Vec2;
import zero.openfl.utilities.AnimatedSprite;
import zero.utilities.Tween;
import zero.utilities.Timer;
import zero.openfl.utilities.Game;
import util.DiscSpawner;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;
using zero.extensions.Tools;
using Math;

class DiscMan extends DiscObject {

	public static var i:DiscMan;
	public var position:Point = new Point(0, 0);
	public var alive:Bool = true;

	var graphic:Sprite;
	var sprite:AnimatedSprite;
	var shadow:Sprite;
	var dy = 0.0;

	public function new() {
		super(8);
		i = this;
		addChild(shadow = new Sprite().load_graphic('assets/disc_man_shadow.png', MIDDLE_CENTER, true));
		//addChild(graphic = new Sprite().load_graphic('assets/disc_man.png', BOTTOM_CENTER, true).set_position(0, -Game.height/2));
		addChild(sprite = new AnimatedSprite({
			source: 'assets/disc_man_sheet.png',
			frame_width: 32,
			frame_height: 48,
			offset_x: 16,
			offset_y: 48,
			animations: []
		}));
		sprite.set_position(0, -Game.height/2);
		update.listen('update');
	}
	
	function update(?dt) {
		if (parent == null || this == null) {
			update.unlisten('update');
			return;
		}		
		rotation = -parent.rotation;
		position.setTo(x, y);
		position = parent.localToGlobal(position);
		'draw_debug'.dispatch({ x: position.x, y: position.y, r: radius });

		dy += (800 * dt).min(3200);
		sprite.y += dy * dt;
		if (sprite.y > 2) sprite.y = 2;

		var a = sprite.y.map(-256, 0, 0, 0.25);
		shadow.alpha = a;

		sprite.frame_index = ((rotation + 180).map(0, 360, 8, 0).round()).cycle(0, 8).round();
	}

	public function kill() {
		alive = false;
		sprite.remove();
		//graphic.remove();
		addChild(graphic = new Sprite().load_graphic('assets/disc_man_dead.png', BOTTOM_CENTER, true));
		Timer.get(16, () -> {
			Tween.get(this).prop({ alpha: 0 }).on_complete(() -> {
				this.remove();
			});
		});
	}

}