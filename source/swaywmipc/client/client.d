module swaywmipc.client.client;

import swaywmipc.client.message;
import swaywmipc.client.event;
import swaywmipc.core;

import std.stdio;
import std.concurrency;

class Client {
	private Socket cmd_socket;
	private Socket event_socket;

	private Tid event_listener;
	private shared(void function(Message msg)[PayloadType]) functionsByEvent;

	this() {
		import std.process : executeShell;
		import std.string : strip;

		this( "sway --get-socketpath".executeShell.output.strip );
	}

	this(const string socketpath) {
		this.cmd_socket = new Socket(socketpath);
	}

	~this() {
		this.close();
	}

	void close() {
		this.cmd_socket.close();
		this.stopEventListener();
	}

	Response send(Command[] cmd...) {
		Message reply;
		this.cmd_socket.send(cmd.makeMessage());
		this.cmd_socket.receive(reply);
		return Response(reply);
	}

	Response subscribe(Event event , void function(Message msg) fn) {
		return subscribe([event], fn);
	}
	Response subscribe(Event[] events , void function(Message msg) fn) {
		import core.time;
		import std.algorithm : map;
		import std.array : join;
		static import std.socket;

		if( ! this.event_socket ) {
			this.event_socket = new Socket( this.cmd_socket.getPath() );
			this.event_socket.setOption(
				std.socket.SocketOptionLevel.SOCKET,
    			std.socket.SocketOption.RCVTIMEO,
    			500.msecs
			);
		}

		Message subscribe;
		subscribe.type = PayloadType.SUBSCRIBE;
		subscribe.payload = "[" ~ events.map!(e => '"'~e.name()~'"').join(",") ~ "]";

		this.event_socket.send(subscribe);
		Message reply;
		while(!this.event_socket.receive(reply)) {}

		auto response = Response(reply);

		foreach(Event event ; events) {
			this.functionsByEvent[event.type()] = fn;
		}


		this.event_listener = spawn(&listener, cast(shared)(this.event_socket) , this.functionsByEvent);

		return response;
	}

	void stopEventListener() {
		static import std.socket;
		std.concurrency.send(this.event_listener, CancelListener());
		if( this.event_socket && this.event_socket.isAlive() ) {
			this.event_socket.close();
		}
	}

}

private struct CancelListener {}
private void listener(
	shared(Socket) shared_eventSocket,
	shared(void function(Message msg)[PayloadType]) functionsByEvent
) {
	import core.time;
	static import std.socket;

	Socket event_socket = cast()shared_eventSocket;

	bool cancel;
	while(!cancel) {

		Message msg;
		if(event_socket.receive(msg)) {
			if(msg.type in functionsByEvent) {
				functionsByEvent[ cast(PayloadType)msg.type ](msg);
			}
		}
		receiveTimeout(-1.seconds,
			(CancelListener m) {
				cancel = true;
				event_socket.shutdown(std.socket.SocketShutdown.BOTH);
				event_socket.close();
			}
		);

	}
}
