package objects;

import zero.openfl.utilities.Game;
import util.DiscSpawner;
import zero.utilities.Vec2;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class Disc extends DiscObject {

	public var velocity:Vec2 = Vec2.get(1, 0);
	var spawner:DiscSpawner;
	var last_onscreen:Bool = false;

	public function new(spawner:DiscSpawner) {
		super(64);
		this.spawner = spawner;
		this.load_graphic('assets/disc.png', MIDDLE_CENTER);
		update.listen('update');
		visible = false;
	}

	public function fire(x:Float, y:Float, a:Float, s:Float) {
		visible = true;
		last_onscreen = false;
		spawner.active.push(this);
		this.set_position(x, y);
		velocity.length = s;
		velocity.angle = a;
	}

	function update(?dt:Float) {
		if (!visible) return;
		x += velocity.x * dt;
		y += velocity.y * dt;
		rotation += 10;

		var is_on_screen = on_screen();
		if (!is_on_screen && last_onscreen) kill();
		last_onscreen = is_on_screen;
	}

	function on_screen():Bool {
		var center = Vec2.get(Game.width/2, Game.height/2);
		var pos = Vec2.get(x, y);
		var out = center.distance(pos) < center.length + radius;
		center.put();
		pos.put();
		return out;
	}

	function kill() {
		trace('killing disc');
		visible = false;
		spawner.active.remove(this);
		spawner.pool.push(this);
	}

}