package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class System{

	var _core:Core;

	public function new() {
	}

	public function initialize(core:Core){
		_core = core;
		setupMatchers();
	}

	public function update() {

	}
	
	function setupMatchers(){
		
	}
	
	inline function getId(name:String):Int{
		return _core.componentFactory.getIdByName(name);
	}
}