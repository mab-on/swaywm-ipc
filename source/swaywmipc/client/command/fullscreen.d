module swaywmipc.client.command.fullscreen;
import swaywmipc.client.command.common;

class FullscreenCommand : Command {
	this(string[] args) { super( "fullscreen", args); }
	this() { this([]); }
}
