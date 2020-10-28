package util;

import js.Browser.window as window;

class GameState {

	public static var best(default, set):Float = 0;
	static function set_best(n:Float) {
		window.localStorage.setItem('hiscore', '$n');
		return best = n;
	}

}