module swaywmipc.client.event.mode;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class ModeEvent : Event {
	string change;
	bool pango_markup;

	this(JSONValue payload) { super(EventType.mode, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "pango_markup" in payload ) this.pango_markup = v.boolean;
	}
}
