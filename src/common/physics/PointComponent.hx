package common.physics;

import esc.IComponent;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class PointComponent implements IComponent{

	public var x(default, default):Float;
	public var y(default, default):Float;

	public function new(x:Float, y:Float) {
		this.x = x;
		this.y = y;
	}
	
}