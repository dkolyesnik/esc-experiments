package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class ComponentFactory {
	public var size(get, never):Int;

	var _namesToId:Map<String, Int>;
	var _names:Array<String>;
	var _idToNames:Map<Int, String>;
	var _counter:Int;

	public function new() {
		_counter = 0;
		_namesToId = new Map();
		_idToNames = new Map();
		_names = [];
		_registerDefaultComponents();
	}
	
	function _registerDefaultComponents(){
		registerComponent("core.parent", ParentComponent);
		registerComponent("core.children", ChildrenComponent);
	}

	public function get_size():Int{
		return _counter;
	}

	public function registerComponent(name:String, type:Class<IComponent>) {
		if (_namesToId.exists(name)) {
			throw 'Component with name $name is alrady registered';
		}
		_namesToId[name] = _counter;
		_idToNames[_counter] = name;
		_counter++;
	}

	public function getIdByName(name:String):Int {
		if (_namesToId.exists(name))
			return _namesToId[name];
		else
			throw 'Wrong component name $name';
	}

	public function getNameById(id:Int):String {
		if (id < _names.length)
			return _names[id];
		else
			throw 'Wrong id $id';
	}
}