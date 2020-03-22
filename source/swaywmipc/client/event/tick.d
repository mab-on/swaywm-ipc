module swaywmipc.client.event.tick;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class TickEvent : Event {
	bool first;
	string payload;

	this(JSONValue payload) { super(EventType.tick, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "first" in payload ) this.first = v.boolean;
		if(const(JSONValue)* v = "payload" in payload ) this.payload = v.str;
	}

}
