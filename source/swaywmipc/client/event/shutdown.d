module swaywmipc.client.event.shutdown;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class ShutdownEvent : Event {
	string change;

	this(JSONValue payload) { super(EventType.shutdown, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
	}

}
