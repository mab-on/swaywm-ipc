module swaywmipc.client.event.window;

import swaywmipc.client.common;
import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class WindowEvent : Event {
	string change;
	Window container;

	this(JSONValue payload) { super(EventType.window, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "container" in payload ) this.container = Window(*v);
	}
}

