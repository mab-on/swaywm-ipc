module swaywmipc.client.event.workspace;

import swaywmipc.client.event.common;
import swaywmipc.core;

class WorkspaceEvent : Event {
	this() {
		super(PayloadType.workspace);
	}
}

struct payload {

}
