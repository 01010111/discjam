package scenes;

import ui.Transition;
import zero.utilities.Tween;
import lime.media.howlerjs.Howl;
import openfl.media.SoundMixer;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.Assets;
import openfl.media.Sound;
import ui.LastTime;
import util.GameState;
import ui.BestTime;
import openfl.ui.Mouse;
import ui.PlayPrompt;
import zero.utilities.Vec2;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.events.TouchEvent;
import filters.OutlineShader;
import zero.openfl.utilities.Game;
import zero.utilities.Color;
import openfl.text.TextField;
import util.DiscSpawner;
import zero.utilities.Timer;
import openfl.events.MouseEvent;
import zero.openfl.utilities.Scene;
import objects.*;

using zero.extensions.FloatExt;
using zero.openfl.extensions.SpriteTools;
using zero.openfl.extensions.TextTools;
using zero.utilities.EventBus;
using Math;

class Stage extends Scene {

	public static var i:Stage;
	
	var floor:DiscFloor;
	var time:TextField;
	var time_bg:Sprite;
	var accumulator:Float = 0;
	var touch_last:Vec2 = Vec2.get();
	var spawner:DiscSpawner;
	var prompt:PlayPrompt;
	var best:BestTime;
	var last:LastTime;
	var new_record:Bool = false;
	var blood:Blood;
	var music:Howl;
	var music_id:Int;
	var music_rate(default, set):Float = 1;
	var metal_hit:Howl = new Howl({ src: [ 'assets/metal_hit.mp3' ], volume: 0.4 });
	var body_hit:Howl = new Howl({ src: [ 'assets/body_hit.mp3' ], volume: 1 });
	var start_sound:Howl = new Howl({ src: [ 'assets/disc_spawn.mp3' ], volume: 0.25 });

	function set_music_rate(v:Float) {
		if (music == null) return v;
		music.rate(v, music_id);
		return v;
	}

	public var playing:Bool = false;

	public var discs:Sprite;

	public function new() {
		Game.root.stage.color = Color.PICO_8_DARK_BLUE.to_hex_24();
		Mouse.hide();
		i = this;
		super();
		init_controls();

		addChild(new Backdrop());
		addChild(floor = cast new DiscFloor());

		init_spawner();
		addChild(blood = new Blood());
		init_timer();

		init_menu();
		addChild(new Transition());

		#if debug addChild(new util.DebugSprite()); #end
		update.listen('update');

		music = new Howl({
			src: [ 'assets/music.mp3' ],
			loop: true,
		});
		music_id = music.play(0);
		music.rate(0.5, music_id);
		music.volume(0.75);
	}

	function init_controls() {
		addEventListener(MouseEvent.MOUSE_WHEEL, (e) -> rotate(e.delta.sign_of() * 15));
		addEventListener(TouchEvent.TOUCH_BEGIN, (e) -> {
			var p = new Point(e.localX, e.localY);
			p = (cast e.target:Sprite).localToGlobal(p);
			touch_last.x = p.x;
			touch_last.y = p.y;
		});
		addEventListener(TouchEvent.TOUCH_MOVE, (e) -> {
			var p = new Point(e.localX, e.localY);
			p = (cast e.target:Sprite).localToGlobal(p);
			var dx = touch_last.x - p.x;
			var dy = touch_last.y - p.y;
			var d = dx.abs() > dy.abs() ? dx : dy;
			rotate(d/2);
			touch_last.x = p.x;
			touch_last.y = p.y;
		});
	}

	function init_spawner() {
		spawner = new DiscSpawner(this);
		addChild(discs = new Sprite());
	}

	function init_timer() {
		time = new TextField().format({
			font: 'Disc_numbers_alt Regular',
			size: 48,
			color: Color.get().from_int32(0xFFFFC90B),
		}).set_string('0:00.000').set_position(Game.width/2, 32, TOP_CENTER);
		time.shader = new OutlineShader(Color.BLACK, 3);
		addChild(time);
	}

	function init_menu() {
		addChild(prompt = cast new PlayPrompt());
		addChild(best = new BestTime());
		addChild(last = new LastTime());
		best.set_text('BEST ${format_time(GameState.best)}');
	}

	function update_best() {
		var s = new_record ? 'NEW RECORD!!!' : 'BEST ${format_time(GameState.best)}';
		best.set_text(s);
	}

	function rotate(amt:Float) {
		if (playing) floor.target_rotation -= amt;
		else {
			prompt.progress -= amt/64;
			prompt.progress = prompt.progress.clamp(0, 1);
			if (prompt.progress == 1) begin();
		}
	}

	function begin() {
		//start_sound.play();
		new_record = false;
		if (prompt.lock) return;
		floor.add_man();
		prompt.lock = true;
		Timer.get(1, () -> {
			playing = true;
			spawner.begin();
		});
		accumulator = 0;
		update_timer(0);
		if (music == null) {
			music = new Howl({
				src: [ 'assets/music.mp3' ],
				loop: true,
			});
			music_id = music.play(0);
			music.volume(1);
		}
		else {
			music.fade(0.75, 1, 250, music_id);
			Tween.get(this).from_to('music_rate', 0.5, 1).duration(0.25);
		}
	}

	function update(?dt:Float) {
		update_timer(dt);
		disc_peg_collisions();
		disc_man_collisions();
	}

	function update_timer(dt:Float) {
		var ty = playing ? 32 : -64;
		time.y += (ty - time.y) * 0.2;
		if (!playing || !DiscMan.i.alive) return;
		var s = format_time(accumulator += dt.min(2/60));
		time.set_string(s).set_position(Game.width/2, time.y, TOP_CENTER);
	}

	function format_time(t:Float):String {
		var min = '${(t/60).floor()}';
		var sec = '${(t%60).floor()}';
		var ms = '${(t%1).normalize(3)}'.split('.')[1];
		if (ms == null || ms.length == 0) ms = '000';
		if (sec.length == 1) sec = '0$sec';
		while (ms.length < 3) ms += '0';
		return '$min:$sec.$ms';
	}
	
	function disc_peg_collisions() {
		for (disc in spawner.active) {
			if (disc.bounced) continue;
			var v1 = Vec2.get(disc.x, disc.y);
			var v2 = Vec2.get(floor.x, floor.y);
			if (v1.distance(v2) < disc.radius + 32) {
				var tangent = Vec2.get(v2.y - v1.y, -(v2.x - v1.x)).normalize();
				tangent.length *= disc.velocity.dot(tangent);
				var perp_tan = disc.velocity - tangent;
				perp_tan *= 2;
				disc.velocity -= perp_tan;
				perp_tan.put();
				tangent.put();
				disc.bounced = true;
				var id = metal_hit.play();
				metal_hit.rate(1.get_random(0.5), id);
			}
			v1.put();
			v2.put();
		}
	}

	function disc_man_collisions() {
		if (!playing || !DiscMan.i.alive) return;
		for (disc in spawner.active) {
			var v1 = Vec2.get(disc.x, disc.y);
			var v2 = Vec2.get(DiscMan.i.position.x, DiscMan.i.position.y);
			if (v1.distance(v2) < DiscMan.i.radius + disc.radius) disc_man_hit(disc);
			v1.put();
			v2.put();
		}
	}

	function disc_man_hit(disc:Disc) {
		disc.hit();
		if (GameState.best < accumulator) {
			GameState.best = accumulator;
			new_record = true;
		}
		var id = body_hit.play();
		body_hit.rate(1.25.get_random(0.75), id);
		music.fade(1, 0.75, 250, music_id);
		Tween.get(this).from_to('music_rate', 1, 0.5).duration(0.25);
		last.set_text(format_time(accumulator));
		update_best();
		prompt.reset();
		DiscMan.i.kill();
		Timer.get(1, () -> playing = false);
		var p = new Point(DiscMan.i.x, DiscMan.i.y);
		p = floor.localToGlobal(p);
		for (i in 0...32) {
			blood.fire(p.x, p.y, 360.get_random(), 500.get_random(250));
		}
		var blood = new Sprite().load_graphic('assets/blood_${4.get_random().floor()}.png', MIDDLE_CENTER).set_position(DiscMan.i.x, DiscMan.i.y);
		blood.rotation = 360.get_random();
		floor.blood_sprite.addChild(blood);
		for (i in 0...8) {
			var d = 88.get_random() * Math.random();
			var pos = Vec2.get(0, 1);
			var ppos = Vec2.get(DiscMan.i.x, DiscMan.i.y);
			pos.angle = 360.get_random();
			pos.length = d;
			pos += ppos;
			var x = pos.x;
			var y = pos.y;
			pos.put();
			ppos.put();
			Timer.get(d / 1000 + i * 0.025, () -> {
				var c:Color = cast Color.PICO_8_RED.copy();
				c.hue += 15.get_random(-15);
				c.brightness += 0.1.get_random(-0.25);
				floor.blood_sprite.fill_circle(c, x, y, 8.get_random(2) * d.map(0, 80, 1, Math.random()));
				c.put();
			});
		}
	}

}