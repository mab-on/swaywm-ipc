module swaywmipc.client.event.input;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class InputEvent : Event {
	string change;
	Input input;

	this(JSONValue payload) { super(EventType.input, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "input" in payload ) this.input = Input(*v);
	}

}

struct Input {
	string identifier;
	string name;
	size_t vendor;
	size_t product;
	string type;

	this(JSONValue json) {
		if(json.isNull) return;
	}
}
