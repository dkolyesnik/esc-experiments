package esc;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
class ChildrenComponent implements IComponent 
{
	var _childrenIds:Array<Int>;
	public function new() 
	{
		_childrenIds = [];
	}
	
	public function addChild(eid:Int){
		_childrenIds.push(eid);
	}
	
	public function removeChild(eid:Int){
		_childrenIds.remove(eid);
	}
	
}