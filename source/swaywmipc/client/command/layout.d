module swaywmipc.client.command.layout;
import swaywmipc.client.command.common;

class Layout : Command {

	this(string[] args) {
		super( "layout", args) ;
	}

	this() { this([]); }

}
