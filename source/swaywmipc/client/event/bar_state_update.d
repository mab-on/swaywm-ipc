module swaywmipc.client.event.bar_state_update;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class BarStateUpdateEvent : Event {
	string id;
	bool visible_by_modifier;

	this(JSONValue payload) { super(EventType.bar_state_update, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "id" in payload ) this.id = v.str;
		if(const(JSONValue)* v = "visible_by_modifier" in payload ) this.visible_by_modifier = v.boolean;
	}

}
