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
