module swaywmipc.client.message.get_tree;

import swaywmipc.client.common : Rect;
import std.json : JSONValue;

struct Node {

	string
		name,
		type,
		border,
		layout,
		orientation,
		representation,
		app_id;

	size_t
		id,
		current_border_width,
		fullscreen_mode,
		pid,
		window;

	ptrdiff_t[] focus;

	Node[] nodes;
	Node[] floating_nodes;

	float percent;

	Rect
		rect,
		window_rect,
		deco_rect,
		geometry;

	bool
		urgent,
		sticky,
		focused,
		visible;

	WindowProperties window_properties;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "name" in json ) this.name = v.str;
		if( const(JSONValue)* v = "type" in json ) this.type = v.str;
		if( const(JSONValue)* v = "border" in json ) this.border = v.str;
		if( const(JSONValue)* v = "layout" in json ) this.layout = v.str;
		if( const(JSONValue)* v = "orientation" in json ) this.orientation = v.str;
		if( const(JSONValue)* v = "representation" in json ) {
			if(!v.isNull) this.representation = v.str;
		}
		if( const(JSONValue)* v = "app_id" in json ) {
			if(!v.isNull) this.app_id = v.str;
		}

		if( const(JSONValue)* v = "id" in json ) this.id = v.integer;
		if( const(JSONValue)* v = "current_border_width" in json ) this.current_border_width = v.integer;
		if( const(JSONValue)* v = "fullscreen_mode" in json ) {
			if(!v.isNull) this.fullscreen_mode = v.integer;
		}
		if( const(JSONValue)* v = "pid" in json ) {
			if(!v.isNull) this.pid = v.integer;
		}
		if( const(JSONValue)* v = "window" in json ) {
			if(!v.isNull) this.window = v.integer;
		}

		if( const(JSONValue)* v = "focus" in json ) this.focus = v.arrayNoRef.map!(a => a.integer).array;

		if( const(JSONValue)* v = "nodes" in json ) this.nodes = v.arrayNoRef.map!(a => Node(a)).array;
		if( const(JSONValue)* v = "floating_nodes" in json ) this.floating_nodes = v.arrayNoRef.map!(a => Node(a)).array;

		if( const(JSONValue)* v = "percent" in json ) {
			if(!v.isNull) this.percent = v.floating;
		}

		if( const(JSONValue)* v = "rect" in json ) this.rect = Rect(*v);
		if( const(JSONValue)* v = "window_rect" in json ) this.window_rect = Rect(*v);
		if( const(JSONValue)* v = "deco_rect" in json ) this.deco_rect = Rect(*v);
		if( const(JSONValue)* v = "geometry" in json ) this.geometry = Rect(*v);

		if( const(JSONValue)* v = "urgent" in json ) this.urgent = v.boolean;
		if( const(JSONValue)* v = "sticky" in json ) this.sticky = v.boolean;
		if( const(JSONValue)* v = "focused" in json ) this.focused = v.boolean;
		if( const(JSONValue)* v = "visible" in json ) {
			if(!v.isNull) this.visible = v.boolean;
		}

		if( const(JSONValue)* v = "window_properties" in json ) {
			if(!v.isNull) this.window_properties = WindowProperties(*v);
		}
	}

}

struct WindowProperties {
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

unittest {
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `{"id":1,"name":"root","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[3],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"root","nodes":[{"id":2147483647,"name":"__i3","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[2147483646],"border":"none","current_border_width":0,"layout":"output","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"output","nodes":[{"id":2147483646,"name":"__i3_scratch","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"workspace"}]},{"id":3,"name":"eDP-1","rect":{"x":0,"y":0,"width":1920,"height":1080},"focused":false,"focus":[4],"border":"none","current_border_width":0,"layout":"output","orientation":"none","percent":1.0,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"output","active":true,"primary":false,"make":"Unknown","model":"0x38ED","serial":"0x00000000","scale":1.0,"transform":"normal","current_workspace":"1","modes":[{"width":1920,"height":1080,"refresh":60052}],"current_mode":{"width":1920,"height":1080,"refresh":60052},"nodes":[{"id":4,"name":"1","rect":{"x":0,"y":23,"width":1920,"height":1057},"focused":false,"focus":[6,5],"border":"none","current_border_width":0,"layout":"splith","orientation":"horizontal","percent":null,"window_rect":{"x":0,"y":0,"width":0,"height":0},"deco_rect":{"x":0,"y":0,"width":0,"height":0},"geometry":{"x":0,"y":0,"width":0,"height":0},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"num":1,"output":"eDP-1","type":"workspace","representation":"H[URxvt termite]","nodes":[{"id":5,"name":"urxvt","rect":{"x":0,"y":23,"width":960,"height":1057},"focused":false,"focus":[],"border":"normal","current_border_width":2,"layout":"none","orientation":"none","percent":0.5,"window_rect":{"x":2,"y":0,"width":956,"height":1030},"deco_rect":{"x":0,"y":0,"width":960,"height":25},"geometry":{"x":0,"y":0,"width":1124,"height":422},"window":4194313,"urgent":false,"floating_nodes":[],"sticky":false,"type":"con","fullscreen_mode":0,"pid":23959,"app_id":null,"visible":true,"window_properties":{"class":"URxvt","instance":"urxvt","title":"urxvt","transient_for":null},"nodes":[]},{"id":6,"name":"","rect":{"x":960,"y":23,"width":960,"height":1057},"focused":true,"focus":[],"border":"normal","current_border_width":2,"layout":"none","orientation":"none","percent":0.5,"window_rect":{"x":2,"y":0,"width":956,"height":1030},"deco_rect":{"x":0,"y":0,"width":960,"height":25},"geometry":{"x":0,"y":0,"width":817,"height":458},"window":null,"urgent":false,"floating_nodes":[],"sticky":false,"type":"con","fullscreen_mode":0,"pid":25370,"app_id":"termite","visible":true,"nodes":[]}]}]}]}`;

	Node root = Node( parseJSON(json) );
	assert( root.id == 1 );
	assert( root.name == "root" );
	assert( root.type == "root" );

	assert( root.floating_nodes.length == 0 );
	assert( root.nodes.length == 2 );

	Node firstChildNode = root.nodes[0];
	assert( firstChildNode.id == 2147483647 );
	assert( firstChildNode.focus.length == 1 && firstChildNode.focus[0] == 2147483646);

	Node secondChildNode = root.nodes[1];
	assert( secondChildNode.id == 3 );
	assert( secondChildNode.name == "eDP-1" );
	assert( secondChildNode.type == "output" );
	assert( secondChildNode.focus.length == 1 && secondChildNode.focus[0] == 4);
	assert( secondChildNode.nodes.length == 1);

}
