package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

import esc.*;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Main {
	
	static var core:Core;
	static function main() {
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// Entry point
		trace("Hello World");
		
		Lib.current.stage.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);

		core = new Core();
		SetupAll.setup(core);
	}

	public static function onEnterFrame(e:flash.events.Event){
		core.update();
	}
	
}