module swaywmipc.client.common;

import std.json;

struct Rect {
	size_t x;
	size_t y;
	size_t width;
	size_t height;

	this (JSONValue json) {
		if( const(JSONValue)* v = "x" in json ) { if(!v.isNull) this.x = v.integer; }
		if( const(JSONValue)* v = "y" in json ) { if(!v.isNull) this.y = v.integer; }
		if( const(JSONValue)* v = "width" in json ) { if(!v.isNull) this.width = v.integer; }
		if( const(JSONValue)* v = "height" in json ) { if(!v.isNull) this.height = v.integer; }
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

struct Node {
	string
		app_id,
		border,
		layout,
		name,
		output,
		orientation,
		representation,
		type;

	size_t
		id,
		current_border_width,
		fullscreen_mode,
		num,
		pid,
		window;


	Rect
		rect,
		window_rect,
		deco_rect,
		geometry;

	bool
		focused,
		sticky,
		urgent,
		visible;

	ptrdiff_t[] focus;

	Node[]
		nodes,
		floating_nodes;

	float percent;

	Properties
		window_properties,
		properties;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "id" in json ) { if(!v.isNull) this.id = v.integer; }
		if( const(JSONValue)* v = "current_border_width" in json ) { if(!v.isNull) this.current_border_width = v.integer; }
		if( const(JSONValue)* v = "fullscreen_mode" in json ) { if(!v.isNull) this.fullscreen_mode = v.integer; }
		if( const(JSONValue)* v = "num" in json ) { if(!v.isNull) this.num = v.integer; }
		if( const(JSONValue)* v = "pid" in json ) { if(!v.isNull) this.pid = v.integer; }
		if( const(JSONValue)* v = "window" in json ) { if(!v.isNull) this.window = v.integer; }

		if( const(JSONValue)* v = "app_id" in json ) { if(!v.isNull) this.app_id = v.str; }
		if( const(JSONValue)* v = "name" in json ) { if(!v.isNull) this.name = v.str; }
		if( const(JSONValue)* v = "border" in json ) { if(!v.isNull) this.border = v.str; }
		if( const(JSONValue)* v = "layout" in json ) { if(!v.isNull) this.layout = v.str; }
		if( const(JSONValue)* v = "output" in json ) { if(!v.isNull) this.output = v.str; }
		if( const(JSONValue)* v = "orientation" in json ) { if(!v.isNull) this.orientation = v.str; }
		if( const(JSONValue)* v = "type" in json ) { if(!v.isNull) this.type = v.str; }
		if( const(JSONValue)* v = "representation" in json ) { if(!v.isNull) this.representation = v.str; }

		if( const(JSONValue)* v = "rect" in json ) { if(!v.isNull) this.rect = Rect(*v); }
		if( const(JSONValue)* v = "window_rect" in json ) { if(!v.isNull) this.window_rect = Rect(*v); }
		if( const(JSONValue)* v = "deco_rect" in json ) { if(!v.isNull) this.deco_rect = Rect(*v); }
		if( const(JSONValue)* v = "geometry" in json ) { if(!v.isNull) this.geometry = Rect(*v); }

		if( const(JSONValue)* v = "focused" in json ) { if(!v.isNull) this.focused = v.boolean; }
		if( const(JSONValue)* v = "visible" in json ) { if(!v.isNull) this.visible = v.boolean; }
		if( const(JSONValue)* v = "urgent" in json ) { if(!v.isNull) this.urgent = v.boolean; }
		if( const(JSONValue)* v = "sticky" in json ) { if(!v.isNull) this.sticky = v.boolean; }

		if( const(JSONValue)* v = "focus" in json ) { if(!v.isNull) this.focus = v.arrayNoRef.map!(a => a.integer).array; }

		if( const(JSONValue)* v = "percent" in json ) { if(!v.isNull) this.percent = v.floating; }

		if( const(JSONValue)* v = "nodes" in json ) { if(!v.isNull) this.nodes = v.arrayNoRef.map!(a => Node(a)).array; }
		if( const(JSONValue)* v = "floating_nodes" in json ) { if(!v.isNull) this.floating_nodes = v.arrayNoRef.map!(a => Node(a)).array; }

		if( const(JSONValue)* v = "window_properties" in json ) {if(!v.isNull) this.window_properties = Properties(*v);}
		if( const(JSONValue)* v = "properties" in json ) {if(!v.isNull) this.properties = Properties(*v);}
	}
}

alias Workspace = Node;
alias Window = Node;

struct Properties {
	string
		class_,
		instance,
		title,
		transient_for;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "class" in json ) { if(!v.isNull) this.class_ = v.str; }
		if( const(JSONValue)* v = "instance" in json ) { if(!v.isNull) this.instance = v.str; }
		if( const(JSONValue)* v = "title" in json ) { if(!v.isNull) this.title = v.str; }
		if( const(JSONValue)* v = "transient_for" in json ) { if(!v.isNull) this.transient_for = v.str; }
	}
}
