package game;
import esc.Core;
import esc.Matcher;
import esc.*;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class MoveSystem extends System{

    public var movingEntities(default, null):Matcher;
    var _moveCompId:Int;
    var _posCompId:Int;

	public function new() {
        super();
       
	}

	override public function initialize(core:Core){
		super.initialize(core);
		
        _moveCompId = getId("tags.move");
        _posCompId = getId("physics.position");
		movingEntities = new Matcher();
        movingEntities.setRequirements([
                _moveCompId,
                _posCompId
            ]);
		
        core.addMatcher(movingEntities);
	}

	override public function update() {
        for(ent in movingEntities.getEntities()){
            var pos:common.physics.PointComponent = cast ent.getComponent(_posCompId);

            var dir = new flash.geom.Point(Random.float(-1,1), Random.float(-1,1));
            pos.x += dir.x;
            pos.y += dir.y;
        }
	}
	
}