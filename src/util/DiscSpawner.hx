package util;

import zero.utilities.Timer;
import zero.openfl.utilities.Scene;
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

	var scene:Scene;
	var period:Float = 2;

	public function new(scene:Scene) {
		resize.listen('resize');
		resize();
		this.scene = scene;
	}

	function resize(?_) {
		radius = (Game.width/2 * Game.width/2 + Game.height/2 * Game.height/2).sqrt();
	}

	public function fire() {
		var angle = 360.get_random();
		var pos = Vec2.get(1, 0);
		pos.length = radius;
		pos.angle = angle;
		pos.x += Game.width/2;
		pos.y += Game.height/2;
		
		var disc = get_disc();
		disc.fire(pos.x, pos.y, angle + 15.get_random(-15) + 180, 500);
		pos.put();

		Timer.get((period *= 0.98).max(0.2), fire);
	}

	function get_disc() {
		if (pool.length > 0) return pool.shift();
		var disc = new Disc(this);
		scene.add(disc);
		return disc;
	}

}