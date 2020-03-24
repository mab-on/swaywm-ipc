module swaywmipc.client.message.get_seats;

import swaywmipc.client.message.get_input : Input;
import std.json : JSONValue;

struct Seat {
	string name;

	size_t
		capabilities,
		focus;

	Input[] devices;

	this(JSONValue json) {
		import std.algorithm : map;
		import std.array : array;

		if(json.isNull) return;

		if( const(JSONValue)* v = "name" in json ) { if(!v.isNull) this.name = v.str; }

		if( const(JSONValue)* v = "capabilities" in json ) { if(!v.isNull) this.capabilities = v.integer; }
		if( const(JSONValue)* v = "focus" in json ) { if(!v.isNull) this.focus = v.integer; }

		if( const(JSONValue)* v = "devices" in json ) { if(!v.isNull) this.devices = v.arrayNoRef.map!(a => Input(a)).array; }
	}
}

unittest
{
	import std.algorithm : map;
	import std.array : array;
	import std.json : parseJSON;

	string json = `[{"name":"seat0","capabilities":3,"focus":7,"devices":[{"identifier":"1:1:AT_Translated_Set_2_keyboard","name":"AT Translated Set 2 keyboard","vendor":1,"product":1,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"1267:5:Elan_Touchpad","name":"Elan Touchpad","vendor":1267,"product":5,"type":"pointer","libinput":{"send_events":"enabled","tap":"enabled","tap_button_map":"lmr","tap_drag":"enabled","tap_drag_lock":"disabled","accel_speed":0.0,"accel_profile":"none","natural_scroll":"disabled","left_handed":"disabled","click_method":"button_areas","middle_emulation":"disabled","scroll_method":"edge","dwt":"enabled"}},{"identifier":"3034:22494:USB2.0_VGA_UVC_WebCam:_USB2.0_V","name":"USB2.0 VGA UVC WebCam: USB2.0 V","vendor":3034,"product":22494,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:3:Sleep_Button","name":"Sleep Button","vendor":0,"product":3,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:5:Lid_Switch","name":"Lid Switch","vendor":0,"product":5,"type":"switch","libinput":{"send_events":"enabled"}},{"identifier":"0:6:Video_Bus","name":"Video Bus","vendor":0,"product":6,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}},{"identifier":"0:1:Power_Button","name":"Power Button","vendor":0,"product":1,"type":"keyboard","xkb_active_layout_name":"English (US)","libinput":{"send_events":"enabled"}}]}]`;
	Seat[] seats = parseJSON(json).arrayNoRef.map!(a => Seat(a)).array;

	assert( seats.length == 1 );
	assert( seats[0].name == "seat0" );
	assert( seats[0].devices.length == 7 );
	assert( seats[0].devices[1].vendor == 1267 );
	assert( seats[0].devices[1].libinput.tap_button_map == "lmr" );
}
