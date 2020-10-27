package objects;

import zero.utilities.Ease;
import zero.utilities.Tween;
import zero.utilities.Vec2;
import zero.utilities.Color;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.extensions.Tools;
using zero.utilities.EventBus;

class Blood extends Sprite {
	
	var drops:Array<Drop> = [];

	public function new() {
		super();
	}

	public function fire(x:Float, y:Float, a:Float, s:Float) {
		get_drop().fire(x, y, a, s);
	}

	function get_drop():Drop {
		for (drop in drops) if (drop.visible == false) return drop;
		var drop = new Drop();
		addChild(drop);
		drops.push(drop);
		return drop;
	}

}

class Drop extends Sprite {

	var v:Vec2 = Vec2.get(0, 1);

	public function new() {
		super();
		this.fill_circle(Color.PICO_8_RED, 0, 0, 16);
		update.listen('update');
		visible = false;
	}

	public function fire(x:Float, y:Float, a:Float, s:Float) {
		this.set_position(x, y);
		v.length = s;
		v.angle = a;
		visible = true;
		this.set_scale(1, 1);
		Tween.get(this).from_to('scaleX', 1, 0).from_to('scaleY', 1, 0).duration(1.get_random(0.5)).ease(Ease.sineOut).on_complete(() -> visible = false);
	}

	function update(?dt:Float) {
		if (!visible) return;
		x += v.x * dt;
		y += v.y * dt;
		v.length *= 0.99;
	}

}