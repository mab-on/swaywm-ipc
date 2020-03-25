module swaywmipc.client.event.workspace;

import swaywmipc.client.event.common : Event;
import swaywmipc.client.common : Workspace;
import swaywmipc.core;
import std.json;

class WorkspaceEvent : Event {

	string change;
	Workspace current;
	Workspace old;

	this(JSONValue payload) { super(EventType.workspace, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "current" in payload ) this.current = Workspace(*v);
		if(const(JSONValue)* v = "old" in payload ) this.old = Workspace(*v);
	}
}



unittest {
	import std.stdio;

	string json_string = `{"change":"init","old":null,"current":{"id":10,"name":"2","rect":{"x":0,"y":0,"width":0,"height":0},"focused":false,"focus":[],"border":"none","current_border_width":0,"layout":"splith","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"num":2,"output":"eDP-1","type":"workspace","representation":null,"nodes":[]}}`;

	auto workspace = new WorkspaceEvent(json_string);

	assert( workspace.name() == "workspace" );
	assert( workspace.change == "init" );
	assert(  workspace.current.id == 10 );
	assert(  workspace.old.id == 0 );
}
