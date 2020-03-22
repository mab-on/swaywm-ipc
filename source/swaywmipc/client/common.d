module swaywmipc.client.common;

import std.json;

struct Rect {
	size_t x;
	size_t y;
	size_t width;
	size_t height;

	this (JSONValue json) {
		if( const(JSONValue)* x = "x" in json ) this.x = x.integer;
		if( const(JSONValue)* y = "y" in json ) this.y = y.integer;
		if( const(JSONValue)* width = "width" in json ) this.width = width.integer;
		if( const(JSONValue)* height = "height" in json ) this.height = height.integer;
	}
}
