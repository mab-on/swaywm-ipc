module swaywmipc.client.event.binding;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

import std.stdio;

class BindingEvent : Event {
	string change;
	Binding binding;

	this(JSONValue payload) { super(EventType.binding, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "binding" in payload) this.binding = Binding(*v);
	}
}

struct Binding {
	string command;
	string symbol;
	string input_type;
	string[] event_state_mask;
	size_t input_code;

	this (JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(const(JSONValue)* v = "command" in json ) this.command = v.str;
		if(const(JSONValue)* v = "symbol" in json ) this.symbol = v.str;
		if(const(JSONValue)* v = "input_type" in json ) this.input_type = v.str;
		if(const(JSONValue)* v = "event_state_mask" in json ) this.event_state_mask = v.arrayNoRef().map!(a => a.str).array;
		if(const(JSONValue)* v = "input_code" in json ) this.input_code = v.integer;

	}
}

unittest {

	string json_string = `{"change":"run","binding":{"command":"workspace 2","event_state_mask":["Mod4"],"input_code":0,"symbol":"2","input_type":"keyboard"}}`;
	auto event = new BindingEvent(json_string);

	assert( event.change == "run" );

	assert( event.binding.event_state_mask.length == 1);
	assert( event.binding.event_state_mask[0] == "Mod4" );
}
