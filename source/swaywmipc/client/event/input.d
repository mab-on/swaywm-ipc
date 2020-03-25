module swaywmipc.client.event.input;

import std.json;
import swaywmipc.client.message.get_input : Input;
import swaywmipc.client.event.common;
import swaywmipc.core;

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
