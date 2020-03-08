module swaywmipc.client.command.subscribe;

import swaywmipc.client.command.common;
import swaywmipc.client.event;

class Subscribe : Command {

	this(Event[] events) {
		import std.algorithm : map;
		import std.array : array;
		super( "subscribe", events.map!(e => e.name()).array) ;
	}

}
