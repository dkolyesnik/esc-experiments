package game;

import common.physics.PointComponent;
import common.render.RenderComponent;
import common.render.SpriteComponent;
import esc.Core;
import esc.Entity;
import esc.Matcher;
import esc.System;
import flash.Lib;
import flash.display.Sprite;

/**
 * ...
 * @author ...
 */
class SpriteRenderSystem extends System 
{
	public var newEntities:Matcher;
	public var spriteEntities:Matcher;
	
	var _posCompId:Int;
	var _renderCompId:Int;
	var _sprCompId:Int;
	
	var _container:Sprite;
	
	public function new() 
	{
		super();
		newEntities = new Matcher();
		spriteEntities = new Matcher();
	}
	
	override public function initialize(core:Core) 
	{
		super.initialize(core);
		_posCompId = core.componentFactory.getIdByName("physics.position");
		_renderCompId = core.componentFactory.getIdByName("render.render");
		_sprCompId = core.componentFactory.getIdByName("render.sprite");
		
		_container = new Sprite();
		Lib.current.stage.addChild(_container);
		
		newEntities.setRequirements([ _posCompId, _renderCompId ]);
		newEntities.onAddSignal.connect(onRenderedEntityAdded);
		
		spriteEntities.setRequirements([ _posCompId, _sprCompId ]);
		spriteEntities.onAddSignal.connect(onSpriteAdded);
		
		core.addMatcher(newEntities);
		core.addMatcher(spriteEntities);
	}
	
	function onSpriteAdded(entity:Entity):Void 
	{
		var pos:PointComponent = cast entity.getComponent(_posCompId);
		var sprite:SpriteComponent = cast entity.getComponent(_sprCompId);
		sprite.sprite.x = pos.x;
		sprite.sprite.y = pos.y;
		
		_container.addChild(sprite.sprite);
	}
	
	function onRenderedEntityAdded(entity:Entity):Void
	{
		if(!entity.hasComponent(_sprCompId)){
			var render:RenderComponent = cast entity.getComponent(_renderCompId);
			var pos:PointComponent = cast entity.getComponent(_posCompId);
			var sprite = new Sprite();
			sprite.graphics.beginFill(render.color);
			sprite.graphics.drawCircle(0, 0, render.radius);
			sprite.graphics.endFill();
			
			entity.addComponentById(_sprCompId, new SpriteComponent(sprite)); 
		}
	}
	
	
	override public function update() 
	{
		for (e in spriteEntities.getEntities()){
			var pos:PointComponent = cast e.getComponent(_posCompId);
			var spr:SpriteComponent = cast e.getComponent(_sprCompId);
			
			spr.sprite.x = pos.x;
			spr.sprite.y = pos.y;
			
		}
	}
	
}