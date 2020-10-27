package ui;

import openfl.text.TextField;
import zero.utilities.Color;
import scenes.Stage;
import zero.openfl.utilities.Game;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.openfl.extensions.TextTools;
using zero.utilities.EventBus;

class BestTime extends Sprite {

	var text:TextField;

	public function new() {
		super();

		this.fill_rect(Color.BLACK, -288, -32, 576, 64, 16);

		text = new TextField().format({
			font: 'Disc_text Regular',
			size: 24,
			color: Color.get().from_int32(0xFFFF004D),
			align: RIGHT
		});
		addChild(text);

		this.set_position(-320, Game.height - 244);

		update.listen('update');
		resize.listen('resize');
	}

	public function set_text(s:String) {
		text.set_string(s).set_position(256, 0, MIDDLE_RIGHT);
	}

	public function update(?dt:Float) {
		var tx = Stage.i.playing || text.text.length == 0 ? -320 : 256;
		x += (tx - x) * 0.1;
	}

	public function resize(?_) {
		y = Game.height - 244;
	}

}