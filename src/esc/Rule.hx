package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Rule{

	public function new() {
	}

	public function check(entity:Entity){
        return false;
	}
}

class HasComponentRule extends Rule{
    var _componentId:Int;
    public function new(componentId:Int){
        super();
        _componentId = componentId;
    }

    override public function check(entity:Entity){
        return entity.hasComponent(_componentId);
    }
}

class DoNotHasComponentRule extends HasComponentRule{
    override public function check(entity:Entity){
        return !entity.hasComponent(_componentId);
    }
}