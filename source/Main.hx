package;

import flixel.FlxGame;
import lime.app.Application;
import openfl.display.Sprite;
import openfl.events.EventType;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
		trace(stage.stageWidth);
	}
}
