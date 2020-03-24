module swaywmipc.client.common;

import std.json;

struct Rect {
	size_t x;
	size_t y;
	size_t width;
	size_t height;

	this (JSONValue json) {
		if( const(JSONValue)* v = "x" in json ) this.x = v.integer;
		if( const(JSONValue)* v = "y" in json ) this.y = v.integer;
		if( const(JSONValue)* v = "width" in json ) this.width = v.integer;
		if( const(JSONValue)* v = "height" in json ) this.height = v.integer;
	}
}

struct Libinput {
	string
		send_events,
		tap,
		tap_button_map,
		tap_drag,
		tap_drag_lock,
		accel_profile,
		natural_scroll,
		left_handed,
		click_method,
		middle_emulation,
		scroll_method,
		dwt;

	double accel_speed;

	double[] calibration_matrix;

	size_t scroll_button;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "send_events" in json ) { if(!v.isNull) this.send_events = v.str; }
		if( const(JSONValue)* v = "tap" in json ) { if(!v.isNull) this.tap = v.str; }
		if( const(JSONValue)* v = "tap_button_map" in json ) { if(!v.isNull) this.tap_button_map = v.str; }
		if( const(JSONValue)* v = "tap_drag" in json ) { if(!v.isNull) this.tap_drag = v.str; }
		if( const(JSONValue)* v = "tap_drag_lock" in json ) { if(!v.isNull) this.tap_drag_lock = v.str; }
		if( const(JSONValue)* v = "accel_profile" in json ) { if(!v.isNull) this.accel_profile = v.str; }
		if( const(JSONValue)* v = "natural_scroll" in json ) { if(!v.isNull) this.natural_scroll = v.str; }
		if( const(JSONValue)* v = "left_handed" in json ) { if(!v.isNull) this.left_handed = v.str; }
		if( const(JSONValue)* v = "click_method" in json ) { if(!v.isNull) this.click_method = v.str; }
		if( const(JSONValue)* v = "middle_emulation" in json ) { if(!v.isNull) this.middle_emulation = v.str; }
		if( const(JSONValue)* v = "scroll_method" in json ) { if(!v.isNull) this.scroll_method = v.str; }
		if( const(JSONValue)* v = "dwt" in json ) { if(!v.isNull) this.dwt = v.str; }

		if( const(JSONValue)* v = "accel_speed" in json ) { if(!v.isNull) this.accel_speed = v.floating; }

		if( const(JSONValue)* v = "calibration_matrix" in json ) { if(!v.isNull) this.calibration_matrix = v.arrayNoRef.map!(a => a.floating).array; }

		if( const(JSONValue)* v = "scroll_button" in json ) { if(!v.isNull) this.scroll_button = v.integer; }
	}
}
