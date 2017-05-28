package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class ParentComponent implements IComponent 
{
	public static inline var NO_PARENT = -1;
	public var parentId(default, null):Int;
	public var inheritAll:Bool;
	
	var _components:Array<Int>;
	
	
	public function new() 
	{
		parentId = NO_PARENT;
		inheritAll = false;
		_components = [];
	}
	
	public function hasComponent(core:Core, cid:Int):Bool{
		var ent = core.getEntityById(parentId);
		if (ent != null){
			return ent.hasComponent(cid);
		}
		
		return false;
	}
	
	public function getComponent(core:Core, cid:Int){
		var ent = core.getEntityById(parentId);
		if (ent != null){
			return ent.getComponent(cid);
		}
		return null;
	}
	
	public function setParent(id:Int){
		parentId = id;
	}
	
	public function addInheritedComponent(cid:Int){
		_components.push(cid);
	}
	
	public function removeInheritedComponent(cid:Int){
		_components.remove(cid);
	}
	
}