package;

import zero.utilities.Vec2;
import zero.openfl.utilities.Game;
import zero.openfl.utilities.Scene;
import openfl.events.Event;
import zero.utilities.Color;
import openfl.events.MouseEvent;
import openfl.display.Sprite;

using zero.openfl.extensions.SpriteTools;
using zero.extensions.Tools;
using zero.utilities.EventBus;
using Math;

class Main extends Sprite
{

	
	public function new()
	{
		super();
		new Game(this, scenes.Stage);
		stage.addEventListener(Event.RESIZE, (e) -> 'resize'.dispatch(e));
		stage.addEventListener(Event.ENTER_FRAME, util.UpdateManager.update);
	}
}



