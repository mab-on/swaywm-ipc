module swaywmipc.client.event.window;

import swaywmipc.client.event.common;
import swaywmipc.core;
import std.json;

class WindowEvent : Event {
	string change;
	Object container;

	this(JSONValue payload) { super(EventType.window, payload); }
	this(string payload) { this( parseJSON(payload) ); }

	override void unserialize(JSONValue payload) {
		if(const(JSONValue)* v = "change" in payload ) this.change = v.str;
		if(const(JSONValue)* v = "container" in payload ) this.container = Object(*v);
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
	float percent;
	Rect window_rect;
	Rect deco_rect;
	Rect geometry;
	size_t window;
	bool urgent;
	//[]? floating_nodes
	string type;
	size_t pid;
	//? app_id;
	Properties properties;
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
		if( const(JSONValue)* v = "percent" in json ) this.percent = v.floating;
		if( const(JSONValue)* v = "window_rect" in json ) this.window_rect = Rect(*v);
		if( const(JSONValue)* v = "deco_rect" in json ) this.deco_rect = Rect(*v);
		if( const(JSONValue)* v = "geometry" in json ) this.geometry = Rect(*v);
		if( const(JSONValue)* v = "window" in json ) this.window = v.integer;
		if( const(JSONValue)* v = "urgent" in json ) this.urgent = v.boolean;
		if( const(JSONValue)* v = "type" in json ) this.type = v.str;
		if( const(JSONValue)* v = "pid" in json ) this.pid = v.integer;
		if( const(JSONValue)* v = "properties" in json ) this.properties = Properties(*v);
	}

}

struct Properties {
	string _class;
	string instance;
	string transient_for;

	this (JSONValue json) {
		if( const(JSONValue)* v = "class" in json ) this._class = v.str;
		if( const(JSONValue)* v = "instance" in json ) this.instance = v.str;
		if( const(JSONValue)* v = "transient_for" in json ) this.transient_for = v.str;

	}
}
