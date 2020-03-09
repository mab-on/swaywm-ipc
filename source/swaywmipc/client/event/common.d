module swaywmipc.client.event.common;

import std.json;
import swaywmipc.core;

struct Event {
	private
		PayloadType _type;
		JSONValue _payload;

	this(PayloadType type) {
		this._type = type;
	}

	this(PayloadType type, JSONValue payload) {
		this(type);
		this._payload = payload;
	}

	PayloadType type() {
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

Event WindowEvent() { return Event(PayloadType.window); }
Event WorkspaceEvent() { return Event(PayloadType.workspace); }
Event ModeEvent() { return Event(PayloadType.mode); }
Event BarconfigUpdateEvent() { return Event(PayloadType.barconfig_update); }
Event BindingEvent() { return Event(PayloadType.binding); }
Event ShutdownEvent() { return Event(PayloadType.shutdown); }
Event TickEvent() { return Event(PayloadType.tick); }
Event BarStateUpdateEvent() { return Event(PayloadType.bar_state_update); }
Event InputEvent() { return Event(PayloadType.input); }
