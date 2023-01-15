package;

import flixel.FlxG;
import flixel.FlxState;
import haxe.Json;
import openfl.Assets;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		var eReg = ~/"F": /,
			eReg2 = ~/(\{([^{}]|(?R))*\})/s,
			source = Assets.getText(AssetPaths.Animation__json);

		var lastMatch = 0, position, array:Array<Array<String>> = [];

		while (eReg.matchSub(source, lastMatch))
		{
			position = eReg.matchedPos();

			if (eReg2.matchSub(source, position.pos + position.len))
			{
				var string = eReg2.matched(0);
				string = string.substring(1, string.length - 1);
				var filters = [];
				for (filter in string.split(","))
				{
					filters.push('{$filter}');
				}
				array.push(filters);

				position = eReg2.matchedPos();
			}

			lastMatch = position.pos + (position.len + array.length);
		}
		trace(array[0]);

		var json:AnimAtlas = Json.parse(source);
		trace(json.AN.STI.SI.F); // should be an array somehow?
	}
}

// I'm not gonna copy the entire texture atlas onto a typedef LMAO
// Fuck texture atlases, Fuck FlxAnimate and Fuck Adobe Animate for causing me this pain
typedef AnimAtlas =
{
	var AN:Animation;
	var SD:Dynamic;
	var MD:Dynamic;
}

typedef Animation =
{
	var N:String;
	var STI:{SI:SymbolInstance};
	var SN:String;
	var TL:Dynamic;
}

typedef SymbolInstance =
{
	var SN:String;
	var IN:String;
	var ST:String;
	var TRP:{x:Float, y:Float};
	var M3D:Array<Float>;
	var F:Dynamic;
	var C:Dynamic;
}
