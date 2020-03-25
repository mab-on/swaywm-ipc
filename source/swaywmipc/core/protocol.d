module swaywmipc.core.protocol;

import std.conv : to;
import swaywmipc.core.socket;

enum MAGIC_STRING = "i3-ipc";

enum EventType : uint {
	workspace = 0x80000000,
	mode = 0x80000002,
	window = 0x80000003,
	barconfig_update = 0x80000004,
	binding = 0x80000005,
	shutdown = 0x80000006,
	tick = 0x80000007,
	bar_state_update = 0x80000014,
	input = 0x80000015
}

enum PayloadType : uint {
	RUN_COMMAND = 0,
	GET_WORKSPACES = 1,
	SUBSCRIBE = 2,
	GET_OUTPUTS = 3,
	GET_TREE = 4,
	GET_MARKS = 5,
	GET_BAR_CONFIG = 6,
	GET_VERSION = 7,
	GET_BINDING_MODES = 8,
	GET_CONFIG = 9,
	SEND_TICK = 10,
	SYNC = 11,
	GET_INPUTS = 100,
	GET_SEATS = 101,

	//Events
	workspace = EventType.workspace,
	mode = EventType.mode,
	window = EventType.window,
	barconfig_update = EventType.barconfig_update,
	binding = EventType.binding,
	shutdown = EventType.shutdown,
	tick = EventType.tick,
	bar_state_update = EventType.bar_state_update,
	input = EventType.input
}

struct Message {
	PayloadType type;
	string payload;

	EventType eventType() {
		return cast(EventType)(this.type);
	}
}

ubyte[] serialize(Message msg) {

	uint payload_length = to!uint(msg.payload.length);
	ubyte[] raw;

	raw ~= *cast(ubyte[.MAGIC_STRING.length]*)(.MAGIC_STRING);
	raw ~= *cast(ubyte[uint.sizeof]*)(&payload_length);
	raw ~= *cast(ubyte[uint.sizeof]*)(&msg.type);
	raw ~= *cast(ubyte[]*)(&msg.payload);

	return raw;
}

Message deserialize(ubyte[] bytes) {
	import std.string : assumeUTF;

	if(bytes.length < (.MAGIC_STRING.length + uint.sizeof + uint.sizeof ) ) {/*handle error*/}

	Message m = Message();
	if(.MAGIC_STRING != bytes[0 .. .MAGIC_STRING.length].assumeUTF ) {/*handle error*/}

	m.type = *cast(PayloadType*)(bytes[ .MAGIC_STRING.length+uint.sizeof .. .MAGIC_STRING.length+uint.sizeof+uint.sizeof ]);
	m.payload = bytes[ .MAGIC_STRING.length+uint.sizeof+uint.sizeof .. $].assumeUTF;
	return m;
}

bool isEvent(Message msg) {
	return msg.type >= 0x80000000;
}
