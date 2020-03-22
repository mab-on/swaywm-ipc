module swaywmipc.client.event.workspace;

import swaywmipc.client.event.common : Event;
import swaywmipc.client.common : Rect;
import swaywmipc.core;
import std.json;

class WorkspaceEvent : Event {

	string change;
	Object current;
	Object old;

	this(JSONValue payload) { super(EventType.workspace, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "current" in payload ) this.current = Object(*v);
		if(const(JSONValue)* v = "old" in payload ) this.old = Object(*v);
	}
}

struct Object {
	size_t id;
	string name;
	Rect rect;
	bool focused;
	//[]? focus
	string border;
	size_t current_border_width;
	string layout;
	//? percent
	Rect window_rect;
	Rect deco_rect;
	Rect geometry;
	//? window
	bool urgent;
	//[]? floating_nodes
	size_t num;
	string output;
	string type;
	//? representation
	//[]? nodes

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "id" in json ) this.id = v.integer;
		if( const(JSONValue)* v = "name" in json ) this.name = v.str;
		if( const(JSONValue)* v = "rect" in json ) this.rect = Rect(*v);
		if( const(JSONValue)* v = "focused" in json ) this.focused = v.boolean;
		if( const(JSONValue)* v = "border" in json ) this.border = v.str;
		if( const(JSONValue)* v = "current_border_width" in json ) this.current_border_width = v.integer;
		if( const(JSONValue)* v = "layout" in json ) this.layout = v.str;
		if( const(JSONValue)* v = "window_rect" in json ) this.window_rect = Rect(*v);
		if( const(JSONValue)* v = "deco_rect" in json ) this.deco_rect = Rect(*v);
		if( const(JSONValue)* v = "geometry" in json ) this.geometry = Rect(*v);
		if( const(JSONValue)* v = "urgent" in json ) this.urgent = v.boolean;
		if( const(JSONValue)* v = "num" in json ) this.num = v.integer;
		if( const(JSONValue)* v = "output" in json ) this.output = v.str;
		if( const(JSONValue)* v = "type" in json ) this.type = v.str;
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
