import std.stdio;
import core.thread : Thread;
import core.time : seconds;
import swaywmipc;

void main() {

	auto client = new Client();

	// Toggles fullscreen mode of the active window
	client.run( "fullscreen", "toggle" );

	writefln( "Configuration contains %d chars.", client.getConfig().length );

	foreach( workspace ; client.getWorkspaces() ) {
		writefln( "Workspace: %s", workspace.name );
	}

	foreach( output ; client.getOutputs() ) {
		writefln( "Output: %s", output.name );
	}

	Node tree = client.getTree();
	writefln( "Tree %s has %d Nodes", tree.name, (tree.nodes.length + tree.floating_nodes.length) );

	foreach( bar_id ; client.getBarConfig() ) {
		BarConfig config = client.getBarConfig( bar_id );
		"Bar '%s' has background.color: rgba(%d,%d,%d, %d)".writefln(
			bar_id,
			config.colors.background.r,
			config.colors.background.g,
			config.colors.background.b,
			config.colors.background.a
		);
	}

	writeln( client.getVersion() );

	foreach( i, bindingMode ; client.getBindingModes() ) {
		writefln( "%d. binding-mode: %s", i,  bindingMode );
	}

	foreach( i, input ; client.getInputs() ) {
		writefln( "%d. Input: '%s'", i, input.name );
	}

	foreach( i, seat ; client.getSeats() ) {
		writefln( "seat '%s' has %d devices", seat.name, seat.devices.length );
	}

	// Subscribe a Lambda function to given Events
	client.subscribe(
		[EventType.input, EventType.window, EventType.tick],
		(msg) {
			writefln("%s-event has been triggered",msg.eventType);
			switch(msg.eventType) {
				case EventType.tick:
					writefln("Ticks Payload: '%s'", msg.payload);
					break;

				default: break;
			}
		}
	);
	scope(exit) client.stopEventListener(); // The first call to subscribe() launches a event listener, which has to be stopped before the program ends.

	// pause main() here, so that you can test some events - e.g. switch the workspace
	Thread.sleep(3.seconds);

	// Triggers a "Tick Event"
	client.sendTick("hello world :)");

	// Toggles fullscreen mode of the active window - our subscribed function prints "window-event has been triggered" to stdout
	client.run( "fullscreen", "toggle" );

}
