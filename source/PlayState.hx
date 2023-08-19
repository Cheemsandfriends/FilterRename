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
			eReg3 = ~/("(.+)")/,
			source = Assets.getText(AssetPaths.Animation__json);

		var lastMatch = 0, position, array:Array<Array<String>> = [];

		while (eReg.matchSub(source, lastMatch))
		{
			position = eReg.matchedPos();

			if (eReg2.matchSub(source, position.pos + position.len))
			{
				var string = eReg2.matched(0);
				position = eReg2.matchedPos();

				string = string.substring(1, string.length - 1);

				var filters = string.split("},");

				var len = 2;
				var repeated:Map<String, Int> = [];
				for (filter in filters)
				{
					var marched = eReg3.matchSub(source, position.pos + len);
					if (marched)
					{
						var filter = eReg3.matched(0);
						if (repeated.exists(filter))
						{
							var mod = '"${filter.substring(1, filter.length - 1)}_${repeated.get(filter) + 1}"';
							source = source.substring(0, position.pos + len + 1) + mod + source.substring(position.pos + len + mod.length);

							repeated.set(filter, repeated.get(filter) + 1);
						}
						else
							repeated.set(filter, 0);
					}
					len += filter.length;
				}

				position = eReg2.matchedPos();
			}

			lastMatch = position.pos + position.len;
		}

		var json:AnimAtlas = Json.parse(source);
		trace(json.AN.STI.SI.F); // array?? list??
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
