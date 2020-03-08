module swaywmipc.client.event.common;

import std.json;
import swaywmipc.core;

class Event {
	private
		PayloadType _type;
		JSONValue _payload;


	this(PayloadType type) {
		this._type = type;
	}

	this(PayloadType type, JSONValue payload) {
		this(type);
		this._payload = payload;
	}

	PayloadType type() {
		return this._type;
	}

	string name() {
		import std.conv : to;
		return this._type.to!string;
	}

	JSONValue payload() {
		return this._payload;
	}
}

Message NewSubscribeMessage(Event[] events) {
	import std.algorithm : map;
	import std.array : join;

	auto msg = Message();
	msg.type = PayloadType.SUBSCRIBE;

	msg.payload = "[" ~ events.map!(e => '"'~e.name()~'"').join(",") ~ "]";

	return msg;
}
