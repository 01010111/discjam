package ui;

import filters.OutlineShader;
import zero.utilities.Timer;
import scenes.Stage;
import zero.openfl.utilities.Game;
import openfl.text.TextField;
import zero.utilities.Color;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.openfl.extensions.TextTools;
using zero.utilities.EventBus;
using zero.extensions.Tools;

class PlayPrompt extends Sprite {
	
	var blade:Sprite;
	var top_letters:Array<Sprite> = [];
	var bottom_letters:Array<Sprite> = [];

	var top_sprite = new Sprite();
	var bottom_sprite = new Sprite();

	public var progress(default, set):Float = 0;
	public var lock:Bool = false;

	function set_progress(n:Float) {
		return progress = lock ? progress : n;
	}

	public function new() {
		super();
		
		this.fill_rect(Color.BLACK, -288, -80, 576, 160, 16);

		var x = -72;
		var i = 0;
		for (l in 'play'.split('')) {
			var l_top = new Sprite().load_graphic('assets/${l}_top.png', MIDDLE_CENTER, true).set_position(x, 0);
			var l_bottom = new Sprite().load_graphic('assets/${l}_bottom.png', MIDDLE_CENTER, true).set_position(x, 0);
			top_sprite.add(l_top);
			bottom_sprite.add(l_bottom);
			top_letters.push(l_top);
			bottom_letters.push(l_bottom);
			x += 48;
			i++;
		}

		var blade_container = new Sprite();
		blade = new Sprite().load_graphic('assets/menu_disc.png', MIDDLE_CENTER, true);
		blade.shader = new OutlineShader(Color.BLACK, 4);
		blade_container.add(blade);
		blade_container.scaleY = 0.5;
		blade.set_position(-160, 0);
		
		var instructions = new TextField().format({
			font: 'Disc_text Regular',
			size: 16,
			color: Color.get().from_int32(0xFFFFC90B),
			align: CENTER
		}).set_string('SCROLL TO PLAY').set_position(0, 64, BOTTOM_CENTER);
		
		this.add(instructions);
		this.add(bottom_sprite);
		this.add(blade_container);
		this.add(top_sprite);

		resize();
		update.listen('update');
		resize.listen('resize');

		this.set_position(-320, Game.height - 128);
	}
	
	public function reset() {
		lock = false;
		progress = 0;
		lock = true;
		Timer.get(2, () -> lock = false);
	}

	function update(?dt) {
		x += ((Stage.i.playing ? -320 : 256) - x) * 0.2;
		blade.rotation += (progress * 360 * 100 - blade.rotation) * 0.25;
		blade.x += (progress.map(0, 1, -160, 160) - blade.x) * 0.25;

		for (i in 0...4) {
			var top = top_letters[i];
			var bottom = bottom_letters[i];
			var offset = blade.x > (-72 + 48 * i) ? 8 : -1;
			top.y += (-offset - top.y) * 0.25;
			bottom.y += (offset - bottom.y) * 0.25;
			top.rotation += (-offset.map(-1, 8, 0, 6) - top.rotation) * 0.25;
			bottom.rotation += (offset.map(-1, 8, 0, 6) - bottom.rotation) * 0.25;
		}
	}

	function resize(?_) {
		y = Game.height - 128;
	}

}