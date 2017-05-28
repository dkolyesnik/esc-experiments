package esc;
import haxe.ds.Vector;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Entity{
	var _components:Vector<IComponent>;
	var _core:Core;

	public function new(core:Core) {
		_core = core;
		_components = new Vector(_core.componentFactory.size);
	}

	public function hasComponent(id:Int){
		return _components[id] != null;
	}

	public function getComponent(id:Int){
		return _components[id];
	}

	public function addComponentById(id:Int, component:IComponent){
		if(_components[id] != null){
			//TODO do we need to alert core that component is removed, so someone can do some thing before removing it
			_core.onComponentRemoved(this, id);
			_components[id] = component;
			_core.onComponentAdded(this, id);
		}else{
            _components[id] = component;
			_core.onComponentAdded(this, id);
		}
	}

	public function removeComponentById(id:Int){
		if(_components[id] != null){
			_core.onComponentRemoved(this, id);
			_components[id] = null;
		}
	}

	public function addComponentByName(name:String, component:IComponent){
		var id = _core.componentFactory.getIdByName(name);
		addComponentById(id, component);
	}

	public function removeComponentByName(name:String){
		var id = _core.componentFactory.getIdByName(name);
		removeComponentById(id);
	}

	
}