package ui;

import openfl.text.TextField;
import zero.utilities.Color;
import scenes.Stage;
import zero.openfl.utilities.Game;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.openfl.extensions.TextTools;
using zero.utilities.EventBus;

class LastTime extends Sprite {

	var text:TextField;

	public function new() {
		super();

		this.fill_rect(Color.BLACK, -288, -48, 576, 96, 16);

		text = new TextField().format({
			font: 'Disc_numbers_alt Regular',
			size: 48,
			color: Color.get().from_int32(0xFFFFC90B),
		});
		addChild(text);

		addChild(new TextField().format({
			font: 'Disc_text Regular',
			size: 18,
			color: Color.get().from_int32(0xFFFFC90B)
		}).set_string('LAST:').set_position(256, -24, MIDDLE_RIGHT));

		this.set_position(-320, Game.height - 328);

		update.listen('update');
		resize.listen('resize');
	}

	public function set_text(s:String) {
		text.set_string(s).set_position(256, 8, MIDDLE_RIGHT);
	}

	public function update(?dt:Float) {
		var tx = Stage.i.playing || text.text.length == 0 ? -320 : 256;
		x += (tx - x) * 0.075;
	}

	public function resize(?_) {
		y = Game.height - 328;
	}
	
}