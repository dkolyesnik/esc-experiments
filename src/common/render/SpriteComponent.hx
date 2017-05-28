package common.render;

import esc.IComponent;
import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
class SpriteComponent implements IComponent 
{
	public var sprite(default, null):Sprite;
	public function new(sprite:Sprite) 
	{
		this.sprite = sprite;
	}
	
}