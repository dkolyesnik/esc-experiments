package esc;
import misc.Signal;
import misc.Signal.SignalEmitter;

/**
 * ...
 * @author Dmitriy Kolesnik
 */
typedef OnAddHandler=Entity->Void;
typedef OnRemoveHandler=Entity->Void;

class Matcher
{

	var _entities:Array<Entity>;

	var _requiredComponents:Array<Int>;
	var _guardComponents:Array<Int>;

	public var onAddSignal(get, never):Signal<Entity>;
	@:noCompletion
	inline public function get_onAddSignal():Signal<Entity>	{
		return _onAddEmitter.getSignal();
	}
	var _onAddEmitter:SignalEmitter<Entity>;

	public var onRemoveSignal(get, never):Signal<Entity>;
	@:noCompletion
	inline public function get_onRemoveSignal():Signal<Entity> {
		return _onRemoveEmitter.getSignal();
	}
	var _onRemoveEmitter:SignalEmitter<Entity>;

	public function new()
	{
		_entities = [];
		_requiredComponents = [];
		_guardComponents = [];

		_onAddEmitter = new SignalEmitter<Entity>();
		_onRemoveEmitter = new SignalEmitter<Entity>();
	}

	public function checkAdded(entity:Entity){
		var match = true;
		for (id in _requiredComponents)
		{
			if (!entity.hasComponent(id))
			{
				match = false;
				break;
			}
		}
		if (match)
		{
			for (id in _guardComponents)
			{
				if (entity.hasComponent(id))
				{
					match = false;
					break;
				}
			}
		}
		if (match)
		{
			_entities.push(entity);
			_onAddEmitter.emit(entity);
		}
	}

	public function checkRemoved(entity:Entity)	{
		//TODO
	}

	public function setRequirements(ids:Array<Int>)	{
		for (id in ids)
		{
			_requiredComponents.push(id);
		}
	}

	public function getEntities() {
		return _entities;
	}
}