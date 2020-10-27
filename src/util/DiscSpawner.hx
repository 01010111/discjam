package util;

import scenes.Stage;
import zero.utilities.Timer;
import objects.Disc;
import zero.utilities.Vec2;
import zero.openfl.utilities.Game;

using zero.extensions.FloatExt;
using zero.utilities.EventBus;
using zero.openfl.extensions.SpriteTools;
using Math;

class DiscSpawner {

	public var active:Array<Disc> = [];
	public var pool:Array<Disc> = [];
	public var radius:Float;

	var scene:Stage;
	var period:Float = 2;
	var rest_period:Int = 0;

	public function new(scene:Stage) {
		resize.listen('resize');
		resize();
		this.scene = scene;
	}

	function resize(?_) {
		radius = (Game.width/2 * Game.width/2 + Game.height/2 * Game.height/2).sqrt();
	}

	public function begin() {
		period = 2;
		Timer.get(2, fire);
	}

	public function fire() {
		if (!scene.playing) return;
		var angle = 360.get_random();
		var pos = Vec2.get(1, 0);
		pos.length = radius;
		pos.angle = angle;
		pos.x += Game.width/2;
		pos.y += Game.height/2;
		
		var disc = get_disc();
		disc.fire(pos.x, pos.y, angle + 15.get_random(-15) + 180, 500);
		pos.put();

		var rest = rest_period++ % 3 == 0 ? 0.5 : 0;
		Timer.get((period *= 0.95).max(0.2) + rest, fire);
	}

	function get_disc() {
		if (pool.length > 0) return pool.shift();
		var disc = new Disc(this);
		scene.discs.add(disc);
		return disc;
	}

}