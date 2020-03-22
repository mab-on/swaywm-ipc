module swaywmipc.client.message.get_workspaces;

import swaywmipc.client.common : Rect;
import std.json : JSONValue;

struct Workspace {
	size_t num;
	string name;
	bool visible;
	bool focused;
	bool urgent;
	Rect rect;
	string output;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "num" in json ) this.num = v.integer;

		if( const(JSONValue)* v = "name" in json ) this.name = v.str;
		if( const(JSONValue)* v = "output" in json ) this.output = v.str;

		if( const(JSONValue)* v = "visible" in json ) this.visible = v.boolean;
		if( const(JSONValue)* v = "focused" in json ) this.focused = v.boolean;
		if( const(JSONValue)* v = "urgent" in json ) this.urgent = v.boolean;

		if( const(JSONValue)* v = "rect" in json ) this.rect = Rect(*v);
	}
}

unittest {
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `[{"num":1,"name":"1","visible":true,"focused":true,"rect":{"x":0,"y":23,"width":1920,"height":1057},"output":"eDP-1"}]`;
	Workspace[] workspaces = parseJSON(json).arrayNoRef.map!(a => Workspace(a)).array;

	assert( workspaces.length == 1 );

	Workspace workspace = workspaces[0];
	assert( workspace.num == 1 );
	assert( workspace.name == "1" );
	assert( workspace.visible == true );
	assert( workspace.rect.x == 0 );
	assert( workspace.rect.y == 23 );
	assert( workspace.rect.width == 1920 );
	assert( workspace.rect.height == 1057 );
	assert( workspace.output == "eDP-1" );
}
