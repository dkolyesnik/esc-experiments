package;
import common.render.SpriteComponent;
import esc.Core;
import common.physics.PointComponent;
import common.*;
import common.render.RenderComponent;
import game.*;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class SetupAll{

	public static function setup(core:Core){
		var componentFactory = core.componentFactory;
		componentFactory.registerComponent("physics.position", PointComponent);

		componentFactory.registerComponent("render.render", RenderComponent);
		componentFactory.registerComponent("render.sprite", SpriteComponent);

		componentFactory.registerComponent("tags.move", Component);

		//systems
		var moveSystem = new MoveSystem();
		core.addSystem(moveSystem);

		//var renderSystem = new RenderSystem();
		var renderSystem = new SpriteRenderSystem();
		core.addSystem(renderSystem);

		//entities
		for(i in 0...100){
			_createObject(core);
		}
		
	}

	static function _createObject(core:Core){
		var entity = core.allocateEntity();
		entity.addComponentByName("physics.position", new PointComponent(Random.float(300,500), Random.float(200,400)));
		entity.addComponentByName("render.render", new RenderComponent(10, 0xFF8000));
		entity.addComponentByName("tags.move", new common.Component());
		core.initializeEntity(entity);
	}
	
}