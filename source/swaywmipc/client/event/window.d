module swaywmipc.client.event.window;

import swaywmipc.client.event.common;
import swaywmipc.core;

class WindowEvent : Event {
	this() {
		super(PayloadType.window);
	}
}

struct Payload {
	string change;
	Container container;
}

struct Container {

}
