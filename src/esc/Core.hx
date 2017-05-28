package esc;
import esc.Core.CoreComponentsIds;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Core{
	public var cids(default, null):CoreComponentsIds;
	public var componentFactory(default, null):ComponentFactory;
	
	var _entitiesById:Map<Int, Entity>;
	//TODO reuse old id-s
	var _idCount:Int;
	var _entities:Array<Entity>;
	var _matchers:Array<Matcher>;

	var _systems:Array<System>;

	public function new() {
		_idCount = 0;
		_entitiesById = new Map();
		_entities = [];
		_matchers = [];
		_systems = [];
		componentFactory = new ComponentFactory();
		cids = new CoreComponentsIds(this);
	}

	public function update(){
		for(s in _systems){
			s.update();
		}
	}

	public function allocateEntity(){
		var ent = new Entity(this, _idCount);
		_idCount++;
		return ent;
	}

	public function initializeEntity(entity:Entity){
		_entities.push(entity);
		_entitiesById[entity.eid] = entity;
		for(matcher in _matchers){
			matcher.checkAdded(entity);
		}
	}

	public function addSystem(system:System){
		_systems.push(system);
		system.initialize(this);
	}
	
	public function addSystems(systems:Array<System>){
		for (s in systems){
			addSystem(s);
		}
	}

	public function addMatcher(matcher:esc.Matcher){
		for(e in _entities){
			matcher.checkAdded(e);
		}
		_matchers.push(matcher);
	}

	public function onComponentAdded(entity:Entity, componentId:Int){
		for(m in _matchers){
			m.checkAdded(entity);
		}
	}

	public function onComponentRemoved(entity:Entity, componentId:Int){

	}
	
	public function getEntityById(parentId:Int) 
	{
		return _entitiesById[parentId];
	}

}

class CoreComponentsIds{
	public var parentComponentId(default, null):Int;
	public var childrenComponentId(default, null):Int;
	
	public function new(core:Core){
		parentComponentId = core.componentFactory.getIdByName("core.parent");
		childrenComponentId = core.componentFactory.getIdByName("core.children");
	}
}