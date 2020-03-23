module swaywmipc.client.message.get_bar_config;

import swaywmipc.client.common : Rect;
import std.json : JSONValue;

struct BarConfig {
	string
		id,
		mode,
		position,
		status_command,
		font;

	bool
		workspace_buttons,
		binding_mode_indicator,
		verbose;

	size_t
		bar_height,
		status_padding,
		status_edge_padding;

	Gaps gaps;

	Colors colors;


	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "id" in json ) this.id = v.str;
		if( const(JSONValue)* v = "mode" in json ) this.mode = v.str;
		if( const(JSONValue)* v = "position" in json ) this.position = v.str;
		if( const(JSONValue)* v = "status_command" in json ) this.status_command = v.str;
		if( const(JSONValue)* v = "font" in json ) this.font = v.str;

		if( const(JSONValue)* v = "workspace_buttons" in json ) this.workspace_buttons = v.boolean;
		if( const(JSONValue)* v = "binding_mode_indicator" in json ) this.binding_mode_indicator = v.boolean;
		if( const(JSONValue)* v = "verbose" in json ) this.verbose = v.boolean;

		if( const(JSONValue)* v = "bar_height" in json ) this.bar_height = v.integer;
		if( const(JSONValue)* v = "status_padding" in json ) this.status_padding = v.integer;
		if( const(JSONValue)* v = "status_edge_padding" in json ) this.status_edge_padding = v.integer;

		if( const(JSONValue)* v = "gaps" in json ) this.gaps = Gaps(*v);

		if( const(JSONValue)* v = "colors" in json ) this.colors = Colors(*v);
	}

}

struct Gaps {
	size_t
		top,
		right,
		bottom,
		left;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "top" in json ) this.top = v.integer;
		if( const(JSONValue)* v = "right" in json ) this.right = v.integer;
		if( const(JSONValue)* v = "bottom" in json ) this.bottom = v.integer;
		if( const(JSONValue)* v = "left" in json ) this.left = v.integer;
	}
}

struct Colors {
	Color
		background,
		statusline,
		separator,
		focused_background,
		focused_statusline,
		focused_separator,
		focused_workspace_text,
		focused_workspace_bg,
		focused_workspace_border,
		active_workspace_text,
		active_workspace_bg,
		active_workspace_border,
		inactive_workspace_text,
		inactive_workspace_bg,
		inactive_workspace_border,
		urgent_workspace_text,
		urgent_workspace_bg,
		urgent_workspace_border,
		binding_mode_text,
		binding_mode_bg,
		binding_mode_border;

	this(JSONValue json) {
		if(json.isNull) return;

		if( const(JSONValue)* v = "background" in json ) this.background = Color(*v);
		if( const(JSONValue)* v = "statusline" in json ) this.statusline  = Color(*v);
		if( const(JSONValue)* v = "separator" in json ) this.separator  = Color(*v);
		if( const(JSONValue)* v = "focused_background" in json ) this.focused_background  = Color(*v);
		if( const(JSONValue)* v = "focused_statusline" in json ) this.focused_statusline  = Color(*v);
		if( const(JSONValue)* v = "focused_separator" in json ) this.focused_separator  = Color(*v);
		if( const(JSONValue)* v = "focused_workspace_text" in json ) this.focused_workspace_text  = Color(*v);
		if( const(JSONValue)* v = "focused_workspace_bg" in json ) this.focused_workspace_bg  = Color(*v);
		if( const(JSONValue)* v = "focused_workspace_border" in json ) this.focused_workspace_border  = Color(*v);
		if( const(JSONValue)* v = "active_workspace_text" in json ) this.active_workspace_text  = Color(*v);
		if( const(JSONValue)* v = "active_workspace_bg" in json ) this.active_workspace_bg  = Color(*v);
		if( const(JSONValue)* v = "active_workspace_border" in json ) this.active_workspace_border  = Color(*v);
		if( const(JSONValue)* v = "inactive_workspace_text" in json ) this.inactive_workspace_text  = Color(*v);
		if( const(JSONValue)* v = "inactive_workspace_bg" in json ) this.inactive_workspace_bg  = Color(*v);
		if( const(JSONValue)* v = "inactive_workspace_border" in json ) this.inactive_workspace_border  = Color(*v);
		if( const(JSONValue)* v = "urgent_workspace_text" in json ) this.urgent_workspace_text  = Color(*v);
		if( const(JSONValue)* v = "urgent_workspace_bg" in json ) this.urgent_workspace_bg  = Color(*v);
		if( const(JSONValue)* v = "urgent_workspace_border" in json ) this.urgent_workspace_border  = Color(*v);
		if( const(JSONValue)* v = "binding_mode_text" in json ) this.binding_mode_text  = Color(*v);
		if( const(JSONValue)* v = "binding_mode_bg" in json ) this.binding_mode_bg  = Color(*v);
		if( const(JSONValue)* v = "binding_mode_border" in json ) this.binding_mode_border  = Color(*v);
	}
}

struct Color {
	ubyte r, g, b, a;

	this(JSONValue json) { this(json.str); }
	this(string notation) {
		import std.conv : to;

		if(notation.length != 9) return;
		if(notation[0] != '#') return;

		this.r = notation[1..3].to!ubyte(16);
		this.g = notation[3..5].to!ubyte(16);
		this.b = notation[5..7].to!ubyte(16);
		this.a = notation[7..9].to!ubyte(16);
	}
}

unittest {
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `{"id":"bar-0","mode":"dock","position":"top","status_command":"while date +'%Y-%m-%d %l:%M:%S %p'; do sleep 1; done","font":"monospace 10","gaps":{"top":0,"right":0,"bottom":0,"left":0},"bar_height":0,"status_padding":1,"status_edge_padding":3,"workspace_buttons":true,"binding_mode_indicator":true,"verbose":false,"pango_markup":false,"colors":{"background":"#323232ff","statusline":"#ffffffff","separator":"#666666ff","focused_background":"#323232ff","focused_statusline":"#ffffffff","focused_separator":"#666666ff","focused_workspace_border":"#4c7899ff","focused_workspace_bg":"#285577ff","focused_workspace_text":"#ffffffff","inactive_workspace_border":"#32323200","inactive_workspace_bg":"#32323200","inactive_workspace_text":"#5c5c5cff","active_workspace_border":"#333333ff","active_workspace_bg":"#5f676aff","active_workspace_text":"#ffffffff","urgent_workspace_border":"#2f343aff","urgent_workspace_bg":"#900000ff","urgent_workspace_text":"#ffffffff","binding_mode_border":"#2f343aff","binding_mode_bg":"#900000ff","binding_mode_text":"#ffffffff"}}`;
	BarConfig config = BarConfig( parseJSON(json) );

	assert(config.id == "bar-0");

	//"background": "#323232ff",
	assert(config.colors.background.r == 50);
	assert(config.colors.background.g == 50);
	assert(config.colors.background.b == 50);
	assert(config.colors.background.a == 255);
}
