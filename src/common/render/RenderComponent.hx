package common.render;

import esc.IComponent;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class RenderComponent implements IComponent{

    public var radius:Int;
    public var color:Int;

	public function new(radius:Int, color:Int) {
        this.radius = radius;
        this.color = color;
	}
	
}