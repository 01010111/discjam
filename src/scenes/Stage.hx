package scenes;

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
using zero.openfl.extensions.TextTools;
using zero.utilities.EventBus;
using Math;

class Stage extends Scene {
	
	var floor:DiscFloor;
	var time:TextField;
	var accumulator:Float = 0;

	public function new() {
		super();
		addChild(new Backdrop());
		addChild(floor = cast new DiscFloor());
		addEventListener(MouseEvent.MOUSE_WHEEL, (e) -> floor.target_rotation += e.delta.sign_of() * 15);
		var spawner = new DiscSpawner(this);
		Timer.get(2, spawner.fire);

		time = new TextField().format({
			font: 'Myfont Regular',
			size: 48,
			color: Color.PICO_8_ORANGE,
		});
		time.shader = new OutlineShader(Color.BLACK, 4);
		addChild(time);
		update.listen('update');
	}

	function update(?dt:Float) {
		trace(dt);
		var s = format_time(accumulator += dt.min(2/60));
		time.set_string(s).set_position(Game.width/2, 64, TOP_CENTER);
	}

	function format_time(t:Float):String {
		var min = '${(t/60).floor()}';
		var sec = '${(t%60).floor()}';
		var ms = '${(t%1).normalize(3)}'.split('.')[1];
		if (ms == null || ms.length == 0) ms = '000';
		if (sec.length == 1) sec = '0$sec';
		while (ms.length < 3) ms += '0';
		trace(min,sec,ms);
		return '$min:$sec:$ms';
	}

}