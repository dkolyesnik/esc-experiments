package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Core{

	public var componentFactory(default, null):ComponentFactory;
	
	var _entities:Array<Entity>;
	var _matchers:Array<Matcher>;

	var _systems:Array<System>;

	public function new() {
		_entities = [];
		_matchers = [];
		_systems = [];
		componentFactory = new ComponentFactory();
	}

	public function update(){
		for(s in _systems){
			s.update();
		}
	}

	public function allocateEntity(){
		var ent = new Entity(this);
		return ent;
	}

	public function initializeEntity(entity:Entity){
		_entities.push(entity);
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

}