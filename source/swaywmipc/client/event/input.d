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
	string
		identifier,
		name,
		type;

	size_t
		vendor,
		product;

	this(JSONValue json) {
		if(json.isNull) return;

		if(const(JSONValue)* v = "identifier" in json ) this.identifier = v.str;
		if(const(JSONValue)* v = "name" in json ) this.name = v.str;
		if(const(JSONValue)* v = "type" in json ) this.type = v.str;

		if(const(JSONValue)* v = "vendor" in json ) this.vendor = v.integer;
		if(const(JSONValue)* v = "product" in json ) this.product = v.integer;
	}
}
