package;
import common.render.SpriteComponent;
import esc.ChildrenComponent;
import esc.Core;
import common.physics.PointComponent;
import common.*;
import common.render.RenderComponent;
import game.*;
import esc.ParentComponent;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class SetupAll
{

	public static function setup(core:Core)
	{
		var componentFactory = core.componentFactory;
		componentFactory.registerComponent("physics.position", PointComponent);
		componentFactory.registerComponent("physics.offset", PointComponent);

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
		for (i in 0...0)
		{
			_createObject(core);
		}
		for (i in 0...1){
			_creteComplexObject(core, 100, 700, 100, 500);
		}
	}

	static function _createObject(core:Core)
	{
		var entity = core.allocateEntity();
		entity.addComponentByName("physics.position", new PointComponent(Random.float(300,500), Random.float(200,400)));
		entity.addComponentByName("render.render", new RenderComponent(10, 0xFF8000));
		entity.addComponentByName("tags.move", new common.Component());
		core.initializeEntity(entity);
	}

	static function _creteComplexObject(core:Core, xMin:Int, xMax:Int, yMin:Int, yMax:Int)
	{
		//TODO how to initialize
		var baseEntity = core.allocateEntity();
		var cidPos = core.componentFactory.getIdByName("physics.position");
		var cidRender = core.componentFactory.getIdByName("render.render");

		baseEntity.addComponentById(cidPos, new PointComponent(Random.float(xMin, xMax), Random.float(yMin, yMax)));
		baseEntity.addComponentById(cidRender, new RenderComponent(22, 0x008080));
		baseEntity.addComponentByName("tags.move", new Component());
		baseEntity.initialize();
		for (i in 0...1)
		{
			var childEntity = core.allocateEntity();
			childEntity.addComponentById(cidRender, new RenderComponent(33, 0xFF0000));
			childEntity.addComponentByName("physics.offset", new PointComponent(Random.float( -10, 10), Random.float( -10, 10)));
			childEntity.initialize();

			baseEntity.addChild(childEntity.eid, [cidPos]);
		}
		
		
	}

}