package objects;

import lime.media.howlerjs.Howl;
import openfl.display.Sprite;
import zero.utilities.Rect;
import zero.openfl.utilities.Game;
import util.DiscSpawner;
import zero.utilities.Vec2;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;
using zero.extensions.Tools;

class Disc extends DiscObject {

	public var velocity:Vec2 = Vec2.get(1, 0);
	public var bounced:Bool;
	var spawner:DiscSpawner;
	var last_onscreen:Bool = false;
	var blood:Sprite;
	var spawn:Howl = new Howl({ src: [ 'assets/disc_spawn.mp3' ], volume: 0.2 });

	public function new(spawner:DiscSpawner) {
		super(48);
		this.spawner = spawner;
		this.load_graphic('assets/disc.png', MIDDLE_CENTER, true);
		this.add(blood = new Sprite().load_graphic('assets/disc_bloody.png', MIDDLE_CENTER, true));
		update.listen('update');
		visible = false;
	}

	public function fire(x:Float, y:Float, a:Float, s:Float) {
		visible = true;
		last_onscreen = false;
		bounced = false;
		spawner.active.push(this);
		this.set_position(x, y);
		velocity.length = s;
		velocity.angle = a;
		blood.visible = false;
	}

	public function hit() {
		blood.visible = true;
	}

	function update(?dt:Float) {
		if (!visible) return;
		x += velocity.x * dt;
		y += velocity.y * dt;
		rotation += 10;

		var is_on_screen = on_screen();
		if (!is_on_screen && last_onscreen) kill();
		if (is_on_screen && !last_onscreen) {
			var id = spawn.play();
			spawn.pos(x.map(0, 1280, -0.1, 0.1), y.map(0, 720, -0.1, 0.1));
			spawn.rate(1.5.get_random(1), id);
		}
		last_onscreen = is_on_screen;

		#if debug
			if (is_on_screen) 'draw_debug'.dispatch({ x: x, y: y, r: radius });
		#end
	}

	function on_screen():Bool {
		var screen = Rect.get(-radius, -radius, Game.width + radius * 2, Game.height + radius * 2);
		var center = Vec2.get(Game.width/2, Game.height/2);
		var pos = Vec2.get(x, y);
		//var out = center.distance(pos) < center.length + radius;
		var out = screen.contains_point(pos);
		center.put();
		pos.put();
		return out;
	}

	function kill() {
		visible = false;
		spawner.active.remove(this);
		spawner.pool.push(this);
	}

}