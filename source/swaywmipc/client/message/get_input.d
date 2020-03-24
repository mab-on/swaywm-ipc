module swaywmipc.client.message.get_input;

import swaywmipc.client.common : Libinput;
import std.json : JSONValue;

struct Input {
	string
		identifier,
		name,
		type,
		xkb_active_layout_name;

	size_t
		vendor,
		product,
		xkb_active_layout_index;

	string[] xkb_layout_names;

	Libinput libinput;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "identifier" in json ) { if(!v.isNull) this.identifier = v.str; }
		if( const(JSONValue)* v = "name" in json ) { if(!v.isNull) this.name = v.str;}
		if( const(JSONValue)* v = "type" in json ) { if(!v.isNull) this.type = v.str; }
		if( const(JSONValue)* v = "xkb_active_layout_name" in json ) { if(!v.isNull) this.xkb_active_layout_name = v.str; }

		if( const(JSONValue)* v = "vendor" in json ) { if(!v.isNull) this.vendor = v.integer; }
		if( const(JSONValue)* v = "product" in json ) { if(!v.isNull) this.product = v.integer; }
		if( const(JSONValue)* v = "xkb_active_layout_index" in json ) { if(!v.isNull) this.xkb_active_layout_index = v.integer; }

		if( const(JSONValue)* v = "xkb_layout_names" in json ) { if(!v.isNull) this.xkb_layout_names = v.arrayNoRef.map!(a => a.str).array; }

		if( const(JSONValue)* v = "libinput" in json ) { if(!v.isNull) this.libinput = Libinput(*v); }
	}
}

unittest
{
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `[{"identifier":"1:1:AT_Translated_Set_2_keyboard","name":"AT Translated Set 2 keyboard","vendor":1,"product":1,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"1267:5:Elan_Touchpad","name":"Elan Touchpad","vendor":1267,"product":5,"type":"pointer","libinput":{"send_events":"enabled","tap":"enabled","tap_button_map":"lmr","tap_drag":"enabled","tap_drag_lock":"disabled","accel_speed":0.0,"accel_profile":"none","natural_scroll":"disabled","left_handed":"disabled","click_method":"button_areas","middle_emulation":"disabled","scroll_method":"edge","dwt":"enabled"}},{"identifier":"3034:22494:USB2.0_VGA_UVC_WebCam:_USB2.0_V","name":"USB2.0 VGA UVC WebCam: USB2.0 V","vendor":3034,"product":22494,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:3:Sleep_Button","name":"Sleep Button","vendor":0,"product":3,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:5:Lid_Switch","name":"Lid Switch","vendor":0,"product":5,"type":"switch","libinput":{"send_events":"enabled"}},{"identifier":"0:6:Video_Bus","name":"Video Bus","vendor":0,"product":6,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:1:Power_Button","name":"Power Button","vendor":0,"product":1,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}}]`;
	Input[] inputs = parseJSON(json).arrayNoRef.map!(a => Input(a)).array;

	assert( inputs.length == 7 );
	assert(inputs[0].identifier == "1:1:AT_Translated_Set_2_keyboard" );
	assert(inputs[1].libinput.tap == "enabled" );
}
