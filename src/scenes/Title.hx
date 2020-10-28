package scenes;

import util.GameState;
import lime.media.howlerjs.Howl;
import zero.utilities.Timer;
import zero.utilities.Ease;
import zero.utilities.Tween;
import zero.utilities.Color;
import openfl.display.Sprite;
import zero.openfl.utilities.Game;
import openfl.events.MouseEvent;
import zero.openfl.utilities.Scene;
import js.Browser.window as window;

using zero.openfl.extensions.SpriteTools;
using zero.utilities.EventBus;

class Title extends Scene {
	
	var logo:Sprite;
	var spin:Bool = false;
	var rot_amt:Float = 0;
	var start_sound:Howl = new Howl({
		src: ['assets/begin.mp3'],
		volume: 0.4
	});

	public function new() {
		Game.root.stage.color = Color.BLACK.to_hex_24();
		super();
		addEventListener(MouseEvent.CLICK, (e) -> {
			Tween.get(logo).prop({ scaleX: 0, scaleY: 0 }).duration(0.25).ease(Ease.backIn).on_complete(() -> {
				Timer.get(1.77, () -> Game.i.change_scene(new Stage()));
			});
			start_sound.play();
		});
		logo = new Sprite().load_graphic('assets/logo.png', MIDDLE_CENTER, true).center();
		addChild(logo);

		logo.addEventListener(MouseEvent.MOUSE_OVER, (e) -> spin = true);
		logo.addEventListener(MouseEvent.MOUSE_OUT, (e) -> spin = false);

		update.listen('update');

		var hi = window.localStorage.getItem('hiscore');
		if (hi != null) GameState.best = Std.parseFloat(hi);
	}

	function update(?dt:Float) {
		rot_amt += ((spin ? 90 : 2) - rot_amt) * 0.01;
		logo.rotation += (logo.rotation + rot_amt - logo.rotation) * 0.2;
	}

}