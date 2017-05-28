package esc;
import haxe.ds.Vector;
/**
 * ...
 * @author Dmitriy Kolesnik
 */
class Entity
{
	public var eid(default, null):Int;
	var _components:Vector<IComponent>;
	var _core:Core;
	var _initialized:Bool;

	public function new(core:Core, eid:Int)
	{
		_initialized = false;
		this.eid = eid;
		_core = core;
		_components = new Vector(_core.componentFactory.size);
	}
	
	public function initialize(){
		if (!_initialized){
			_initialized = true;
			_core.initializeEntity(this);
		}
	}

	public function hasComponent(cid:Int)
	{
		if (_components[cid] == null && cid != _core.cids.parentComponentId)
		{
			var parentComp:ParentComponent = cast getComponent(_core.cids.parentComponentId);
			if (parentComp != null)
			{
				//TODO check if component id overriden
				//TODO make separate Entity for holding children
				var parentEntity = _core.getEntityById(parentComp.parentId);
				if (parentEntity != null)
				{
					return parentEntity.hasComponent(cid);
				}
			}
			return false;
		}
		return _components[cid] != null;
	}

	public function getComponent(cid:Int)
	{
		if (_components[cid] == null && cid != _core.cids.parentComponentId)
		{
			var parentComp:ParentComponent = cast getComponent(_core.cids.parentComponentId);
			if (parentComp != null)
			{
				var parentEntity = _core.getEntityById(parentComp.parentId);
				if (parentEntity != null)
				{
					return parentEntity.getComponent(cid);
				}
			}
			return null;
		}
		return _components[cid];
	}

	public function addComponentById(cid:Int, component:IComponent)
	{
		if (_components[cid] != null)
		{
			//TODO do we need to alert core that component is removed, so someone can do some thing before removing it
			_core.onComponentRemoved(this, cid);
			_components[cid] = component;
			if(_initialized)
				_core.onComponentAdded(this, cid);
		}
		else
		{
			_components[cid] = component;
			if(_initialized)
				_core.onComponentAdded(this, cid);
		}
	}

	public function removeComponentById(cid:Int)
	{
		if (_components[cid] != null)
		{
			_core.onComponentRemoved(this, cid);
			_components[cid] = null;
		}
	}

	public function addComponentByName(name:String, component:IComponent)
	{
		var id = _core.componentFactory.getIdByName(name);
		addComponentById(id, component);
	}

	public function removeComponentByName(name:String)
	{
		var id = _core.componentFactory.getIdByName(name);
		removeComponentById(id);
	}

	public function addChild(childEid:Int, cids:Array<Int>)
	{
		var childEntity = _core.getEntityById(childEid);
		if (childEntity == null)
			return;
			
		var parentComp:ParentComponent = cast childEntity.getComponent(_core.cids.parentComponentId);
		if (parentComp != null){
			//TODO remove
		}
		parentComp = new ParentComponent();
		parentComp.setParent(eid);
		for(i in cids)
			parentComp.addInheritedComponent(i);
			
		childEntity.addComponentById(_core.cids.parentComponentId, parentComp);

		var childrenComp:ChildrenComponent = cast getComponent(_core.cids.childrenComponentId);
		if (childrenComp == null){
			childrenComp = new ChildrenComponent();
			addComponentById(_core.cids.childrenComponentId, childrenComp);
		}

		childrenComp.addChild(childEid);

	}
}