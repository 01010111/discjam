package objects;

import zero.utilities.Vec2;
import zero.utilities.Color;
import openfl.Assets;
import openfl.display.BitmapData;
import zero.openfl.utilities.Game;
import openfl.events.Event;
import openfl.display.Sprite;
import filters.MaskShader;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class DiscFloor extends Sprite {

	public var target_rotation:Float = 0;
	public var blood_sprite:Sprite;

	var peg:Sprite;
	var screw:Sprite;

	public function new() {
		super();
		this.set_position(Game.width/2, Game.height/2);
		this.load_graphic('assets/disc_floor.png', MIDDLE_CENTER, true);
		addChild(new Sprite().load_graphic('assets/title.png', BOTTOM_CENTER, true).set_position(0, -64));
		addChild(blood_sprite = new Sprite());
		update.listen('update');
		resize.listen('resize');
		add_peg();
	}

	public function add_man() {
		var pos = Vec2.get(0, 128);
		pos.angle = -rotation - 90;
		addChild(new DiscMan().set_position(pos.x, pos.y));
	}

	function add_peg() {
		peg = new Sprite();
		var peg_graphic = new Sprite().load_graphic('assets/peg.png', BOTTOM_CENTER, true).set_position(0, 32);
		peg.addChild(peg_graphic);

		screw = new Sprite().load_graphic('assets/screw_hole.png', MIDDLE_CENTER, true);

		addChild(peg);
		addChild(screw);
	}

	function update(?dt) {
		rotation += (target_rotation - rotation) * 0.1;
		peg.rotation = -rotation;
		var p = Vec2.get(0, 32);
		p.angle = -rotation - 90;
		screw.set_position(p.x, p.y);
	}

	function resize(?_) {
		this.set_position(Game.width/2, Game.height/2);
	}
	
}