import std.stdio;
import core.thread : Thread;
import core.time : seconds;
import swaywmipc;

void main() {

	auto client = new Client();

	// Toggles fullscreen mode of the active window
	client.send( Command("fullscreen", "toggle") );

	// Subscribe a Lambda function to given Events
	client.subscribe( [EventType.workspace, EventType.window] , (msg) => writefln("%s-event has been triggered",msg.type) );
	scope(exit) client.stopEventListener(); // The first call to subscribe() launches a event listener, which has to be stopped before the program ends.

	// pause main() here, so that you can test some events - e.g. switch the workspace
	Thread.sleep(10.seconds);

	// Toggles fullscreen mode of the active window - our subscribed function prints "window-event has been triggered" to stdout
	client.send( Command("fullscreen", "toggle") );

}
