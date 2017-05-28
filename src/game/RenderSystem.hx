package game;
import esc.Core;
import esc.Matcher;
import esc.*;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class RenderSystem extends System
{

	public var renderingEntities(default, null):Matcher;
	var _renderCompId:Int;
	var _posCompId:Int;

	var _sprite:flash.display.Sprite;

	public function new()
	{
		super();
		renderingEntities = new Matcher();
		_renderCompId = _core.componentFactory.getIdByName("render.render");
		_posCompId = _core.componentFactory.getIdByName("physics.position");
		renderingEntities.setRequirements([
											  _renderCompId,
											  _posCompId
										  ]);
	}

	override public function initialize(core:Core)
	{
		super.initialize(core);
		_sprite = new flash.display.Sprite();
		flash.Lib.current.stage.addChild(_sprite);

		core.addMatcher(renderingEntities);
	}

	override public function update()
	{
		_sprite.graphics.clear();
		for (ent in renderingEntities.getEntities())
		{
			var pos:common.physics.PointComponent = cast ent.getComponent(_posCompId);
			var render:common.render.RenderComponent = cast ent.getComponent(_renderCompId);

			_sprite.graphics.beginFill(render.color);
			_sprite.graphics.drawCircle(pos.x, pos.y, render.radius);
			_sprite.graphics.endFill();
		}
	}

}