module swaywmipc.client.event.common;

import std.json;
import swaywmipc.core;

abstract class Event {
	private
		EventType _type;
		JSONValue _payload;

	this(EventType type, JSONValue payload) {
		this._type = type;
		this._payload = payload;
		this.unserialize(this._payload);
	}

	abstract void unserialize(JSONValue payload);

	EventType type() {
		return this._type;
	}

	string name() {
		import std.conv : to;
		return this._type.to!string;
	}

	JSONValue payload() {
		return this._payload;
	}
}

struct Rect {
	size_t x;
	size_t y;
	size_t width;
	size_t height;

	this (JSONValue json) {
		if( const(JSONValue)* x = "x" in json ) this.x = x.integer;
		if( const(JSONValue)* y = "y" in json ) this.y = y.integer;
		if( const(JSONValue)* width = "width" in json ) this.width = width.integer;
		if( const(JSONValue)* height = "height" in json ) this.height = height.integer;
	}
}

//Event WindowEvent() { return Event(EventType.window); }

//Event ModeEvent() { return Event(EventType.mode); }
//Event BarconfigUpdateEvent() { return Event(EventType.barconfig_update); }
//Event BindingEvent() { return Event(EventType.binding); }
//Event ShutdownEvent() { return Event(EventType.shutdown); }
//Event TickEvent() { return Event(EventType.tick); }
//Event BarStateUpdateEvent() { return Event(EventType.bar_state_update); }
//Event InputEvent() { return Event(EventType.input); }
