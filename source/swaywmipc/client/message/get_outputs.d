module swaywmipc.client.message.get_outputs;

import swaywmipc.client.common : Rect;
import std.json : JSONValue;

struct Output {
	string name;
	string make;
	string model;
	string serial;
	string subpixel_hinting;
	string transform;
	string current_workspace;

	bool active;
	bool dpms;
	bool primary;

	float scale;

	Mode[] modes;
	Mode current_mode;

	Rect rect;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "name" in json ) this.name = v.str;
		if( const(JSONValue)* v = "make" in json ) this.make = v.str;
		if( const(JSONValue)* v = "model" in json ) this.model = v.str;
		if( const(JSONValue)* v = "serial" in json ) this.serial = v.str;
		if( const(JSONValue)* v = "subpixel_hinting" in json ) this.subpixel_hinting = v.str;
		if( const(JSONValue)* v = "transform" in json ) this.transform = v.str;
		if( const(JSONValue)* v = "current_workspace" in json ) this.current_workspace = v.str;

		if( const(JSONValue)* v = "active" in json ) this.active = v.boolean;
		if( const(JSONValue)* v = "dpms" in json ) this.dpms = v.boolean;
		if( const(JSONValue)* v = "primary" in json ) this.primary = v.boolean;

		if( const(JSONValue)* v = "scale" in json ) this.scale = v.floating;

		if( const(JSONValue)* v = "modes" in json ) this.modes = v.arrayNoRef.map!(a => Mode(a)).array;
		if( const(JSONValue)* v = "current_mode" in json ) this.current_mode = Mode(*v);

		if( const(JSONValue)* v = "rect" in json ) this.rect = Rect(*v);
	}

}

struct Mode {
	size_t width;
	size_t height;
	size_t refresh;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "width" in json ) this.width = v.integer;
		if( const(JSONValue)* v = "height" in json ) this.height = v.integer;
		if( const(JSONValue)* v = "refresh" in json ) this.refresh = v.integer;

	}
}

unittest {
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `[{"name":"HDMI-A-2","make":"Unknown","model":"NS-19E310A13","serial":"0x00000001","active":true,"primary":false,"scale":1.0,"subpixel_hinting":"rgb","transform":"normal","current_workspace":"1","modes":[{"width":640,"height":480,"refresh":59940},{"width":800,"height":600,"refresh":60317},{"width":1024,"height":768,"refresh":60004},{"width":1920,"height":1080,"refresh":60000}],"current_mode":{"width":1920,"height":1080,"refresh":60000}}]`;
	Output[] ouputs = parseJSON(json).arrayNoRef.map!(a => Output(a)).array;

	assert( ouputs.length == 1 );

	Output output = ouputs[0];
	assert( output.name == "HDMI-A-2" );
	assert( output.make == "Unknown" );

	assert( output.modes.length == 4 );

	Mode mode = output.modes[0];
	assert( mode.width == 640 );
	assert( mode.height == 480 );
	assert( mode.refresh == 59940 );

}
